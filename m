Date: Wed, 17 Aug 2016 21:50:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160817195057.GZ78279@...1296...>
References: <57A87572.6080306@...277...>
	<20160808122011.GC78279@...1296...>
	<57A896DD.1020004@...277...>
	<a04e17d1-27b9-0415-3625-12c255f2f010@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkwjF0+O6jX31edR"
Content-Disposition: inline
In-Reply-To: <a04e17d1-27b9-0415-3625-12c255f2f010@...277...>
Subject: Re: [Openvpn-devel] Is --ifconfig-ipv6-noexec planned ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--JkwjF0+O6jX31edR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 17, 2016 at 12:54:20PM +0100, debbie10t wrote:
> So I re-state my original question in a more appropriate way:
>=20
>    _Why_ does --ifconfig-noexec *not* effect IPv6 ?

It *does*.  The only place in OpenVPN where this flag is checked is
in init.c:

Windows and Android:

      /* do ifconfig */
      if (!c->options.ifconfig_noexec
          && ifconfig_order () =3D=3D IFCONFIG_BEFORE_TUN_OPEN)
        {
          /* guess actual tun/tap unit number that will be returned
             by open_tun */
          const char *guess =3D guess_tuntap_dev (c->options.dev,
                                                c->options.dev_type,
                                                c->options.dev_node,
                                                &gc);
          do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE (&c->c2.frame), c-=
>c2.e
s);
        }

all other platforms:

      /* do ifconfig */
      if (!c->options.ifconfig_noexec
          && ifconfig_order () =3D=3D IFCONFIG_AFTER_TUN_OPEN)
        {
          do_ifconfig (c->c1.tuntap, c->c1.tuntap->actual_name, TUN_MTU_SIZ=
E (&c
->c2.frame), c->c2.es);
        }

... but as you can see, there is no "do_ifconfig_ipv4()" inside the
clause, and "do_ifconfig_ipv6()" outside.  do_ifconfig() does IPv4=20
and IPv6 (tun.c) - if if it is not called for IPv4, there is nothing
else in the code that would do ifconfig for IPv6.

> The point here is that using --ifconfig-noexec & --up
> for IPv4 you manually configure everything
> for IPv6 you *must* --pull-filter ignore "ifconfig-ipv6 "
> because --ifconfig-noexec has *no* effect on IPv6

Please show a log file that shows

  - incoming push message
  - that IPv4 is not ifconfig'ed
  - but IPv6 is

(I'm not saying our code has no bugs, but I cannot see a way how this
could ever happen)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JkwjF0+O6jX31edR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV7TAIKkuBuNlUUl1AQK96wP/XkAWSA9Bx9Mt/gZleOMFfEn+fhxu1kgr
qXWlyvV0o6i/x/vsXzFHNvVwnOT6Kr95DekDN1jT//QTSdSDK1kUYpwtrG8pGAyA
TseYBCU1k4L3AU6IdQbWGLcU25ouHFvRBfpKFx3J2QKP48ghGS97n0KbBBDz1snk
vAKMoJp/CPs=
=Om/2
-----END PGP SIGNATURE-----

--JkwjF0+O6jX31edR--

