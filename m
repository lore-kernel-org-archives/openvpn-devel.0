Date: Tue, 26 Jul 2016 08:36:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160726063637.GF78279@...1296...>
References: <20160725200452.GE78279@...1296...>
	<751417c6-5f9f-e0c7-ffae-fce7fa9baa4c@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zyWBJsol2ZBPjK0b"
Content-Disposition: inline
In-Reply-To: <751417c6-5f9f-e0c7-ffae-fce7fa9baa4c@...1147...>
Subject: Re: [Openvpn-devel] use of --cipher with no arguments?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--zyWBJsol2ZBPjK0b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 26, 2016 at 04:09:16AM +0200, Jan Just Keijser wrote:
> > Anyone having a good argument against it?  JJK, do you happen to know
> > what this is about?
>=20
> this is from even before my time ;)

Fun :-)=20

> I didn't even know that you could specify cipher without an argument -=20
> let's disable this (and I assume the same is true for --auth ?)

Indeed, the same is true, and it would lead to the same crash
(--auth none --auth)

  else if (streq (p[0], "auth") && p[1] && !p[2])
    {
      VERIFY_PERMISSION (OPT_P_GENERAL);
      options->authname_defined =3D true;
      options->authname =3D p[1];
      if (streq (options->authname, "none"))
        {
          options->authname_defined =3D false;
          options->authname =3D NULL;
        }
    }
  else if (streq (p[0], "auth") && !p[1])
    {
      VERIFY_PERMISSION (OPT_P_GENERAL);
      options->authname_defined =3D true;
    }

I think Steffan's patch (that he sent in parallel to my mail) takes care
of this as well...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zyWBJsol2ZBPjK0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV5cE9akuBuNlUUl1AQKhYQQAkFoKVwmOkUfwYMvnHROg0ZcccEQp/y6P
RHMO8VfRJ/LA3LDKxHM+c5PZoxThWEQvNqiTE1O0wfvn7NExMjbDwrMTIDowYl2T
tl+SKDXKfXxFSYlZUbdnQ/313LOFfPb8NpVhLhg1v74EC93pvElW/3e4+qrGemow
RpyOFG0AgEg=
=KYAf
-----END PGP SIGNATURE-----

--zyWBJsol2ZBPjK0b--

