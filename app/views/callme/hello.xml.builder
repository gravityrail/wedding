xml.instruct!
xml.Response do
    xml.Gather(:action => '/callme/step1.xml', :numDigits => 1) do
      xml.Say "Welcome to the Wedding Quiz. I am about to ask you a series of questions."   
      xml.Say "At the end of this quiz you will receive a special prize." 
      xml.Say "When you are ready to proceed, press 1."
    end
end