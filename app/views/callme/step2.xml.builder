xml.instruct!
xml.Response do
  xml.Play @recordingurl
  xml.Say "this is just for you", :voice => 'woman'
  xml.Play @rickurl
end