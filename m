Date: Tue, 23 Nov 2021 19:44:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZ02pLWqooAtu54O@...1296...>
References: <CAGyAFMV36+05+TLJ4v9vQwikVv_X4xqqmvMp+Ah-Kip5oM9hjA@...278...>
 <20211119005306.624-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LOi4CEUtZaawMww9"
Content-Disposition: inline
In-Reply-To: <20211119005306.624-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Load OpenSSL config on Windows from
 trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--LOi4CEUtZaawMww9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 19, 2021 at 02:53:06AM +0200, Lev Stipakov wrote:
> +    if ((install_path[wcslen(install_path) - 1]) =3D=3D L'\\')
> +    {
> +        install_path[wcslen(install_path) - 1] =3D L'\0';
> +    }
> +
> +    WCHAR openssl_cnf[MAX_PATH] =3D {0};
> +    WCHAR openssl_engines[MAX_PATH] =3D {0};
> +    WCHAR openssl_modules[MAX_PATH] =3D {0};
> +
> +    openvpn_swprintf(openssl_cnf, _countof(install_path),
> +        L"OPENSSL_CONF=3D%ls\\ssl\\openssl.cnf", install_path);

This needs to be _countof(openssl_cnf) - even if they are the same
today, they might not be tomorrow.

While at it, I wonder if it is more orderly to move the swprintf()
calls in the "if NULL" clause now...  like this:

   if (_wgetenv(L"OPENSSL_CONF") =3D=3D NULL)
   {
       WCHAR openssl_cnf[MAX_PATH] =3D {0};

       openvpn_swprintf(openssl_cnf, _countof(openssl_cnf),
           L"OPENSSL_CONF=3D%ls\\ssl\\openssl.cnf", install_path);
       _wputenv(openssl_cnf);
   }

(I would not have brought this up for a v4, but the _countof() needs
to be fixed anyway)

Regarding Selva's comment on the scope of the memory passed to _wputenv(),
I checked MS documentation, and it does not say anything.

OTOH, it points to _wputenv_s(varname,string) which might be worth
considering...

https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/putenv-s-w=
putenv-s?view=3Dmsvc-170

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LOi4CEUtZaawMww9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGbBAEBAgAGBQJhnTakAAoJEB2Cnv7KVigSSHkL91jAEs7iH/jAvaKedQUUSYB/
1SfJ/MEHscot56XJGRumWNONJaBDLcmVAdrbu4U4vIixcPxTI4qLzL8aSpPpUC8I
HQzpjy36DKxA+rK3cC/rVlwos33MFVevOq3oICFMbOvmdmZTQ5cp6EwEeAUo+BIR
cYW1l2yvEkB8bmi+4qbjELle8GooqBzWt9CFHVt6MuCbsaypEDWLXGcJWujloILO
dyqRFSLgt9LMutHz4G8xYcFqPdYXk1fXNkcKmpLZbDxwSDC+uWLQd4+Ghtan4cRM
+naVwU/o1QaJV/D6X+YR5Am9KMJ03FKZU+sMyB9pnCFKySAc8LPDuLpbEsfEI0iF
ZXQ/TViDdO2+m6ZXhpZTgbKfYRUS1B5kHzM9GD/f772FdYYjgD1i1U1788VJk+6L
ZMRozIUHMr5UvTy3qJBYRr6cOBR5qdqJU8xEIyMnwM0LlRtPq7s32PfIyd0zJdtH
fpgUUTSkDUSnT66BJEKMdU4OeidYYqoguTpDRQHR
=dpgh
-----END PGP SIGNATURE-----

--LOi4CEUtZaawMww9--

