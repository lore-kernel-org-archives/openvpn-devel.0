Message-ID: <20686C579479DC438276A726FE80CDAA01BC19CC@...281...>
From: satinders@...280...
Subject: RE: [Openvpn-devel] client-server customized session-id
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4AB88.AA3D9100"
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
Date: Wed Oct  6 02:43:30 2004
To: jim@...41..., satinders@...280...
Cc: openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4AB88.AA3D9100
Content-Type: text/plain;
	charset="iso-8859-1"

This session id is not in my control. I want to have some secret (my own
session-id, passed as command line parameter) thats there in each data
message through which I can identify the client.

-----Original Message-----
From: James Yonan [mailto:jim@...41...]
Sent: Wednesday, October 06, 2004 3:00 PM
To: satinders@...280...
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] client-server customized session-id


On Wed, 6 Oct 2004 satinders@...280... wrote:

> Hi,
> 	I am implementing client-server openvpn with following additional
> requirement:
> Client-server should share a secret session-id provided by me while
starting
> client and server. I dont want to keep this session-id in a file on client
> machine. Preferrable client will be started from an applet. This applet
will
> give the session-id to openvpn instance. This session-id will be sent in
> each request from client to server. This session-id will be used to find
out
> whether this is legitimate client instance or not. It will also be used to
> check the client'access policy for particular service. Its a kind of
> firewall with specific permissions for each client for accessing servers.

OpenVPN already has a session ID.  See session_id.c.

As far as checking access policies, there are already several ways of 
doing this.  In particular, see --client-connect and --learn-address.
 
James

------_=_NextPart_001_01C4AB88.AA3D9100
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>RE: [Openvpn-devel] client-server customized session-id</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>This session id is not in my control. I want to have some=
 secret (my own session-id, passed as command line parameter) thats there i=
n each data message through which I can identify the client.</FONT></P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: James Yonan [<A HREF=3D"mailto:jim@...41...">mailt=
o:jim@...41...</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Wednesday, October 06, 2004 3:00 PM</FONT>
<BR><FONT SIZE=3D2>To: satinders@...280...</FONT>
<BR><FONT SIZE=3D2>Cc: openvpn-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [Openvpn-devel] client-server customized se=
ssion-id</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Wed, 6 Oct 2004 satinders@...280... wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Hi,</FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am implementing cl=
ient-server openvpn with following additional</FONT>
<BR><FONT SIZE=3D2>&gt; requirement:</FONT>
<BR><FONT SIZE=3D2>&gt; Client-server should share a secret session-id prov=
ided by me while starting</FONT>
<BR><FONT SIZE=3D2>&gt; client and server. I dont want to keep this session=
-id in a file on client</FONT>
<BR><FONT SIZE=3D2>&gt; machine. Preferrable client will be started from an=
 applet. This applet will</FONT>
<BR><FONT SIZE=3D2>&gt; give the session-id to openvpn instance. This sessi=
on-id will be sent in</FONT>
<BR><FONT SIZE=3D2>&gt; each request from client to server. This session-id=
 will be used to find out</FONT>
<BR><FONT SIZE=3D2>&gt; whether this is legitimate client instance or not. =
It will also be used to</FONT>
<BR><FONT SIZE=3D2>&gt; check the client'access policy for particular servi=
ce. Its a kind of</FONT>
<BR><FONT SIZE=3D2>&gt; firewall with specific permissions for each client =
for accessing servers.</FONT>
</P>

<P><FONT SIZE=3D2>OpenVPN already has a session ID.&nbsp; See session_id.c.=
</FONT>
</P>

<P><FONT SIZE=3D2>As far as checking access policies, there are already sev=
eral ways of </FONT>
<BR><FONT SIZE=3D2>doing this.&nbsp; In particular, see --client-connect an=
d --learn-address.</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>James</FONT>
</P>

</BODY>
</HTML>=

------_=_NextPart_001_01C4AB88.AA3D9100--

