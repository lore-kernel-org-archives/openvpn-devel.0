Date: Thu, 19 Jul 2007 07:28:24 -0700 (PDT)
From: tiger king <tigerking156@...109...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1518297072-1184855304=:9057"
Message-ID: <427742.9057.qm@...1039...>
Subject: Re: [Openvpn-devel] functions remote in VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Noam Rathaus <noamr@...117...>
Cc: openvpn-devel@lists.sourceforge.net

--0-1518297072-1184855304=:9057
Content-Type: text/plain; charset=ascii

Hi

I worked 2 days in the source code but I can't find exactly what I need. Sorry if I "disturb"   you a bit but can you help me find the function which really do:

"When some packets (come from a source) reach the card internet , this function will forward the packets to the virtual card so that we can have a connection between 2 virtual cards"

the command in OpenVpn is --remote @ip_source

(at first the question was: how can 2 clients "ping" each other with their IP on virtuals cards ? ")

Thanks a lot

Best regard,





----- Original Message ----
From: Noam Rathaus <noamr@...117...>
To: openvpn-devel@lists.sourceforge.net
Cc: tiger king <tigerking156@...109...>
Sent: Wednesday, July 11, 2007 11:31:33 AM
Subject: Re: [Openvpn-devel] functions remote in VPN

Hi,

(I am referring to --remote used to specify more than one remote host/port)

You need to look up references to remote_list, it is filled by code found in 
options.c and is handled by code found in socket.c

Hope this helps.

On Tuesday 10 July 2007 18:10:28 tiger king wrote:
> I want to search one function in the source code of VPN which really do the
> command "--remote " but I just can't find.
>
> Would you please help me a bit?
>
> Thanks a lot :)
>
>
>
>
>
>
> ___________________________________________________________________________
>_________ Don't pick lemons.
> See all the new 2007 cars at Yahoo! Autos.
> http://autos.yahoo.com/new_cars.html



-- 
  Noam Rathaus
  CTO
  1616 Anderson Rd.
  McLean, VA 22102
  Tel: 703.286.7725 extension 105
  Fax: 888.667.7740
  noamr@...117...
  http://www.beyondsecurity.com







       
____________________________________________________________________________________
Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC
--0-1518297072-1184855304=:9057
Content-Type: text/html; charset=ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">Hi<br><br>I worked 2 days in the source code but I can't find exactly what I need. Sorry if I "disturb"&nbsp;  you a bit but can you help me find the function which really do:<br><br>"When some packets (come from a source) reach the card internet , this function will forward the packets to the virtual card so that we can have a connection between 2 virtual cards"<br><br>the command in OpenVpn is --remote @ip_source<br><br>(at first the question was: how can 2 clients "ping" each other with their IP on virtuals cards ? ")<br><br>Thanks a lot<br><br>Best regard,<br><br><br><br><br><br><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;">----- Original Message ----<br>From: Noam Rathaus
 &lt;noamr@...117...&gt;<br>To: openvpn-devel@lists.sourceforge.net<br>Cc: tiger king &lt;tigerking156@...109...&gt;<br>Sent: Wednesday, July 11, 2007 11:31:33 AM<br>Subject: Re: [Openvpn-devel] functions remote in VPN<br><br><div>Hi,<br><br>(I am referring to --remote used to specify more than one remote host/port)<br><br>You need to look up references to remote_list, it is filled by code found in <br>options.c and is handled by code found in socket.c<br><br>Hope this helps.<br><br>On Tuesday 10 July 2007 18:10:28 tiger king wrote:<br>&gt; I want to search one function in the source code of VPN which really do the<br>&gt; command "--remote " but I just can't find.<br>&gt;<br>&gt; Would you please help me a bit?<br>&gt;<br>&gt; Thanks a lot :)<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; ___________________________________________________________________________<br>&gt;_________ Don't pick lemons.<br>&gt; See all the new 2007 cars at Yahoo!
 Autos.<br>&gt; <a target="_blank" href="http://autos.yahoo.com/new_cars.html">http://autos.yahoo.com/new_cars.html</a><br><br><br><br>-- <br>&nbsp; Noam Rathaus<br>&nbsp; CTO<br>&nbsp; 1616 Anderson Rd.<br>&nbsp; McLean, VA 22102<br>&nbsp; Tel: 703.286.7725 extension 105<br>&nbsp; Fax: 888.667.7740<br>&nbsp; noamr@...117...<br>&nbsp; <a target="_blank" href="http://www.beyondsecurity.com">http://www.beyondsecurity.com</a><br></div></div><br></div></div><br>
      <hr size=1>Moody friends. Drama queens. Your life? Nope! - their life, your story.<br> <a href="http://us.rd.yahoo.com/evt=48224/*http://sims.yahoo.com/">Play Sims Stories at Yahoo! Games. </a></body></html>
--0-1518297072-1184855304=:9057--

