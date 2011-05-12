task :start_worker => :environment do
  pid = fork do
    v = VerificationWorker.new
    v.start
  end
  Process.detach(pid)
  File.open(Rails.root + "/tmp/pids/verification_worker.pid", "w+") { |f| f << pid }
end

task :stop_worker => :environment do
  pid = File.open(Rails.root + "/tmp/pids/verification_worker.pid", "w+").read
  Process.kill("TERM", pid)
end