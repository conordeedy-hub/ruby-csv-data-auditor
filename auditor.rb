require 'csv'

SAMPLE_EXPORT = <<~CSV
  record_id,department,system_name,uptime_pct,status
  101,Finance,ERP-Core,99.98,OK
  102,Operations,,98.40,WARNING
  103,IT-Security,Auth-Gateway,99.99,OK
  104,HR,Portal-Web,-5.0,ERROR
  105,Analytics,Warehouse-DB,99.50,OK
  106,Service-Dispatch,Ticket-API,104.2,ERROR
CSV

def audit_csv_records(csv_data)
  anomalies = []
  total_scanned = 0

  CSV.parse(csv_data, headers: true) do |row|
    total_scanned += 1
    id = row['record_id']
    system = row['system_name'].to_s.strip
    uptime = row['uptime_pct'].to_f

    anomalies << "Record ##{id} (#{row['department']}): Missing required system_name" if system.empty?
    if uptime < 0.0 || uptime > 100.0
      anomalies << "Record ##{id} (#{system.empty? ? 'Unknown' : system}): Out-of-bounds uptime (#{uptime}%)"
    end
  end

  puts "=== Automated System CSV Audit Report ==="
  puts "Total Records Scanned : #{total_scanned}"
  puts "Anomalies Detected    : #{anomalies.length}"
  puts "-----------------------------------------"
  anomalies.each { |msg| puts " [!] #{msg}" }
end

audit_csv_records(SAMPLE_EXPORT)
