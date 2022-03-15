Date: Tue, 15 Mar 2022 18:14:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YjDJfV/CAiLztsDp@...1296...>
References: <20220315155344.37787-1-openvpn@...2080...>
 <20220315155344.37787-4-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ha3jJpZNCZJQ1BK/"
Content-Disposition: inline
In-Reply-To: <20220315155344.37787-4-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2.4 v5 3/3] plug-ins: Remove
 defer/simple.c sample plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--Ha3jJpZNCZJQ1BK/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 15, 2022 at 04:53:44PM +0100, David Sommerseth wrote:
> From: David Sommerseth <davids@...515...>
>=20
> The use case for this plug-in is dubious now with the new multi-auth.c
> plugin available.  This new plugin is based on simple.c, but allows
> far more flexibility for testing.

As for 1/3 v5, we decided to not invest time into plugin maintenance
for 2.4 -> so, formal NAK for this one.  Just for the sake of the
archives.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Ha3jJpZNCZJQ1BK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiMMl9AAoJEB2Cnv7KVigSU+0L/1/T6HGhLb6r+iTMY8GlB+7u
imadtxICNPk/8shHAvzh1VOywf/dstuolVickkjVklZr2WjDXHKZ/ylRNcWRvZAi
uJqRxThdsoy8mMhJsIGdzEEiion7SUz+lRXiUFmNnb7U9lTkaGp8xasxc0M8w1Hl
0ObJBEYF2o1V9yBNceg5c2GBZODArp4y18v8Z1reYQw2ySVtfm9geIBBSqsHR/Dn
nUWzhpNcA09IT/jxL1jCQGz/10Te0SzWD/SUwX4zs7ocMDF1KRjkm3LG88tewLhb
y6gXuGQ4nm44962lQw+PzO6Aa10yKE139Mk7Bey+R/FDmomQJ6jjsP3yjlCMiVVa
VBZrdCU+B5OaM9Achhqo9VdJfkifGBToeBcfB0aPcnefOwlDB2EpvnRL4a24XaQG
7faIzouhqZ55lFyAo6fuejg2aydUcEEOLzybSjPZxVooiB7hF4ih4baeV8SBp40J
drWfdb3g3slMabUFAuB8GK/z4GDwV5XToIOoTsbY1A==
=TTPF
-----END PGP SIGNATURE-----

--Ha3jJpZNCZJQ1BK/--

