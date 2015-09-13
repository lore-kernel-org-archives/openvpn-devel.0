Date: Sun, 13 Sep 2015 14:31:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150913123107.GJ34798@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-5-git-send-email-gert@...1296...>
	<55F54320.5070206@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SDQiEKxzCZ35UpgS"
Content-Disposition: inline
In-Reply-To: <55F54320.5070206@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 04/10] Create basic infrastructure for
 IPv6 default gateway handling / redirection.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--SDQiEKxzCZ35UpgS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 13, 2015 at 11:34:24AM +0200, Arne Schwabe wrote:
> > - consequently, --get-default-gateway has an optional parameter now, the
> >   IPv6 address to look up (for debugging)
>=20
> We should document this.
>=20
> ACK.

Yes, right you are.  I'll add --show-gateway to openvpn.8 - right now it
seems to be totally undocumented, with or without the option :-)

(The commit message is also not correct here, as the option is called=20
"--show-gateway" - to be fixed on commit)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SDQiEKxzCZ35UpgS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVfVsiqkuBuNlUUl1AQJTQwP8CASMqVFjzdcPq9Tfdr7o8926i4ADPDlQ
OKK0297KjM+9Ae5hSN/FXoGotWHRz2krfnTKoR2yY93e2mAz4Tx7wHVEX6+i9YTO
hoAvaOC8SQcmNJQa0ESzf3Q57CkxWzg1vOC8xXVGykHg0oVHL+vFqZLXjHDeRRBj
1/dmaBeVA2A=
=qOow
-----END PGP SIGNATURE-----

--SDQiEKxzCZ35UpgS--

