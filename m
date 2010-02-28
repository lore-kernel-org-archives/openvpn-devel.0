References: <20100228150546.GO9556@...1296...>
In-Reply-To: <20100228150546.GO9556@...1296...>
Mime-Version: 1.0 (Apple Message framework v1077)
Message-Id: <540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>
From: Eric F Crist <ecrist@...1286...>
Date: Sun, 28 Feb 2010 09:10:23 -0600
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

ACK,

It's not you, that's duplicate code.

Eric


On Feb 28, 2010, at 09:05:46, Gert Doering wrote:

> Hi,
>=20
> tun.c contains this code, in the=20
>=20
> #elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
>=20
> part of do_ifconfig() (about line 983 in the IPv6 payload branch):
>=20
> ----------------- snip ----------------
>      else {=20
>        if (tt->topology =3D=3D TOP_SUBNET)
>            argv_printf (&argv,
>                              "%s %s %s netmask %s mtu %d up",
>                              IFCONFIG_PATH,
>                              actual,=20
>                              ifconfig_local,
>                              ifconfig_remote_netmask,
>                              tun_mtu
>                              );
>        else
>            argv_printf (&argv,
>                          "%s %s %s netmask %s mtu %d up",
>                          IFCONFIG_PATH,
>                          actual,
>                          ifconfig_local,
>                          ifconfig_remote_netmask,
>                          tun_mtu
>                          );
>      }=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> ----------------- snip ----------------
>=20
> Is it just me needing new glasses, or is this twice the very same code,
> with a little bit of different indentation?
>=20
> If other people see this too, I'll send in a patch that drops the=20
> duplicate bits.  The tun.c code is still hard enough to read...
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
>=20
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

---
Eric Crist





