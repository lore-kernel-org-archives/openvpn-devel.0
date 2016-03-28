MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Mon, 28 Mar 2016 16:23:01 -0400
Message-ID: <CAKuzo_h-io30aYkUEbH8jKxGCYvhK8XNqh0mwDkbWuLYPBeaDQ@...278...>
Content-Type: multipart/alternative; boundary=089e01538c3c12081a052f21af7a
Subject: [Openvpn-devel] management hostname -- how to resolve it
	consistently
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e01538c3c12081a052f21af7a
Content-Type: text/plain; charset=UTF-8

Hi,

In recent versions of openvpn, with "management localhost xxx" openvpn
management interface listens on "[::1]:xxx" on most machines including
windows. Looking at the code, ::1 makes sense as getaddrinfo is called with
AF_UNSPEC and the first address in the list returned is used. I'm trying to
support this correctly in the GUI and have a question:

Is it ok to rely on the order in which addresses are returned by getaddrinfo
(with the same hints) -- especially on windows?  Or, how best to make sure
openvpn's interpretation of the host is the same as that of the GUI? I
would prefer to avoid having to try all addresses in  the list.  On linux,
apparently, getaddrinfo returns entries for localhost in /etc/hosts
re-ordered as per RFC 3484 (as per the manpage) unless modified by gai.conf
settings. How does it work on windows?[*]

Previously this has not been an issue, as the GUI crafts the command line
with "--management 127.0.0.1 stdin". I'm trying to support any "management
.." line specified in the config file, which is useful for controlling
always on connections (say, started by nssm or openvpnserv), among other
things.. Even otherwise, using "localhost" instead of 127.0.0.1 looks
better..

Thanks,

Selva

[*] No mention in MSDN of the order of addresses or whether it could be
altered by some settings

--089e01538c3c12081a052f21af7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>In recent versions of <span class=
=3D"" id=3D":6ao.1" tabindex=3D"-1">openvpn</span>, with &quot;management <=
span class=3D"" id=3D":6ao.2" tabindex=3D"-1">localhost</span> xxx&quot; <s=
pan class=3D"" id=3D":6ao.3" tabindex=3D"-1">openvpn</span> management inte=
rface listens on &quot;[::1]:xxx&quot; on most machines including windows. =
Looking at the code, ::1 makes sense as <span class=3D"" id=3D":6ao.4" tabi=
ndex=3D"-1">getaddrinfo</span> is called with AF_<span class=3D"" id=3D":6a=
o.5" tabindex=3D"-1">UNSPEC</span> and the first address in the list return=
ed is used. I&#39;m trying to support this correctly in the GUI and have a =
question:</div><div><br></div><div>Is it <span class=3D"" id=3D":6ao.6" tab=
index=3D"-1">ok</span> to rely on the order in which addresses are returned=
 by <span class=3D"" id=3D":6ao.7" tabindex=3D"-1">getaddrinfo</span> (with=
 the same hints) -- especially on windows?=C2=A0 Or, how best to make sure =
<span class=3D"" id=3D":6ao.8" tabindex=3D"-1">openvpn&#39;s</span> interpr=
etation of the host is the same as that of the GUI? I would prefer to avoid=
 having to try all addresses in =C2=A0the list.=C2=A0 On <span class=3D"" i=
d=3D":6ao.9" tabindex=3D"-1">linux</span>, apparently, <span class=3D"" id=
=3D":6ao.10" tabindex=3D"-1">getaddrinfo</span> returns entries for <span c=
lass=3D"" id=3D":6ao.11" tabindex=3D"-1">localhost</span> in /etc/hosts re-=
ordered as per RFC 3484 (as per the <span class=3D"" id=3D":6ao.12" tabinde=
x=3D"-1">manpage</span>) unless modified by <span class=3D"" id=3D":6ao.13"=
 tabindex=3D"-1">gai</span>.<span class=3D"" id=3D":6ao.14" tabindex=3D"-1"=
>conf</span> settings. How does it work on windows?[*]</div><div><br></div>=
<div>Previously this has not been an issue, as the GUI crafts the command l=
ine with &quot;--management 127.0.0.1 <span class=3D"" id=3D":6ao.15" tabin=
dex=3D"-1">stdin</span>&quot;. I&#39;m trying to support any &quot;manageme=
nt ..&quot; line specified in the <span class=3D"" id=3D":6ao.16" tabindex=
=3D"-1">config</span> file, which is useful for controlling always on conne=
ctions (say, started by <span class=3D"" id=3D":6ao.17" tabindex=3D"-1">nss=
m</span> or <span class=3D"" id=3D":6ao.18" tabindex=3D"-1">openvpnserv</sp=
an>), among other things.. Even otherwise, using &quot;<span class=3D"" id=
=3D":6ao.19" tabindex=3D"-1">localhost</span>&quot; instead of 127.0.0.1 lo=
oks better..</div><div><br></div><div>Thanks,</div><div><br></div><div><spa=
n class=3D"" id=3D":6ao.20" tabindex=3D"-1">Selva</span></div><div><br></di=
v><div>[*] No mention in <span class=3D"" id=3D":6ao.21" tabindex=3D"-1">MS=
DN</span> of the order of addresses or whether it could be altered by some =
settings</div></div>

--089e01538c3c12081a052f21af7a--

