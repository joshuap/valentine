require 'sinatra'
require 'sqlite3'

DB = SQLite3::Database.new( "db/sms.db" )

get '/' do
  @messages = DB.execute( "select strftime('%Y-%m', date, 'unixepoch'), text, flags from message m0 where address = '#{ENV['ADDRESS']}'" ).inject({}) do |h, r|
    month = r.shift ; h[month] ||= [] ; h[month] << r ; h
  end
  haml :index, :format => :html5
end

__END__

@@ layout
%html
  %head
    %title Happy Valentine's Day
    %meta{name: 'viewport', content: 'width=device-width'}/
    :css
      html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video { border:0; font-size:100%; font:inherit; vertical-align:baseline; margin:0; padding:0; } article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section { display:block; } body { line-height:1; } ol,ul { list-style:none; } blockquote,q { quotes:none; } blockquote:before,blockquote:after,q:before,q:after { content:none; } table { border-collapse:collapse; border-spacing:0; }
      body { padding: 0 15px; }
      #container { width: 100%; max-width: 500px; margin: 0 auto; text-align: center; }
      h1 { margin-top: 2.5em; font-size: 2em; color: #333; }
      h2 { font-size: 1.5em; color: #666; }
      h3 { margin: 0.5em 0; font-size: 1.2em; color: #999; }
      h2, ul.messages li { margin-bottom: 1em; padding-bottom: 1em; border-bottom: 1px dotted #CCC; }
      h2 { border-bottom-color: #666; margin: 2em 0 1em 0; padding-bottom: 0.5em; }
      p { color: #222; line-height: 1.5em; }
  %body
    #container
      %h1 ~ You and Me ~
      = yield

@@ index
- @messages.each do |month, messages|
  %h2= month
  %ul{:class => [:messages, month]}
    - for message in messages
      %li
        %h3= %[#{message[1] == 2 ? 'You' : 'Me'}:]
        %p= message[0]