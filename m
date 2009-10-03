Message-ID: <BAY127-W86F7A1993CDFD2A1971E1E8D10@...512...>
Content-Type: multipart/alternative;
	boundary="_ed2ad318-74cb-4212-b490-903542045ec7_"
From: Jet Dog <jetdog330@...160...>
Date: Sat, 3 Oct 2009 18:10:46 -0400
MIME-Version: 1.0
Subject: [Openvpn-devel] Security Fix Development - Client Mac Addresses Env
 Variable - Want to contribute and/or feedback?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--_ed2ad318-74cb-4212-b490-903542045ec7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello!
(about Security)

My name is Dave.  I'm doing a research/development/implementation and promo=
tion of your openvpn client as part of my University Studies here at Windso=
r, Ontario, Canada.

I have to say, I am absolutely loving OpenVPN.  However, there was one inte=
resting security concern I noticed, which I would like to potentially engag=
e.  As part of the nature of dynamic IP networks, OpenVPN will likely have =
clients sending/receiving arp packets.  It is this exact freedom offered by=
 ARP, which poses a rather dangerous situation for the real networks that O=
penVPN can bridge to, as well as other OpenVPN clients.

This threat goes as follows: openvpn server goes up, offers bridge to physi=
cal lan (say 192.168.5.0, mask 255.255.255.0, gateway 192.168.5.1) - client=
 connects, openvpn server gives client 192.168.5.200 (say we assigned the c=
lients a range of 192.168.5.200 to 192.168.5.254 in the
server.conf).
	-Now the client frequently sends to FF:FF:FF:FF:FF:FF : ARP 192.168.5.1 is=
 at <client's macaddress>, when he tries to arp-poison the gateway.

The problem, is that these arp packets will get through, uncontrolled. Afte=
r a client poisons a physical network, even though OpenVPN will not forward=
 any redirected traffic destined for 192.168.5.1 to <client's mac address>,=
 the poisoned targets on the physical LAN will still try to send their traf=
fic to the openvpn bridge.

What I was wondering, would be if I could engage the possibility of myself =
adding <client's mac address> to the envoronment variables accessible durin=
g the auth-user-pass-verify, client-connect, and client-disconnect scripts.=
  Doing so would allow openvpn users to create connection scripts, so that =
ebtables entries could be added/removed from the kernel or firewall to rest=
rict the flow of potentially evil arp packets.  Example of such a usage bel=
ow:

#Entries similar to below in connect/disconnect script (should use insertio=
ns or similar):
ebtables -A FORWARD -i tap0 -p arp --arp-ip-src $ifconfig_pool_remote_ip --=
arp-mac-src $<client's mac address variable>  -j ACCEPT

#Entries similar to below ran once around startup:
ebtables -A FORWARD -i tap0 -p arp --arp-opcode 1 -j ACCEPT
#drop all other arp replies
ebtables -A FORWARD -i tap0 -p arp -j DROP

As evidenced by the example above, perhaps a <client-mac-addr> environment =
variable would really help users mitigate this security concern - and I wou=
ld like to try to develop it myself,  perhaps for rc21!

Also important, are packets from one openvpn client -- destined to another =
openvpn client -- passed through the server's tap adapter before going to a=
nother client?  For instance, suppose I was a client, and I started saying =
to target FF:FF:FF:FF:FF:FF: 192.168.5.1 is at <my mac address> - Can ebtab=
les entries controlling tap0 stop client-to-client traffic - or does such t=
raffic never leave the openvpn process?  That would also have some bearing =
on how much more security the addition of a <client's mac address> could ge=
nerate for client-to-client interactions.

Hopefully I'll be able to help your team out with developing a fix for this=
 in time for my presentation, if not by identifying the above security conc=
ern.

I am on a deadline, but I look forward to any input! :)
Dave
=20=09=09=20=09=20=20=20=09=09=20=20
_________________________________________________________________
New: Messenger sign-in on the MSN homepage
http://go.microsoft.com/?linkid=3D9677403=

--_ed2ad318-74cb-4212-b490-903542045ec7_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
<pre wrap=3D"">Hello!<br>(about Security)<br><br>My name is Dave.  I'm doin=
g a research/development/implementation and promotion of your openvpn clien=
t as part of my University Studies here at Windsor, Ontario, Canada.<br><br=
>I have to say, I am absolutely loving OpenVPN.  However, there was one int=
eresting security concern I noticed, which I would like to potentially enga=
ge.  As part of the nature of dynamic IP networks, OpenVPN will likely have=
 clients sending/receiving arp packets.  It is this exact freedom offered b=
y ARP, which poses a rather dangerous situation for the real networks that =
OpenVPN can bridge to, as well as other OpenVPN clients.<br><br>This threat=
 goes as follows: openvpn server goes up, offers bridge to physical lan (sa=
y 192.168.5.0, mask 255.255.255.0, gateway 192.168.5.1) - client connects, =
openvpn server gives client 192.168.5.200 (say we assigned the clients a ra=
nge of 192.168.5.200 to 192.168.5.254 in the<br>server.conf).<br>	-Now the =
client frequently sends to FF:FF:FF:FF:FF:FF : ARP 192.168.5.1 is at &lt;cl=
ient's macaddress&gt;, when he tries to arp-poison the gateway.<br><br>The =
problem, is that these arp packets will get through, uncontrolled. After a =
client poisons a physical network, even though OpenVPN will not forward any=
 redirected traffic destined for 192.168.5.1 to &lt;client's mac address&gt=
;, the poisoned targets on the physical LAN will still try to send their tr=
affic to the openvpn bridge.<br><br>What I was wondering, would be if I cou=
ld engage the possibility of myself adding &lt;client's mac address&gt; to =
the envoronment variables accessible during the auth-user-pass-verify, clie=
nt-connect, and client-disconnect scripts.  Doing so would allow openvpn us=
ers to create connection scripts, so that ebtables entries could be added/r=
emoved from the kernel or firewall to restrict the flow of potentially evil=
 arp packets.  Example of such a usage below:<br><br>#Entries similar to be=
low in connect/disconnect script (should use insertions or similar):<br>ebt=
ables -A FORWARD -i tap0 -p arp --arp-ip-src $ifconfig_pool_remote_ip --arp=
-mac-src $&lt;client's mac address variable&gt;  -j ACCEPT<br><br>#Entries =
similar to below ran once around startup:<br>ebtables -A FORWARD -i tap0 -p=
 arp --arp-opcode 1 -j ACCEPT<br>#drop all other arp replies<br>ebtables -A=
 FORWARD -i tap0 -p arp -j DROP<br><br>As evidenced by the example above, p=
erhaps a &lt;client-mac-addr&gt; environment variable would really help use=
rs mitigate this security concern - and I would like to try to develop it m=
yself,  perhaps for rc21!<br><br>Also important, are packets from one openv=
pn client -- destined to another openvpn client -- passed through the serve=
r's tap adapter before going to another client?  For instance, suppose I wa=
s a client, and I started saying to target FF:FF:FF:FF:FF:FF: 192.168.5.1 i=
s at &lt;my mac address&gt; - Can ebtables entries controlling tap0 stop cl=
ient-to-client traffic - or does such traffic never leave the openvpn proce=
ss?  That would also have some bearing on how much more security the additi=
on of a &lt;client's mac address&gt; could generate for client-to-client in=
teractions.<br><br>Hopefully I'll be able to help your team out with develo=
ping a fix for this in time for my presentation, if not by identifying the =
above security concern.<br><br>I am on a deadline, but I look forward to an=
y input! :)<br>Dave<br></pre> 		 	   		  <br /><hr />Less clicking: Hotmail=
 access on the new <a href=3D'http://go.microsoft.com/?linkid=3D9677398' ta=
rget=3D'_new'>MSN homepage.</a></body>
</html>=

--_ed2ad318-74cb-4212-b490-903542045ec7_--

