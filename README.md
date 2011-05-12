Signup App
====

Signup App is a test Rails 3 application that handles signup information.  It uses forms and has a REST API.

Prerequisites
----

- MySQL
- Redis
- Ruby 1.9 (1.8 not tested, mileage may vary)

Installation
----

To get Signup App running after cloning the repository, you need to create your `database.yml` file.  One is not checked in for security reasons.  After that, run:

```
	bundle install
	rake db:create db:migrate
	rails s
```

Features
----

- Signup App contains basic functionality for CRUD on Signups.  You can access this via /accounts/
- Account Verification.  Accounts upon signup default to unverified, backed by a Redis datastore to process
- Verification Worker.  This can be accessed directly or started as a daemon rake task.

VerificationWorker
----

VerificationWorker is a worker that can be used to help process verification of signups as a background job.  The code is contained in `app/workers/verification_worker.rb` and has a simple process mechanism.  

However, the real power comes in turning it into a daemonized process to continuously listen for accounts added to the queue.  To do this, run `rake start_worker` (code in `lib/tasks/verification_worker.rake` for details) to get it operational.  It will listen to the same Redis connection Queue uses.  If you are done with your worker, simply run `rake stop_worker`


Testing
----

Signup App is tested with RSpec-Rails 2.5.0.  To run the tests, make sure you have installed the test group in bundler and run `rspec spec/` to run all the tests.