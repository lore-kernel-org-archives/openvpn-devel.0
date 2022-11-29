Date: Tue, 29 Nov 2022 22:04:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4ZzzbGgy/pUHDN6@...1296...>
References: <20221129180534.657529-1-selva.nair@...277...>
 <20221129183756.657793-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PGVF4qqjmu6HIlmF"
Content-Disposition: inline
In-Reply-To: <20221129183756.657793-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] pull-filter: ignore leading "spaces"
 in option names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--PGVF4qqjmu6HIlmF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 29, 2022 at 01:37:56PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> It seems sometimes comma-separated pulled options have
> an offending leading space. Not sure whether that is an error,
> but the change here matches the behaviour of option parsing.
>=20
> v2: fix typo in commit message.

I have seen this, but I'd really prefer to fix the pushing side.

Which options have you seen this with?  I only observed with with
"auth-token", which grows an extra leading space when being sent
unsolicited.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PGVF4qqjmu6HIlmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhnPNAAoJEB2Cnv7KVigSWY4MALBCuphiMfKTskHGF+6yFbUI
rRxPdLMBUaEAR4g0Gb/Dk/vUsokw5ncrrj2wZfF613yhVwuc43CXYoFLmCAISQmq
FKTUwO5mJ9wg8JmLkgx24MdLLvR5P23A2o5rhuesRp4MaQxDwnSmbvFgjPWxew+l
KRuFIqiudAQaSBijzQQM3s1ZzJTOLCdhWah6EPkFSOim0dAE8Xz8yEWjajwNx4Jj
Ofwx84+TJ+KY9/EI4nTVYumsZwdrWfw65X5U/3klQM9JyvFNB1xzr9/9p/aCXzEQ
vUhjnazx2Zjo1vyIiNJHpviuTJPfVTBLACeXr+DqVGj3pNiPhxox+AuruXTvGNVb
ZkCpeTzBKs0eOEsMjLWJ90Yim3mdcvRd2JCkvR0sV05QTPYDQDBsqcf3LqTdOj4x
EQGbH6XCV5enGvXw3v3qrJJPV4ru+2tfVczm7JNOMCahnkMbP56NrIvniWs7reB9
UxtYl1UnNtBcyBZ1FCFjJUKeb2gF9ns0DKgZcxn5fw==
=LdY5
-----END PGP SIGNATURE-----

--PGVF4qqjmu6HIlmF--

