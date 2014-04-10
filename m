Date: Thu, 10 Apr 2014 13:41:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140410114101.GU16637@...1296...>
References: <20140409232527.GA3061@...1890...>
	<20140410081524.GK16637@...1296...>
	<20140410100518.GD3739@...1890...>
	<20140410112949.GA6937@...1890...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jPm2FBdl5/rkSh8P"
Content-Disposition: inline
In-Reply-To: <20140410112949.GA6937@...1890...>
Subject: Re: [Openvpn-devel] BUG: Windows netsh interface ipv6 delete address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Cedric <cedric+openvpn@...1891...>
Cc: openvpn-devel@lists.sourceforge.net

--jPm2FBdl5/rkSh8P
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 10, 2014 at 01:29:49PM +0200, Cedric wrote:
> I just installed a windows XP SP3 in a VM, activated ipv6, connected the
> vpn and ran the netsh delete command by hand in a terminal with
> store=3Dactive.
> It works without error, ipv6 address is removed from tun/tap interface.

Thanks.  This settles it :-) - I'll change the code, and provide a fix.

> I do not have the skills (and enough aspirin) to compile openvpn on windo=
ws,
> but I can test a beta if you can provide me a patched openvpn windows
> executable (32bit for winxp / 64bit for win7-8).

As if I would want to remember...

(It's not *that* bad actually, with the new build system)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jPm2FBdl5/rkSh8P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0aDTakuBuNlUUl1AQIyiAP/UUR8EXFCZkLdYHmebsMCOQdkVznIhuvA
ledVmJ6vaKi8uOHx/Xx3AYQVC+mOtJKPzuoZCdEtJVFBXAKytyTxPA1xZlg2NXKy
0Gpr+W9m9VFkOrhrRSTWfLis41lpmqsQb5kR8FPoE5IHNCpOu1LuetgApmlo7gTm
uALxVvlGTW0=
=pDR4
-----END PGP SIGNATURE-----

--jPm2FBdl5/rkSh8P--

