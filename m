Date: Fri, 15 Nov 2013 16:40:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131115154003.GS161@...1296...>
References: <1382688143-17247-1-git-send-email-arne@...1227...>
	<1384526517-6020-1-git-send-email-gert@...1296...>
	<52863709.7020006@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+SjOtuBPz8meD6md"
Content-Disposition: inline
In-Reply-To: <52863709.7020006@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix argument type warning introduced by
	http extra proxy header patch.
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

--+SjOtuBPz8meD6md
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 15, 2013 at 04:00:25PM +0100, Arne Schwabe wrote:
> Am 15.11.13 15:41, schrieb Gert Doering:
> > d0cb816cf8be68359617b61a55799f6330901f6a introduced add_proxy_headers(),
> > passing "port" as "const char *" - but it should be an "int".  As port
> > is not yet actually used inside add_proxy_headers(), it's just a warnin=
g.
> >
> > Signed-off-by: Gert Doering <gert@...1296...>
[..]
> ACK.

committed and pushed, as 16e24daaba4432e0a905478bab23b65f904be135

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+SjOtuBPz8meD6md
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUoZAU6kuBuNlUUl1AQIrbwP8DXXMpbnEM6FkJ8u3j4tdiPZ/ZxvH4TVr
hVapXnJehGj7+Dd8harDyVbU+WbhjHKJCRO9qGr/iw28YdOvlc8DLlQV+xqBBfpE
K8k2GhJhW8i5WDEew2Ey372i/oxRzsiUjNVMfZgslztmRqidklLyt0bxcIwPaJJo
3IqhgjeR4Nk=
=bMOM
-----END PGP SIGNATURE-----

--+SjOtuBPz8meD6md--

