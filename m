MIME-Version: 1.0
In-Reply-To: <56307DAA.30700@...2070...>
References: <562EB0A1.8010403@...2070...> <56307DAA.30700@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 14 Nov 2015 15:01:50 -0500
Message-ID: <CAKuzo_hn+jSim98XcDSUPpMmvCiqEtfRBVjpPouHn__qFciErA@...278...>
Content-Type: multipart/alternative; boundary=001a11443346b69184052485a6ec
Subject: Re: [Openvpn-devel] [PATCH v2] Add Windows DNS Leak fix using WFP
	('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11443346b69184052485a6ec
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Oct 28, 2015 at 3:47 AM, ValdikSS <iam@...2070...> wrote:

> This option is silently ignored on non-Windows platforms and works on
> Vista+.
> External DNS is blocked even if no DNS server configured (user may
> configure it in the tap interface itself).
> This option could be ignored from server push using route-nopull.
>
> v2:
> * Add missing libs to MSVC project file.
> * Add ifndef for FWPM_SESSION_FLAG_DYNAMIC to silence warning in MSVC.
> * Use const WCHAR for firewall name.
> * Block all traffic to TCP/UDP port 53 except for OpenVPN itself. Blocking
> only svchost.exe is not reliable as user could disable dnscache service
> making all applications resolve DNS from their processes.
>

I tested this on Windows 7 and ran into some problems.

Blocking dns through all interfaces except the tun/tap works (tested by
sniffing the traffic etc.).

But most often (see below) name resolution fails after the vpn is connected:

openvpn: git-master + this patch locally compiled using mingw (64bit)
LAN: IP (dhcp): 192.168.0.110  dns (dhcp): 1192.168.0.30
TUN/TAP: IP (automatic): 10.9.0.10 dns (fixed): 8.8.8.8
Windows firewall: disabled

openvpn --config some-config.ovpn --block-outside-dns --verb4
--redirect-gateway def1

Name resolution times-out  after connect (checked by ping and browser).
But nslookup continues to work, so direct connection to 8.8.8.8:53 via the
tun is working. In this state, the only strange thing I notice is

ipconfig /displaydns
returns "Could not display the resolver cache".
as if  the dnscache service is stopped, but it is running.

Name resolution starts to work again after a
(i) ipconfig /registerdns
OR
(ii) sc stop dnscache (starting it again is also ok)
OR
(iii) wait for several minutes
/displaydns also displlays the cache correctly after that.

On restarting the vpn (SIGHUP or SIGUSR1), it goes back to the non
resolving state again. Once start working there are no obvious delays with
dns -- tested only on a fast connection to the vpn server.

I could not enable logging of the firewall without which its hard to say
what's going on. I can only guess the system continues to try only
192.168.0.30 which gets blocked by the filter.

So, how to enable firewall logging? -- enabling via netsh or Windows
firewall UI (wf.msc) does not generate any logs. Also the firewall rules
added by the program does not show up in the firewall UI or in netsh
advfirewall outputs. How to make these filters visible in the UI and how to
log the dropped connections? The filters are in place and do work, but
doesnt show up in the UI -- is that expected? The UI continues to show
firewall as disabled with no filters in place.

I couldn't find anything wrong with the code, but I'm not familiar with
WFP.

Thanks
,

--001a11443346b69184052485a6ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><br><div><div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote">On Wed, Oct 28, 2015 at 3:47 AM, ValdikSS <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...1186...=
.2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This opt=
ion is silently ignored on non-Windows platforms and works on Vista+.<br>
External DNS is blocked even if no DNS server configured (user may configur=
e it in the tap interface itself).<br>
This option could be ignored from server push using route-nopull.<br>
<br>
v2:<br>
* Add missing libs to MSVC project file.<br>
* Add ifndef for FWPM_SESSION_FLAG_DYNAMIC to silence warning in MSVC.<br>
* Use const WCHAR for firewall name.<br>
* Block all traffic to TCP/UDP port 53 except for OpenVPN itself. Blocking =
only svchost.exe is not reliable as user could disable dnscache service mak=
ing all applications resolve DNS from their processes.<br>
</blockquote><div><br></div><div>I tested this on Windows 7 and ran into so=
me problems.<br><br></div><div>Blocking dns through all interfaces except t=
he tun/tap works (tested by sniffing the traffic etc.). <br><br>But most of=
ten (see below) name resolution fails after the vpn is connected:<br><br></=
div><div>openvpn: git-master + this patch locally compiled using mingw (64b=
it)<br></div><div>LAN: IP (dhcp): 192.168.0.110=C2=A0 dns (dhcp): 1192.168.=
0.30<br></div><div>TUN/TAP: IP (automatic): 10.9.0.10 dns (fixed): 8.8.8.8<=
br></div><div>Windows firewall: disabled<br><br></div><div>openvpn --config=
 some-config.ovpn --block-outside-dns --verb4 --redirect-gateway def1<br><b=
r></div><div>Name resolution times-out=C2=A0 after connect (checked by ping=
 and browser).=C2=A0 But nslookup continues to work, so direct connection t=
o <a href=3D"http://8.8.8.8:53">8.8.8.8:53</a> via the tun is working. In t=
his state, the only strange thing I notice is<br>=C2=A0<br>ipconfig /displa=
ydns <br>returns &quot;Could not display the resolver cache&quot;. <br></di=
v><div>as if=C2=A0 the dnscache service is stopped, but it is running. <br>=
</div><div><br>Name resolution starts to work again after a<br></div><div>(=
i) ipconfig /registerdns<br></div><div>OR<br></div><div>(ii) sc stop dnscac=
he (starting it again is also ok)<br></div><div>OR<br></div><div>(iii) wait=
 for several minutes<br></div><div>/displaydns also displlays the cache cor=
rectly after that.<br><br></div><div>On restarting the vpn (SIGHUP or SIGUS=
R1), it goes back to the non resolving state again. Once start working ther=
e are no obvious delays with dns -- tested only on a fast connection to the=
 vpn server.<br><br></div><div>I could not enable logging of the firewall w=
ithout which its hard to say what&#39;s going on. I can only guess the syst=
em continues to try only 192.168.0.30 which gets blocked by the filter.<br>=
<br></div><div>So, how to enable firewall logging? -- enabling via netsh or=
 Windows firewall UI (wf.msc) does not generate any logs. Also the firewall=
 rules added by the program does not show up in the firewall UI or in netsh=
 advfirewall outputs. How to make these filters visible in the UI and how t=
o log the dropped connections? The filters are in place and do work, but do=
esnt show up in the UI -- is that expected? The UI continues to show firewa=
ll as disabled with no filters in place.<br><br></div><div>I couldn&#39;t f=
ind anything wrong with the code, but I&#39;m not familiar with WFP. <br><b=
r></div><div>Thanks<br>,<br></div></div></div></div></div></div>

--001a11443346b69184052485a6ec--

