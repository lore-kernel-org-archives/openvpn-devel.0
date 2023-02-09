Date: Thu, 9 Feb 2023 17:47:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+UjpZpxaUCpFfSh@...1296...>
References: <20230209153658.24001-1-ynezz@...2710...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AQ6hdlUIGZ9ael3/"
Content-Disposition: inline
In-Reply-To: <20230209153658.24001-1-ynezz@...2710...>
Subject: Re: [Openvpn-devel] [PATCH] get_addr_generic: fix server crash in
 freeaddrinfo on musl libc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Petr ??tetiar <ynezz@...2710...>
Cc: openvpn-devel@lists.sourceforge.net

--AQ6hdlUIGZ9ael3/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 09, 2023 at 04:36:58PM +0100, Petr ??tetiar wrote:
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index a883ac4a156c..d304554cefda 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -172,7 +172,10 @@ get_addr_generic(sa_family_t af, unsigned int flags,=
 const char *hostname,
>          *sep =3D '/';
>      }
>  out:
> -    freeaddrinfo(ai);
> +    if (ai)
> +    {
> +        freeaddrinfo(ai);
> +    }
>      free(var_host);

The patch itself is fine, but as Arne says, maybe we should then add
this to all places where freeaddrinfo() is called and could be NULL - so
we're at least consistent in our interpretation of "should we pass NULL?".

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--AQ6hdlUIGZ9ael3/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj5SOlAAoJEB2Cnv7KVigSMGYL/0xdeAkncuRTmauLr1IoHjjz
q7IRpzYMtNYe0Q2oom+KWG6wGK80lkpif2fhG422gObXV3dAN+uIvhSzrrrtGRdP
d887bWLUDNdYHmkiBlXLCAT1T5Iun3smrJk3gJtGDMrEibkBqSQ75HZ7gPt2cVT/
X9jRHmmi3E+PhYwBFsG4FJOvZWR9C88jyRklAdQyfwVRM5+DzsQpFQ09XlWvFWBZ
xuGF/ZhGbOArvQSo40RL48oOdOJthkrW1jABkgcPKaPNQ1KJjvm9ELFgHNBlznaw
tR8fllFAjBhRRrmz+9Hygk3OCyc3r2IKE9WIimxD3O5s6eohGR39OEtfAHiQCYL/
+VU0a3AHAQ12pP7CRJ5YnJCTjbW2PqnXpE3ZXcAyhkhw3kKEI0l0KVK42kP49gTv
w0sUuPF1lIxh3a4k5dgRbfhRX9UurzPZP6qjvakWOiQ7bM+XBwdeSrqIG5Fg9kRT
Jzz3ZA/xR/xM4uBMjXpp+K34QrcYrFktxP8mOO2Ryw==
=4Tie
-----END PGP SIGNATURE-----

--AQ6hdlUIGZ9ael3/--

