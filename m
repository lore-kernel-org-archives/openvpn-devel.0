Content-Type: multipart/alternative;
 boundary=Apple-Mail-30C04B0B-2829-4A35-8565-C9EB97121DB3
Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <20200819060327.GE75094@...1296...>
Date: Tue, 18 Aug 2020 23:31:48 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <DC25B829-92E2-4052-AFDF-CC3F90BE4286@...277...>
References: <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
 <20200818192104.GB75094@...1296...>
 <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
 <20200818194248.GC75094@...1296...>
 <CAKuzo_jG-NOqD4wHZ1SL-2Ti5NgocUDzSOpV5yqMaTXZ2UXVrA@...278...>
 <CAAWBBYPby1vNtcmqy32=jJbVO=vxaZuHphjR4UxJfS9pOAMc-Q@...278...>
 <20200819060327.GE75094@...1296...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Rafael Gava <gava100@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Apple-Mail-30C04B0B-2829-4A35-8565-C9EB97121DB3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I noticed the same issue.  I tried upgrading from an earlier version with a=
n .ovpn file (with all settings and inline certs etc that was working previ=
ously).  The .ovpn is configured as client to receive dhcp address from the=
 server.=20=20

But when we ran the upgrade .msi, which created both a TAP and wintun inter=
faces, the TAP was fine but the wintun had static IPs selected with no IPs =
entered.  Unless someone has some programming smoke and mirrors, that=E2=80=
=99s asking for a failure.=20=20

So it didn=E2=80=99t read the .ovpn (to select dhcp) and it didn=E2=80=99t =
have anything to populate the IP/subnet/dns etc.  This can=E2=80=99t be rig=
ht.  At the least it should be set to dhcp by default with static IPs added=
 later if necessary.  Or am I doing something wrong?

Marvin=20

> On Aug 18, 2020, at 11:03 PM, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
>> On Tue, Aug 18, 2020 at 07:30:12PM -0300, Rafael Gava wrote:
>> Inspecting the wintun interface through the properties I saw that on the
>> TCP/IPv4 Properties the default option selected is "Use the following IP
>> address" but the IP address and the Subnet mask were empty. Should that =
be
>> a problem?
>=20
> No.  OpenVPN will set what is needed.
>=20
> gert
>=20
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
> feed honest figures into a computer, honest figures come out. Never doubt=
ed=20
> it myself till I met a computer with a sense of humor."
>                             Robert A. Heinlein, The Moon is a Harsh Mistr=
ess
>=20
> Gert Doering - Munich, Germany                             gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--Apple-Mail-30C04B0B-2829-4A35-8565-C9EB97121DB3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto">I noticed the same issue. &nbsp;I tried=
 upgrading from an earlier version with an .ovpn file (with all settings an=
d inline certs etc that was working previously). &nbsp;The .ovpn is configu=
red as client to receive dhcp address from the server. &nbsp;<div><br></div=
><div>But when we ran the upgrade .msi, which created both a TAP and wintun=
 interfaces, the TAP was fine but the wintun had static IPs selected with <=
i>no</i> IPs entered. &nbsp;Unless someone has some programming smoke and m=
irrors, that=E2=80=99s asking for a failure. &nbsp;</div><div><br></div><di=
v>So it didn=E2=80=99t read the .ovpn (to select dhcp) and it didn=E2=80=99=
t have anything to populate the IP/subnet/dns etc. &nbsp;This can=E2=80=99t=
 be right. &nbsp;At the least it should be set to dhcp by default with stat=
ic IPs added later if necessary. &nbsp;Or am I doing something wrong?<br><b=
r><div dir=3D"ltr">Marvin&nbsp;</div><div dir=3D"ltr"><br>On Aug 18, 2020, =
at 11:03 PM, Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1711...=
96...</a>&gt; wrote:<br><br></div><blockquote type=3D"cite"><div dir=3D"ltr=
"><span>Hi,</span><br><span></span><br><span>On Tue, Aug 18, 2020 at 07:30:=
12PM -0300, Rafael Gava wrote:</span><br><blockquote type=3D"cite"><span>In=
specting the wintun interface through the properties I saw that on the</spa=
n><br></blockquote><blockquote type=3D"cite"><span>TCP/IPv4 Properties the =
default option selected is "Use the following IP</span><br></blockquote><bl=
ockquote type=3D"cite"><span>address" but the IP address and the Subnet mas=
k were empty. Should that be</span><br></blockquote><blockquote type=3D"cit=
e"><span>a problem?</span><br></blockquote><span></span><br><span>No. &nbsp=
;OpenVPN will set what is needed.</span><br><span></span><br><span>gert</sp=
an><br><span></span><br><span>-- </span><br><span>"If was one thing all peo=
ple took for granted, was conviction that if you </span><br><span> feed hon=
est figures into a computer, honest figures come out. Never doubted </span>=
<br><span> it myself till I met a computer with a sense of humor."</span><b=
r><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;Robert A. Heinlein, The Moon is a Harsh Mistress=
</span><br><span></span><br><span>Gert Doering - Munich, Germany &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;<a href=3D"mailto:gert@...1296...">gert@...1296...</a></span><br></=
div></blockquote><blockquote type=3D"cite"><div dir=3D"ltr"></div></blockqu=
ote><blockquote type=3D"cite"><div dir=3D"ltr"><span>______________________=
_________________________</span><br><span>Openvpn-devel mailing list</span>=
<br><span><a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-de=
vel@lists.sourceforge.net</a></span><br><span><a href=3D"https://lists.sour=
ceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lis=
ts/listinfo/openvpn-devel</a></span><br></div></blockquote></div></body></h=
tml>=

--Apple-Mail-30C04B0B-2829-4A35-8565-C9EB97121DB3--

