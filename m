Message-ID: <20686C579479DC438276A726FE80CDAA01BC1955@...281...>
From: satinders@...280...
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4AB73.E1851300"
Subject: [Openvpn-devel] client-server customized session-id
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
Date: Wed Oct  6 00:13:14 2004
To: openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4AB73.E1851300
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
	I am implementing client-server openvpn with following additional
requirement:
Client-server should share a secret session-id provided by me while starting
client and server. I dont want to keep this session-id in a file on client
machine. Preferrable client will be started from an applet. This applet will
give the session-id to openvpn instance. This session-id will be sent in
each request from client to server. This session-id will be used to find out
whether this is legitimate client instance or not. It will also be used to
check the client'access policy for particular service. Its a kind of
firewall with specific permissions for each client for accessing servers.

For this I am planning to add a new structure in place of "struct buffer" :

new_struct_buffer {
	my_ses_type my_ses; //may be int, supplied through command line
	struct buffer buf;  //existing struct buffer
	length_type len;    //length of new_struct_buffer
}

This structure will be written and read in tunnel socket in place of struct
buffer. my_ses will be read from the messages and used for verfying the
client. I want to add my_ses before anything in order to validate it first
and then process rest of the packet.

I have seen one more structure "struct options" which is incldued in
messages between client and server but I am not sure that its always there
in all data exchange.

There is also need to maintain valid session-ids on server-side for veryfing
client messages.

Please provide me feedback on this solution. In case anybody has already
implemented this feature, please share it.
	
I suggest openvpn should implement hooks just like apache server for
adding/modifying functionality. This will make openvpn easy to adapt.

Regards,
Satinder Singh


-----Original Message-----
From: Mathias Sundman [mailto:mathias@...209...]
Sent: Wednesday, October 06, 2004 11:22 AM
To: satinders@...280...
Cc: openvpn-devel@lists.sourceforge.net
Subject: RE: [Openvpn-devel] Same IP subnet on both sides (was: Pass log
and passphrase between OpenVPN...)


On Wed, 6 Oct 2004 satinders@...280... wrote:

Hi Satinder,

Please don't "hijack" a thread like that. Start a new topic if your post 
is un-related to the other current threads.

> Hi,
> 	Currently openvpn demands that in client-server scenario, private
> IPs should not clash with other machines. What if a client with IP
10.19.0.5
> sitting in an ISP network (e.g. internet cafe) is there and server tries
to
> assign 10.19.0.5 to this machine. Also there are other machines on
10.19.0.0
> network on ISP side which client wants to access. In this scenario client
> will not be able to access other 10.19.0.0. machines if openvpn is
started.

True. This is one of the problems with using private IP addresses 
(RFC1918) that is becomming bigger and bigger while VPNs are becomming 
more and more popular.

When setting up a VPN you MUST take into consideration that the IP subnets 
you use on and behind the server must not be used as the local network by 
any of the clients connecting to your server.


> Do we have any mechanism through which client can find out which 10.19.0.0
> IP is free and then can send request to server to assign this specific IP
to
> me? And also it can set the routing itself.

No.


> If this is not the right group to post this type of query then kindly
> suggest me the right one.

I think openvpn-users would have been more appropriate, if you are not 
considering developing any new features...

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail

------_=_NextPart_001_01C4AB73.E1851300
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>client-server customized session-id </TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi,</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>I am implemen=
ting client-server openvpn with following additional requirement:</FONT>
<BR><FONT SIZE=3D2>Client-server should share a secret session-id provided =
by me while starting client and server. I dont want to keep this session-id=
 in a file on client machine. Preferrable client will be started from an ap=
plet. This applet will give the session-id to openvpn instance. This sessio=
n-id will be sent in each request from client to server. This session-id wi=
ll be used to find out whether this is legitimate client instance or not. I=
t will also be used to check the client'access policy for particular servic=
e. Its a kind of firewall with specific permissions for each client for acc=
essing servers.</FONT></P>

<P><FONT SIZE=3D2>For this I am planning to add a new structure in place of=
 &quot;struct buffer&quot; :</FONT>
</P>

<P><FONT SIZE=3D2>new_struct_buffer {</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>my_ses_type m=
y_ses; //may be int, supplied through command line</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>struct buffer=
 buf;&nbsp; //existing struct buffer</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>length_type l=
en;&nbsp;&nbsp;&nbsp; //length of new_struct_buffer</FONT>
<BR><FONT SIZE=3D2>}</FONT>
</P>

<P><FONT SIZE=3D2>This structure will be written and read in tunnel socket =
in place of struct buffer. my_ses will be read from the messages and used f=
or verfying the client. I want to add my_ses before anything in order to va=
lidate it first and then process rest of the packet.</FONT></P>

<P><FONT SIZE=3D2>I have seen one more structure &quot;struct options&quot;=
 which is incldued in messages between client and server but I am not sure =
that its always there in all data exchange.</FONT></P>

<P><FONT SIZE=3D2>There is also need to maintain valid session-ids on serve=
r-side for veryfing client messages.</FONT>
</P>

<P><FONT SIZE=3D2>Please provide me feedback on this solution. In case anyb=
ody has already implemented this feature, please share it.</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2>I suggest openvpn should implement hooks just like apach=
e server for adding/modifying functionality. This will make openvpn easy to=
 adapt.</FONT></P>

<P><FONT SIZE=3D2>Regards,</FONT>
<BR><FONT SIZE=3D2>Satinder Singh</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Mathias Sundman [<A HREF=3D"mailto:mathias@...291...=
..">mailto:mathias@...209...</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Wednesday, October 06, 2004 11:22 AM</FONT>
<BR><FONT SIZE=3D2>To: satinders@...280...</FONT>
<BR><FONT SIZE=3D2>Cc: openvpn-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [Openvpn-devel] Same IP subnet on both side=
s (was: Pass log</FONT>
<BR><FONT SIZE=3D2>and passphrase between OpenVPN...)</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Wed, 6 Oct 2004 satinders@...280... wrote:</FONT>
</P>

<P><FONT SIZE=3D2>Hi Satinder,</FONT>
</P>

<P><FONT SIZE=3D2>Please don't &quot;hijack&quot; a thread like that. Start=
 a new topic if your post </FONT>
<BR><FONT SIZE=3D2>is un-related to the other current threads.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Hi,</FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Currently openvpn de=
mands that in client-server scenario, private</FONT>
<BR><FONT SIZE=3D2>&gt; IPs should not clash with other machines. What if a=
 client with IP 10.19.0.5</FONT>
<BR><FONT SIZE=3D2>&gt; sitting in an ISP network (e.g. internet cafe) is t=
here and server tries to</FONT>
<BR><FONT SIZE=3D2>&gt; assign 10.19.0.5 to this machine. Also there are ot=
her machines on 10.19.0.0</FONT>
<BR><FONT SIZE=3D2>&gt; network on ISP side which client wants to access. I=
n this scenario client</FONT>
<BR><FONT SIZE=3D2>&gt; will not be able to access other 10.19.0.0. machine=
s if openvpn is started.</FONT>
</P>

<P><FONT SIZE=3D2>True. This is one of the problems with using private IP a=
ddresses </FONT>
<BR><FONT SIZE=3D2>(RFC1918) that is becomming bigger and bigger while VPNs=
 are becomming </FONT>
<BR><FONT SIZE=3D2>more and more popular.</FONT>
</P>

<P><FONT SIZE=3D2>When setting up a VPN you MUST take into consideration th=
at the IP subnets </FONT>
<BR><FONT SIZE=3D2>you use on and behind the server must not be used as the=
 local network by </FONT>
<BR><FONT SIZE=3D2>any of the clients connecting to your server.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>&gt; Do we have any mechanism through which client can fi=
nd out which 10.19.0.0</FONT>
<BR><FONT SIZE=3D2>&gt; IP is free and then can send request to server to a=
ssign this specific IP to</FONT>
<BR><FONT SIZE=3D2>&gt; me? And also it can set the routing itself.</FONT>
</P>

<P><FONT SIZE=3D2>No.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>&gt; If this is not the right group to post this type of =
query then kindly</FONT>
<BR><FONT SIZE=3D2>&gt; suggest me the right one.</FONT>
</P>

<P><FONT SIZE=3D2>I think openvpn-users would have been more appropriate, i=
f you are not </FONT>
<BR><FONT SIZE=3D2>considering developing any new features...</FONT>
</P>

<P><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>________________________________________________________=
_____</FONT>
<BR><FONT SIZE=3D2>Mathias Sundman&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (^)&nbsp;&nbs=
p; ASCII Ribbon Campaign</FONT>
<BR><FONT SIZE=3D2>OpenVPN GUI for Windows&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; X&nbsp;&nbsp;&nbsp; NO HTML/RTF in e-mail</FONT>
<BR><FONT SIZE=3D2><A HREF=3D"http://www.nilings.se/openvpn" TARGET=3D"_bla=
nk">http://www.nilings.se/openvpn</A>&nbsp;&nbsp;&nbsp; / \&nbsp;&nbsp; NO =
Word docs in e-mail</FONT>
</P>

</BODY>
</HTML>=

------_=_NextPart_001_01C4AB73.E1851300--

