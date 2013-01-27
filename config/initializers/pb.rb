require 'pb'

PB.configure do |passbook|
  passbook.wwdc_cert = "#{Rails.root}/certs/WWDR.pem"
  passbook.p12_key = "#{Rails.root}/certs/passkey.pem"
  passbook.p12_certificate = "#{Rails.root}/certs/passcertificate.pem"
  passbook.p12_password = '12345'
end
