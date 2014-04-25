require 'rspec'
require 'selenium-webdriver'
require 'json'
require 'rest_client'

APP_PATH = 'sauce-storage:TestApp.zip'
SAUCE_USERNAME = 'demian1411'
SAUCE_ACCESS_KEY = '66265fac-0375-48ba-bbce-3f9c2246f3ad'

# This is the test itself
describe "Computation" do
  before(:each) do
    @driver = Selenium::WebDriver.for(
      :remote, 
      :desired_capabilities => desired_caps, 
      :url => server_url
    )
  end

  after(:each) do
    # Get the success by checking for assertion exceptions,
    # and log them against the job, which is exposed by the session_id
    job_id = @driver.send(:bridge).session_id
    update_job_success(job_id, example.exception.nil?)
    @driver.quit
  end

  it "should appear HelloWorld" do
    @driver.find_elements(:tag_name, 'text')[0].text.should eq ""
    @driver.find_element(:name, "Say Hi").click
    @driver.find_elements(:tag_name, 'text')[0].text.should eq "Hello World!"
  end
end

def desired_caps
  {
      'browserName' => '',
      'platform' => 'Mac 10.8',
      'version' => '7.1',
      'device' => 'iPhone Simulator',
      'app' => APP_PATH,
      'name' => 'Ruby Example for Appium',
  }
end

def auth_details
  un = SAUCE_USERNAME
  pw = SAUCE_ACCESS_KEY
  
  unless un && pw
    STDERR.puts <<-EOF
      Your SAUCE_USERNAME or SAUCE_ACCESS_KEY environment variables 
      are empty or missing.
      
      You need to set these values to your Sauce Labs username and access
      key, respectively.

      If you don't have a Sauce Labs account, you can get one for free at
      http://www.saucelabs.com/signup
    EOF

    exit
  end
  return "#{un}:#{pw}"
end

def server_url
  "http://demian1411:66265fac-0375-48ba-bbce-3f9c2246f3ad@ondemand.saucelabs.com:80/wd/hub"
end

def rest_jobs_url
  "https://#{auth_details}@saucelabs.com/rest/v1/#{SAUCE_USERNAME}/jobs"
end

# Because WebDriver doesn't have the concept of test failure, use the Sauce
# Labs REST API to record job success or failure
def update_job_success(job_id, success)
    RestClient.put "#{rest_jobs_url}/#{job_id}", {"passed" => success}.to_json, :content_type => :json
end