Message-ID: <20686C579479DC438276A726FE80CDAA01A68140@...281...>
From: satinders@...280...
Subject: RE: [Openvpn-devel] Opvenvpn as gateway
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4A089.4A087B10"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Sep 22 02:46:12 2004
To: vda@...216..., openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4A089.4A087B10
Content-Type: text/plain;
	charset="koi8-r"

Scenario is:

Client    - - - - - - - - - --  Gateway Server -- - - - - - - |
 
|- - - -  Server 1
 
|- - - -  Server 2
 
With OpenVpn :

Client (openvpn)    - - - - TUN- - - - - --  Gateway Server (openvpn) -- - -
- - - - |
 
|- - - -  Server 1 
 
|- - - -  Server 2 

I need to redirect IP packets from Client to Server1 and Server2 through
Gateway depending upon request parameters.
Here Gateway is Apache Proxy with Server 1 and Server 2 as backend/protected
servers. 
Can I route ip packets from Client to backend servers ip through TUN tunnel?
Or
Does openvpn provides hook-ups to filter ip-packets? I can use that to
filter ip packets at TUN of Gateway.


Thanx & Regards,
Satinder Singh



-----Original Message-----
From: Denis Vlasenko [mailto:vda@...216...]
Sent: Wednesday, September 22, 2004 2:02 PM
To: satinders@...280...; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Opvenvpn as gateway


On Wednesday 22 September 2004 09:47, satinders@...280... wrote:
> Can openvpn be used as gateway? I place a openvpn server which forwards
> requests to different servers depending upon messages sent by client.
> Does openvpn provide any feature for this?

What requests and messages? http? ftp? icq?
Provide some details please.
--
vda

------_=_NextPart_001_01C4A089.4A087B10
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dkoi8-r">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>RE: [Openvpn-devel] Opvenvpn as gateway</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Scenario is:</FONT>
</P>

<P><FONT SIZE=3D2>Client&nbsp;&nbsp;&nbsp; - - - - - - - - - --&nbsp; Gatew=
ay Server -- - - - - - - |</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |- - - -&nbsp; Serv=
er 1</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |- - - -&nbsp; Serv=
er 2</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>With OpenVpn :</FONT>
</P>

<P><FONT SIZE=3D2>Client (openvpn)&nbsp;&nbsp;&nbsp; - - - - TUN- - - - - -=
-&nbsp; Gateway Server (openvpn) -- - - - - - - |</FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |- - - -&nbsp; Server 1 </FONT></P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |- - - -&nbsp; Server 2 </FONT></P>

<P><FONT SIZE=3D2>I need to redirect IP packets from Client to Server1 and =
Server2 through Gateway depending upon request parameters.</FONT>
<BR><FONT SIZE=3D2>Here Gateway is Apache Proxy with Server 1 and Server 2 =
as backend/protected servers. </FONT>
<BR><FONT SIZE=3D2>Can I route ip packets from Client to backend servers ip=
 through TUN tunnel?</FONT>
<BR><FONT SIZE=3D2>Or</FONT>
<BR><FONT SIZE=3D2>Does openvpn provides hook-ups to filter ip-packets? I c=
an use that to filter ip packets at TUN of Gateway.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Thanx &amp; Regards,</FONT>
<BR><FONT SIZE=3D2>Satinder Singh</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Denis Vlasenko [<A HREF=3D"mailto:vda@...216...">m=
ailto:vda@...216...</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Wednesday, September 22, 2004 2:02 PM</FONT>
<BR><FONT SIZE=3D2>To: satinders@...280...; openvpn-devel@...282...=
.net</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [Openvpn-devel] Opvenvpn as gateway</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Wednesday 22 September 2004 09:47, satinders@...280...=
 wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; Can openvpn be used as gateway? I place a openvpn s=
erver which forwards</FONT>
<BR><FONT SIZE=3D2>&gt; requests to different servers depending upon messag=
es sent by client.</FONT>
<BR><FONT SIZE=3D2>&gt; Does openvpn provide any feature for this?</FONT>
</P>

<P><FONT SIZE=3D2>What requests and messages? http? ftp? icq?</FONT>
<BR><FONT SIZE=3D2>Provide some details please.</FONT>
<BR><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>vda</FONT>
</P>

</BODY>
</HTML>=

------_=_NextPart_001_01C4A089.4A087B10--

