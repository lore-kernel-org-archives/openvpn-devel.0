From: Karl Mueller <ewiley@...277...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4395F877-144F-4BC0-9183-D8D8F9AF1897"
Message-Id: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
Date: Wed, 26 Jul 2017 08:50:09 -0400
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: [Openvpn-devel] TAP-adapter iftype question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_4395F877-144F-4BC0-9183-D8D8F9AF1897
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99m hoping this is the right place to bring this issue, i=E2=80=99v=
e had no luck with searching or bodging a solution on my own, and may need =
some help with a slightly-modified TAP adapter driver.

I=E2=80=99m running into an issue between the TAP adapter and Windows 10 =
=E2=80=98soft disconnect=E2=80=99 behavior for wireless connections causing=
 recursive routing when connected to a redirect-gateway VPN. The service/fe=
ature in Windows is called Windows Connection Manager service, poorly docum=
ented here: https://docs.microsoft.com/en-us/windows-hardware/drivers/mobil=
ebroadband/understanding-and-configuring-windows-connection-manager <https:=
//docs.microsoft.com/en-us/windows-hardware/drivers/mobilebroadband/underst=
anding-and-configuring-windows-connection-manager> In a nutshell it silentl=
y redirects traffic to the more =E2=80=98reliable=E2=80=99 Ethernet OpenVPN=
 adapter, overriding my /32 route and causing all traffic to fail as it rec=
ursively routes my traffic.

Microsoft makes some suggestion to disable the =E2=80=98prevent multiple co=
nnections to the Internet=E2=80=99 setting, but doing this does not seem to=
 change the behavior when weak (but still functional) wireless signal is de=
tected on the WLAN adapter. Microsoft see this as a problem with OpenVPN an=
d refuse to do anything about it.
https://support.microsoft.com/en-us/help/2919900/windows-connection-manager=
-disconnects-wlan-if-a-vpn-connection-is-est <https://support.microsoft.com=
/en-us/help/2919900/windows-connection-manager-disconnects-wlan-if-a-vpn-co=
nnection-is-est>

The upshot is that if Windows detected the TAP adapter as something other t=
han iftype 0x6 EthernetCSMACD it wouldn=E2=80=99t exhibit this behavior, an=
d Microsoft suggest 0x53 =E2=80=98virtual=E2=80=99 or 0x83 =E2=80=99tunnel=
=E2=80=99 as the VPN adapter=E2=80=99s iftype (I=E2=80=99d suggest 0x84 for=
 the comedy option).

I=E2=80=99ve found someone who=E2=80=99s successfully hacked this to work h=
ttps://forums.openvpn.net/viewtopic.php?t=3D14942 <https://forums.openvpn.n=
et/viewtopic.php?t=3D14942> but I=E2=80=99m not able to reproduce it on my =
own, but it seems reasonable that it should work. I=E2=80=99m wondering if =
it makes sense to change the underlying TAP driver (or make the if type an =
option) since Windows seems to be getting =E2=80=9Csmarter=E2=80=9D about i=
nterfaces and making routing or even security policy decisions based on the=
 interface type presented.

The reason I=E2=80=99m posting this to the Dev list is I=E2=80=99ve no idea=
 what the ramifications of changing the iftype, maybe someone=E2=80=99s loo=
ked in to this, but I haven=E2=80=99t seen any mention on this list about i=
t. It seems reasonable that the change should be relatively minor, but agai=
n i=E2=80=99m not aware of all the corner cases that might rely on the if t=
ype being Ethernet for Windows to work properly.

Thanks for listening

Karl Mueller
ewiley@...277...




--Apple-Mail=_4395F877-144F-4BC0-9183-D8D8F9AF1897
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space;" class=3D"">I=E2=80=99m hoping=
 this is the right place to bring this issue, i=E2=80=99ve had no luck with=
 searching or bodging a solution on my own, and may need some help with a s=
lightly-modified TAP adapter driver.<div class=3D""><br class=3D""></div><d=
iv class=3D"">I=E2=80=99m running into an issue between the TAP adapter and=
 Windows 10 =E2=80=98soft disconnect=E2=80=99 behavior for wireless connect=
ions causing recursive routing when connected to a redirect-gateway VPN. Th=
e service/feature in Windows is called Windows Connection Manager service, =
poorly documented here:&nbsp;<a href=3D"https://docs.microsoft.com/en-us/wi=
ndows-hardware/drivers/mobilebroadband/understanding-and-configuring-window=
s-connection-manager" class=3D"">https://docs.microsoft.com/en-us/windows-h=
ardware/drivers/mobilebroadband/understanding-and-configuring-windows-conne=
ction-manager</a>&nbsp;In a nutshell it silently redirects traffic to the m=
ore =E2=80=98reliable=E2=80=99 Ethernet OpenVPN adapter, overriding my /32 =
route and causing all traffic to fail as it recursively routes my traffic.<=
div class=3D""><br class=3D""></div><div class=3D"">Microsoft makes some su=
ggestion to disable the =E2=80=98prevent multiple connections to the Intern=
et=E2=80=99 setting, but doing this does not seem to change the behavior wh=
en weak (but still functional) wireless signal is detected on the WLAN adap=
ter. Microsoft see this as a problem with OpenVPN and refuse to do anything=
 about it.</div><div class=3D""><a href=3D"https://support.microsoft.com/en=
-us/help/2919900/windows-connection-manager-disconnects-wlan-if-a-vpn-conne=
ction-is-est" class=3D"">https://support.microsoft.com/en-us/help/2919900/w=
indows-connection-manager-disconnects-wlan-if-a-vpn-connection-is-est</a><b=
r class=3D""><div class=3D""><br class=3D""></div><div class=3D"">The upsho=
t is that if Windows detected the TAP adapter as something other than iftyp=
e 0x6 EthernetCSMACD it wouldn=E2=80=99t exhibit this behavior, and Microso=
ft suggest 0x53 =E2=80=98virtual=E2=80=99 or 0x83 =E2=80=99tunnel=E2=80=99 =
as the VPN adapter=E2=80=99s iftype (I=E2=80=99d suggest 0x84 for the comed=
y option).</div><div class=3D""><br class=3D""></div><div class=3D"">I=E2=
=80=99ve found someone who=E2=80=99s successfully hacked this to work&nbsp;=
<a href=3D"https://forums.openvpn.net/viewtopic.php?t=3D14942" class=3D"">h=
ttps://forums.openvpn.net/viewtopic.php?t=3D14942</a>&nbsp;but I=E2=80=99m =
not able to reproduce it on my own, but it seems reasonable that it should =
work. I=E2=80=99m wondering if it makes sense to change the underlying TAP =
driver (or make the if type an option) since Windows seems to be getting =
=E2=80=9Csmarter=E2=80=9D about interfaces and making routing or even secur=
ity policy decisions based on the interface type presented.</div><div class=
=3D""><br class=3D""></div><div class=3D"">The reason I=E2=80=99m posting t=
his to the Dev list is I=E2=80=99ve no idea what the ramifications of chang=
ing the iftype, maybe someone=E2=80=99s looked in to this, but I haven=E2=
=80=99t seen any mention on this list about it. It seems reasonable that th=
e change should be relatively minor, but again i=E2=80=99m not aware of all=
 the corner cases that might rely on the if type being Ethernet for Windows=
 to work properly.</div><div class=3D""><br class=3D""></div><div class=3D"=
">Thanks for listening</div><div class=3D""><br class=3D""><div class=3D"">
<div class=3D"">Karl Mueller</div><div class=3D""><a href=3D"mailto:ewiley@=
...277..." class=3D"">ewiley@...277...</a></div><div class=3D""><br class=
=3D""></div><br class=3D"Apple-interchange-newline">

</div>
<br class=3D""></div></div></div></body></html>=

--Apple-Mail=_4395F877-144F-4BC0-9183-D8D8F9AF1897--

