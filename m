From: Russell Morris <openvpn@...1315...>
Date: Thu, 30 Jun 2011 20:32:20 -0500
Message-id: <1309483940094924500@...1315...>
In-reply-to: <BANLkTinOcDAP-YrMoPmokEPLbffbwCDwJA@...278...>
References: <1309385816281570500@...1315...>
	<BANLkTinOcDAP-YrMoPmokEPLbffbwCDwJA@...278...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=8137203016548745088618398331640644769469=axigen==="
Subject: Re: [Openvpn-devel] [Openvpn-users] DNS Issue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Brett Serkez <bserkez@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=8137203016548745088618398331640644769469=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Brett,

=20

Sorry, a bit confused here - why are you referring to OpenDNS?

=20

Thanks,

... Russell

=20



On Thu, 06/30/2011 07:20 AM, Brett Serkez <bserkez@...277...> wrote:


> The problem is that OpenDNS always provides a response which defeats any =
local name resolution.
>=20
> Under advanced settings, see:  'Exceptions for VPN users' which allows yo=
u to override the above behavior in specific cases.
>=20
> I had everything working with WindowsXP, I found that Windows 7 used a di=
fferent settings under:  'Connection-specific DNS Suffix' which I had to ad=
d to the OpenDNS advanced settings.
>=20
> Brett
>=20
>=20
>=20
On Wed, Jun 29, 2011 at 6:16 PM, Russell Morris <openvpn@...1315...> wrote:
>=20
> Hi,
>=20
> I have been using OpenVPN for quite a while, and just switched my client =
computer from Windows XP to Windows 7 ... and found a very interesting arti=
fact (=3Dproblem ... :-)). Let me try to explain ...
>=20
> The client machine is on one network, which has it's own DNS servers, and=
 DNS suffix (let's call it client.net). From this network DNS and internet =
access works fine.
>=20
> Then, from the client machine I connect back to the OpenVPN server (call =
it's network server.net), and allow my router DHCP to serve the OpenVPN IP =
address information so that the client machine is then on the server subnet=
. This works great - but DNS has become a problem with Windows 7.
>=20
> With Windows XP, DNS for my machine still used the client.net DNS servers=
, so I could access my local network, the internet, and by IP address (or e=
ntries in the host file) I could get back to the server.net network. I had =
no DNS resolution for the server.net network, but that was livable (using t=
he hosts file locally). Basically the server.net DNS servers were lower in =
the priority order, so no major issues.
>=20
> Now, with Windows 7, when I make the OpenVPN connection, the DNS servers =
provided by the DHCP server become primary - and this is very much a proble=
m, because now I have name resolution back to the server.net network, but t=
hat doesn't work of course for the client.net domain. Also, I actually lose=
 internet access, because the client.net suffix is being added to DNS reque=
sts send back over the OpenVPN link - so internet access is dead as well ..=
. :-(. I even have to apply the suffix .server.net. (note the trailing .) t=
o get name resolution on the server network.
>=20
> Does anyone know how to resolve this? The best case would be for local na=
me resolution for all client.net or internet requests, and "remote" resolut=
ion only for the server.net network (based on connection specific suffix). =
Any ideas how to do this?
>=20
> Thanks in advance for your suggestions!
>=20
> ... Russell
>=20
>=20
> -------------------------------------------------------------------------=
-----
> All of the data generated in your IT infrastructure is seriously valuable.
> Why? It contains a definitive record of application performance, security
> threats, fraudulent activity, and more. Splunk takes this data and makes
> sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-d2d-c2
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>=20

--===axigen=8137203016548745088618398331640644769469=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi Brett,</P>
<P>&nbsp;</P>
<P>Sorry, a bit confused here - why are you referring to OpenDNS?</P>
<P>&nbsp;</P>
<P>Thanks,</P>
<P>... Russell</P>
<P>&nbsp;</P>
<P><BR><BR>On Thu, 06/30/2011 07:20 AM, Brett&nbsp;Serkez&nbsp;&lt;bserkez@=
...277...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">The problem is that OpenDNS always provides a response=
 which defeats any local name resolution.<BR><BR>Under advanced settings, s=
ee:&nbsp; 'Exceptions for VPN users' which allows you to override the above=
 behavior in specific cases.<BR><BR>I had everything working with WindowsXP=
, I found that Windows 7 used a different settings under:&nbsp; 'Connection=
-specific DNS Suffix' which I had to add to the OpenDNS advanced settings.<=
BR><BR>Brett<BR><BR><BR>
<DIV class=3Dgmail_quote>On Wed, Jun 29, 2011 at 6:16 PM, Russell Morris <S=
PAN dir=3Dltr>&lt;<A href=3D"mailto:openvpn@...1315...">openvpn@...1315...<=
/A>&gt;</SPAN> wrote:<BR>
<BLOCKQUOTE style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3Dgmail_quote>Hi,<BR><BR>I have been using OpenV=
PN for quite a while, and just switched my client computer from Windows XP =
to Windows 7 ... and found a very interesting artifact (=3Dproblem ... :-))=
. Let me try to explain ...<BR><BR>The client machine is on one network, wh=
ich has it's own DNS servers, and DNS suffix (let's call it <A href=3D"http=
://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Fclient.net" target=3D_blan=
k>client.net</A>). From this network DNS and internet access works fine.<BR=
><BR>Then, from the client machine I connect back to the OpenVPN server (ca=
ll it's network <A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%=
2F%2Fserver.net" target=3D_blank>server.net</A>), and allow my router DHCP =
to serve the OpenVPN IP address information so that the client machine is t=
hen on the server subnet. This works great - but DNS has become a problem w=
ith Windows 7.<BR><BR>With Windows XP, DNS for my machine still used the <A=
 href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Fclient.net" t=
arget=3D_blank>client.net</A> DNS servers, so I could access my local netwo=
rk, the internet, and by IP address (or entries in the host file) I could g=
et back to the <A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2=
F%2Fserver.net" target=3D_blank>server.net</A> network. I had no DNS resolu=
tion for the <A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%=
2Fserver.net" target=3D_blank>server.net</A> network, but that was livable =
(using the hosts file locally). Basically the <A href=3D"http://server.home=
:8080/redir.hsp?url=3Dhttp%3A%2F%2Fserver.net" target=3D_blank>server.net</=
A> DNS servers were lower in the priority order, so no major issues.<BR><BR=
>Now, with Windows 7, when I make the OpenVPN connection, the DNS servers p=
rovided by the DHCP server become primary - and this is very much a problem=
, because now I have name resolution back to the <A href=3D"http://server.h=
ome:8080/redir.hsp?url=3Dhttp%3A%2F%2Fserver.net" target=3D_blank>server.ne=
t</A> network, but that doesn't work of course for the <A href=3D"http://se=
rver.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Fclient.net" target=3D_blank>cli=
ent.net</A> domain. Also, I actually lose internet access, because the <A h=
ref=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Fclient.net" tar=
get=3D_blank>client.net</A> suffix is being added to DNS requests send back=
 over the OpenVPN link - so internet access is dead as well ... :-(. I even=
 have to apply the suffix .<A href=3D"http://server.home:8080/redir.hsp?url=
=3Dhttp%3A%2F%2Fserver.net" target=3D_blank>server.net</A>. (note the trail=
ing .) to get name resolution on the server network.<BR><BR>Does anyone kno=
w how to resolve this? The best case would be for local name resolution for=
 all <A href=3D"http://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Fclient=
.net" target=3D_blank>client.net</A> or internet requests, and "remote" res=
olution only for the <A href=3D"http://server.home:8080/redir.hsp?url=3Dhtt=
p%3A%2F%2Fserver.net" target=3D_blank>server.net</A> network (based on conn=
ection specific suffix). Any ideas how to do this?<BR><BR>Thanks in advance=
 for your suggestions!<BR><BR>... Russell<BR><BR><BR>----------------------=
--------------------------------------------------------<BR>All of the data=
 generated in your IT infrastructure is seriously valuable.<BR>Why? It cont=
ains a definitive record of application performance, security<BR>threats, f=
raudulent activity, and more. Splunk takes this data and makes<BR>sense of =
it. IT sense. And common sense.<BR><A href=3D"http://server.home:8080/redir=
.hsp?url=3Dhttp%3A%2F%2Fp.sf.net%2Fsfu%2Fsplunk-d2d-c2" target=3D_blank>htt=
p://p.sf.net/sfu/splunk-d2d-c2</A><BR>_____________________________________=
__________<BR>Openvpn-users mailing list<BR><A href=3D"mailto:Openvpn-users=
@lists.sourceforge.net">Openvpn-users@lists.sourceforge.net</A><BR><A href=
=3D"http://server.home:8080/redir.hsp?url=3Dhttps%3A%2F%2Flists.sourceforge=
.net%2Flists%2Flistinfo%2Fopenvpn-users" target=3D_blank>https://lists.sour=
ceforge.net/lists/listinfo/openvpn-users</A><BR></BLOCKQUOTE></DIV><BR></BL=
OCKQUOTE></body></html>=

--===axigen=8137203016548745088618398331640644769469=axigen===--


