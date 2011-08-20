xml.instruct!
xml.Response do
  xml.Say "Please say your full name. For example, say "
  xml.Say "Kellea Miller", :voice => 'woman'
  xml.Say "then press '1' to continue."
  xml.Say "Por favor, diga su nombre completo. Por ejemplo, decir ", :language => 'es'
  xml.Say "El kellea el molinero.", :voice => 'woman', :language => 'es'
  xml.Say "a continuación, pulse 1 para continuar.", :language => 'es'
  xml.Record(:action => '/callme/step2.xml')
end