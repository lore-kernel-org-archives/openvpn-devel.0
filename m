Date: Sun, 19 Apr 2020 12:27:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200419102725.GA1431@...1296...>
References: <20200416113930.15192-1-arne@...1227...>
 <20200416113930.15192-3-arne@...1227...>
 <5e764697-b61e-7115-7e3c-fcc7bf0407e7@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iGPeegZQesVaZT1L"
Content-Disposition: inline
In-Reply-To: <5e764697-b61e-7115-7e3c-fcc7bf0407e7@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] After the last big formatting
 patch a number of changes have been commited that do not conform with our
 style/uncrustify config. This has lead to the problem that running
 uncrustify on before sending PR some of the changes made by uncrustify need
 to be backed out again.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--iGPeegZQesVaZT1L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 17, 2020 at 05:01:29PM +0200, Antonio Quartulli wrote:
> > -    char* ret =3D management_query_multiline_flatten(man,
> > -            (char *)buf_bptr(&buf_data), prompt, desc,
> > -            &man->connection.ext_key_state, &man->connection.ext_key_i=
nput);
> > +    char *ret =3D management_query_multiline_flatten(man,
> > +                                                   (char *)buf_bptr(&b=
uf_data), prompt, desc,
>=20
> why not moving some arguments on the first line ? One or two should fit.
> (IMHO it can be done in this patch - it's still about restyling)

The point of a "this is what uncrustify produces" patch is to produce
something which is immutable on future runs of uncrustify - so we can
check *new* code, without having to ignore other stuff that uncrustify
wants to change every time.

So, running uncrustify, and then changing things for a nicer look is
not solving the underlying issue.

(OTOH, if it turns out that some uncrustify option should be *changed*,
to produce nicer looking code, we can always do that after a quick round
of discussion in the meeting)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--iGPeegZQesVaZT1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJenCeMAAoJEB2Cnv7KVigSzwgMAJ7z3inkoWH4Az5utebcDlgf
RyXyRrarCprGVW+GeK6XQ9wgvmGn3atDfWNTl4B/zgAv+DccofJfNrGNLpwSScpR
c++eessV+dsI2trWa4jAnyQ+jZMaoRBNM+zaVV0C4adoQr37pBhLg8/EdcnkqHk3
5Ehg2AAMaQWxmzR/S9/6q00J7bzVh6uzvsyQ2F8uhQrILpEiOwDPqBWpZeSaxXWE
ovDNxap02Qa6I7wU69xmGpS9ef65lXRP5o6v2iRHOhv8yNcFFQ2OjJ3/+V8OHG+b
Qs84S8ikxZOygVTlm9VteKjX+GVOboD3k9IywO99JYLCUhEnB8G9Jbgly2lLnpsA
hllY6KjvqWRLShGOAQDNUDpCNfocHZAgGD4e2BxXt4o5JoJjmn00/cXsPVHps762
zkrAwdwitPWjB4moqkHnFOZ/S41zPOKRrQMIrpM4DLwClTkec4zJZRjfb7JWlvjH
S+HJ4sl658Rt3Md7Ei/jAUv3jmUBSDFt2FBxbHKuxA==
=P82c
-----END PGP SIGNATURE-----

--iGPeegZQesVaZT1L--

