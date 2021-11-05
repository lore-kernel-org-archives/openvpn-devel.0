Date: Fri, 5 Nov 2021 17:20:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YYVZwxdsTos+G8+1@...1296...>
References: <20211019183127.614175-1-arne@...1227...>
 <20211105161302.2916786-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vx2K5uizthDXO4jy"
Content-Disposition: inline
In-Reply-To: <20211105161302.2916786-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Refactor early initialisation and
 uninitialisation into methods
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--vx2K5uizthDXO4jy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 05, 2021 at 05:13:02PM +0100, Arne Schwabe wrote:
> +static void uninit_early(struct context *c)
> +{
> +    net_ctx_free(&c->net_ctx);
> +}

The extra "&" here does not look right.  Shouldn't this be
"c->net_ctx" as in "init_early()"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vx2K5uizthDXO4jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhhVnDAAoJEB2Cnv7KVigSizIL/2uRe25cCPL6LPEV+4lQqG0q
s3rCemVOyqptKIRp2bh8kvQhu/EnUx5jaLSuvNMYS41f0neyzWOBT1mCCEt8wPji
3Bgiv3kaA3ARQBfIAOAok/SpIpLyjSzKgl7mV+Fy/ZoGTKI6WTAbL1f+l9GRcCgd
djI4YINJwvI7Formz4SxG56s/tItv9J2TS+WEg4hGg+dRRSWxxLp1eMn73cF0cPI
trPs7YsiiST/RqBzTV30e85OTGzoW5rTbkGBtxoxT7OnJASIYmaNxI9K5S76DbBs
hU9z00apruRiHQQtiiu7SCrJmVifds3ug7rROvuL4+L2BhUUfj9veOh5mUYm2hJH
w4+hc8Z9oJiQZoBrkBroSU8Gs17gBv8b9l9sVnU9Kq21aI0LzMvgq4hWGIFM0hLe
SYFMDD/Uq3Sxym1Ks+DWGjjfiR9NuI6EoOW2EcxRiuohIUKHf+QMBLUBqvWTkFc1
g+2teeHwbzdoZgG7ek8ktrp5zqT6XiWcysMhmuHQfg==
=oYbd
-----END PGP SIGNATURE-----

--vx2K5uizthDXO4jy--

