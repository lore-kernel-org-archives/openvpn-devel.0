Date: Sun, 14 Feb 2021 21:10:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210214201012.GZ976@...1296...>
References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-8-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Hcoo0fduO1fBUfeV"
Content-Disposition: inline
In-Reply-To: <20210125125628.30364-8-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 07/11] Refactor extract_var_peer_info
 into standalone function and add ssl_util.c
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

--Hcoo0fduO1fBUfeV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 25, 2021 at 01:56:24PM +0100, Arne Schwabe wrote:
> Our "natural" place for this function would be ssl.c but ssl.c has a lot =
of
> dependencies on all kinds of other compilation units so including ssl.c i=
nto
> unit tests is near impossible currently. Instead create a new file ssl_ut=
il.c
> that holds small utility functions like this one.
>=20
> Patch v2: add newline add the end of sll_util.h and ssl_util.c

Even if it already got an ACK, I find the function could benefit from a=20
v3... "if we refactor, go all the way"

- change to early-return

  if (!peer_info || ((var_start =3D strstr(peer_info, var)) =3D=3D NULL))
  {
      return NULL;
  }

- possibly split the assignment-and-compare if() into easier to read

  const char *var_start =3D strstr(peer_info, var);
  if (!var_start)
  {
      return NULL;
  }

- half the function has been converted to "var" and "var_start", and
  the rest still talks "char *ncp_ciphers_peer"... wat? - maybe that
  should be "char *value" (and "var" should be "key"?) or something.

- the v2 hunk has a newline-at-end-of-file mishap in ssl.c

> index 14c8116f..f59b409f 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -4201,4 +4201,4 @@ void
>  ssl_clean_user_pass(void)
>  {
>      purge_user_pass(&auth_user_pass, false);
> -}
> +}
> \ No newline at end of file

(this is a new "no newline"), while v2 fixes the other one).


On the plus side, I tested "make distcheck" on linux, and all the Makefile
bits and pieces are proper (we tend to break that for new C files...)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Hcoo0fduO1fBUfeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgKYOjAAoJEB2Cnv7KVigSsKEL/0v0/sMLEMiCe/7Ld9phW0Rs
cWeNLMBfoTD4luK6TCslwDWPlyr7s5DeiPrTPBhatKdSLOV7CIFm4XxQaUCSFqXc
iMENNAVy0z48FCSWvbZABq5bJvMZemWIvA8EQkdhEsEsiVJfgNFP4d7Nz+fWkETC
HgokTFeDaFcqJRWHvOz0kICeOfBqfwnYeY9AUJwDBSugX1ViaXrrpgnf+/m6m8r1
a//BTCdBTXFp4BQ6BUxYD//Jfw5Zg8pHTLNnkonM+qGcuSFqWpsWsSWQmy24rNmS
vdISlql2f7eR0mF1s6tYmOvlUcacK3xtI1S+NuFnLbWku3h3G/H2zajZgVgl/uKz
dtNmX6n4kiPr1k0UNKmuoGhUlU2ZCUQdXZSW3ANC1TO28I8RWb2Ex79ifj6c+MKu
x8ufAn3Viw+3s8+X/660F21CvXS7CvJ9beTMoc5mD3tFfY4zq81Nt5/VilGrI2KF
DkdsNRSW/jYmtqTkwcpdinpTAjlnqpNvITMUzbNIFw==
=PMCJ
-----END PGP SIGNATURE-----

--Hcoo0fduO1fBUfeV--

