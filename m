From: Russell Morris <openvpn@...1315...>
Date: Sun, 08 Jul 2012 07:38:24 -0500
Message-id: <1341751104781975500@...1315...>
In-reply-to: <1341526693716731500@...1315...>
References: <1341526693716731500@...1315...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=3119788273930813440755612565447216755598=axigen==="
Subject: Re: [Openvpn-devel] Connection Bug / Issue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=3119788273930813440755612565447216755598=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

FYI, a bit more debugging ... it seems that if the server and client are se=
t up for tap, then I have the issue below (client crashing on Windows). But=
 if they are both set up for tun ... it works fine.

=20

... Russell



On Thu, 07/05/2012 05:18 PM, Russell Morris <openvpn@...1315...> wrote:


>=20
Hi,
>=20
> I have an issue running OpenVPN 2.3 (occurs with both Alpha 1 and 2, but =
likely earlier versions I'm guessing). I can connect to a Linux server just=
 fine, but when I try to connect to OpenVPN embedded in my router (Tomato f=
irmware, using OpenVPN 2.2.2), the client (on Windows) crashes (and the app=
lication exits) on connect. Here is what happens in the log right before th=
e client aborts and crashes,
>=20
> Thu Jul 05 17:13:49 2012 MANAGEMENT: >STATE:1341526429,GET_CONFIG,,,
> Thu Jul 05 17:13:51 2012 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D=
1)
> Thu Jul 05 17:13:51 2012 PUSH: Received control message: 'PUSH_REPLY,rout=
e-gateway dhcp,ping 15,ping-restart 60'
> Thu Jul 05 17:13:51 2012 OPTIONS IMPORT: timers and/or timeouts modified
> Thu Jul 05 17:13:51 2012 OPTIONS IMPORT: route-related options modified
> Thu Jul 05 17:13:51 2012 open_tun, tt->ipv6=3D0
> Thu Jul 05 17:13:51 2012 TAP-WIN32 device [Local Area Connection 2] opene=
d: \\.\Global\{47E4A2F0-3A09-454C-A5A0-A5327B8D843E}.tap
> Thu Jul 05 17:13:51 2012 TAP-Windows Driver Version 9.9=20
> Thu Jul 05 17:13:51 2012 Successful ARP Flush on interface [21] {47E4A2F0=
-3A09-454C-A5A0-A5327B8D843E}
>=20
> BTW, if I don't run the Windows GUI as Administrator, here is what happen=
s,
>=20
> Thu Jul 05 17:19:19 2012 MANAGEMENT: >STATE:1341526759,GET_CONFIG,,,
> Thu Jul 05 17:19:20 2012 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D=
1)
> Thu Jul 05 17:19:20 2012 PUSH: Received control message: 'PUSH_REPLY,rout=
e-gateway dhcp,ping 15,ping-restart 60'
> Thu Jul 05 17:19:20 2012 OPTIONS IMPORT: timers and/or timeouts modified
> Thu Jul 05 17:19:20 2012 OPTIONS IMPORT: route-related options modified
> Thu Jul 05 17:19:20 2012 open_tun, tt->ipv6=3D0
> Thu Jul 05 17:19:20 2012 TAP-WIN32 device [Local Area Connection 2] opene=
d: \\.\Global\{47E4A2F0-3A09-454C-A5A0-A5327B8D843E}.tap
> Thu Jul 05 17:19:20 2012 TAP-Windows Driver Version 9.9=20
> Thu Jul 05 17:19:20 2012 NOTE: FlushIpNetTable failed on interface [21] {=
47E4A2F0-3A09-454C-A5A0-A5327B8D843E} (status=3D5) : Access is denied.=20
>=20
> Thoughts?
>=20
> Thanks!
>=20
> ... Russell
>=20
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussions=
=20
> will include endpoint security, mobile security and the latest in malware=
=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=

--===axigen=3119788273930813440755612565447216755598=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>FYI, a bit more debugging ... it seems that if the server and cli=
ent are set up for tap, then I have the issue below (client crashing on Win=
dows). But if they are both set up for tun ... it works fine.</P>
<P>&nbsp;</P>
<P>... Russell</P>
<P><BR><BR>On Thu, 07/05/2012 05:18 PM, Russell&nbsp;Morris&nbsp;&lt;openvp=
n@...1315...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">Hi,<BR><BR>I have an iss=
ue running OpenVPN 2.3 (occurs with both Alpha 1 and 2, but likely earlier =
versions I'm guessing). I can connect to a Linux server just fine, but when=
 I try to connect to OpenVPN embedded in my router (Tomato firmware, using =
OpenVPN 2.2.2), the client (on Windows) crashes (and the application exits)=
 on connect. Here is what happens in the log right before the client aborts=
 and crashes,<BR><BR>Thu Jul 05 17:13:49 2012 MANAGEMENT: &gt;STATE:1341526=
429,GET_CONFIG,,,<BR>Thu Jul 05 17:13:51 2012 SENT CONTROL [server]: 'PUSH_=
REQUEST' (status=3D1)<BR>Thu Jul 05 17:13:51 2012 PUSH: Received control me=
ssage: 'PUSH_REPLY,route-gateway dhcp,ping 15,ping-restart 60'<BR>Thu Jul 0=
5 17:13:51 2012 OPTIONS IMPORT: timers and/or timeouts modified<BR>Thu Jul =
05 17:13:51 2012 OPTIONS IMPORT: route-related options modified<BR>Thu Jul =
05 17:13:51 2012 open_tun, tt-&gt;ipv6=3D0<BR>Thu Jul 05 17:13:51 2012 TAP-=
WIN32 device [Local Area Connection 2] opened: \\.\Global\{47E4A2F0-3A09-45=
4C-A5A0-A5327B8D843E}.tap<BR>Thu Jul 05 17:13:51 2012 TAP-Windows Driver Ve=
rsion 9.9 <BR>Thu Jul 05 17:13:51 2012 Successful ARP Flush on interface [2=
1] {47E4A2F0-3A09-454C-A5A0-A5327B8D843E}<BR><BR>BTW, if I don't run the Wi=
ndows GUI as Administrator, here is what happens,<BR><BR>Thu Jul 05 17:19:1=
9 2012 MANAGEMENT: &gt;STATE:1341526759,GET_CONFIG,,,<BR>Thu Jul 05 17:19:2=
0 2012 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)<BR>Thu Jul 05 17:=
19:20 2012 PUSH: Received control message: 'PUSH_REPLY,route-gateway dhcp,p=
ing 15,ping-restart 60'<BR>Thu Jul 05 17:19:20 2012 OPTIONS IMPORT: timers =
and/or timeouts modified<BR>Thu Jul 05 17:19:20 2012 OPTIONS IMPORT: route-=
related options modified<BR>Thu Jul 05 17:19:20 2012 open_tun, tt-&gt;ipv6=
=3D0<BR>Thu Jul 05 17:19:20 2012 TAP-WIN32 device [Local Area Connection 2]=
 opened: \\.\Global\{47E4A2F0-3A09-454C-A5A0-A5327B8D843E}.tap<BR>Thu Jul 0=
5 17:19:20 2012 TAP-Windows Driver Version 9.9 <BR>Thu Jul 05 17:19:20 2012=
 NOTE: FlushIpNetTable failed on interface [21] {47E4A2F0-3A09-454C-A5A0-A5=
327B8D843E} (status=3D5) : Access is denied. <BR><BR>Thoughts?<BR><BR>Thank=
s!<BR><BR>... Russell<BR><BR>----------------------------------------------=
--------------------------------<BR>Live Security Virtual Conference<BR>Exc=
lusive live event will cover all the ways today's security and <BR>threat l=
andscape has changed and how IT managers can respond. Discussions <BR>will =
include endpoint security, mobile security and the latest in malware <BR>th=
reats. <A href=3D"http://server.home:8080/redir.hsp?url=3D%68%74%74%70%3A%2=
F%2F%77%77%77%2E%61%63%63%65%6C%61%63%6F%6D%6D%2E%63%6F%6D%2F%6A%61%77%2F%7=
3%66%72%6E%6C%30%34%32%34%32%30%31%32%2F%31%31%34%2F%35%30%31%32%32%32%36%3=
3%2F" target=3D_blank>http://www.accelacomm.com/jaw/sfrnl04242012/114/50122=
263/</A><BR>_______________________________________________<BR>Openvpn-deve=
l mailing list<BR><A href=3D"mailto:Openvpn-devel@lists.sourceforge.net" ta=
rget=3D_blank>Openvpn-devel@lists.sourceforge.net</A><BR><A href=3D"http://=
server.home:8080/redir.hsp?url=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E=
%73%6F%75%72%63%65%66%6F%72%67%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73=
%74%69%6E%66%6F%2F%6F%70%65%6E%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>=
https://lists.sourceforge.net/lists/listinfo/openvpn-devel</A><BR></DIV></B=
LOCKQUOTE></body></html>=

--===axigen=3119788273930813440755612565447216755598=axigen===--


