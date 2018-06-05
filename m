Date: Tue, 5 Jun 2018 16:51:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180605145139.GN57262@...1296...>
References: <20180605090421.9746-5-a@...2181...>
 <20180605093628.4985-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
In-Reply-To: <20180605093628.4985-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] pool: allow to configure an
 IPv6-only ifconfig-pool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>

--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Tue, Jun 05, 2018 at 05:36:28PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> With this change a server is allowed to allocate an
> IPv6-only pool. This is required to make it capable
> of managing an IPv6-only tunnel.

Without having done much review here, just one initial caveat: did you=20
test this with --ifconfig-pool-persist?  What happens?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFqN7AAoJEB2Cnv7KVigSW7gL/2mBl9wGPQVzeIWNrV4X1TQL
QPtNEM8COQt+hqdsFvBw9dbqHohMjKmL1MkuWaeLq4afXZpMvZbjFmL9/lH2nFUf
FKEKXXsko7Mx3MvizQWX0rG3LEeiC/damfDQWdxSqMRqUoRILk8ft70od9Nr3Rsq
NCuDdWi9yx1YTGsP9HX62gDrGS4yXDHLT3MgVRfb+I0xJWSgW4S6s3/SLqTl82qr
Lzi+dh386W8U0Ekv1R0gEOPQbxJMteGdO50hoB7HBNf+sdfD8Kwb/jl/m4TK1yOG
aZzq0J9tf63tXS/j8EbT+Nmq3XCMe6PzW/OLb241CvsU0f30YBrPAPt60hu+Wx90
tX+/86PDGGQJeoYtWHEcT6oTvqmufdTplb2/+7idnjiwMopXc/cBhEGc6+pzOkpn
KTO68Kuj+d/WmIfpBGKT1s4rShkMT+2iSXw1la1yoacnoqDjyovy2M28TS6DvZHZ
FMuLhBd7TetNnf8155Wl1b4F5NDeWe9BMBdgg+04Tw==
=wnMz
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--

