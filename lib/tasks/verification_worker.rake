task :start_worker => :environment do
  pid = fork do
    v = VerificationWorker.new(Redis.new)
    v.start
  end
  Process.detach(pid)
  File.open(Rails.root.to_s + "/tmp/pids/verification_worker.pid", "w+") { |f| f << pid }
end

task :stop_worker => :environment do
  pid = File.open(Rails.root.to_s + "/tmp/pids/verification_worker.pid", "r").read
  Process.kill("TERM", pid.to_i)
end