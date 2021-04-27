Date: Tue, 27 Apr 2021 13:02:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210427110214.GQ976@...1296...>
References: <20210426174436.26210-1-gert@...1296...>
 <f08a95a9-1b87-ab19-6e9d-cac9c63c862a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CNseZIf+g+2irJvr"
Content-Disposition: inline
In-Reply-To: <f08a95a9-1b87-ab19-6e9d-cac9c63c862a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] rewrite parse_hash_fingerprint()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--CNseZIf+g+2irJvr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 26, 2021 at 09:58:38PM +0200, Antonio Quartulli wrote:
> > Rewrite error message to differenciate "hash too short" (including
> differenciate -> differenTiate

fixed.

> > -    int i;
> > +    int i=3D0;
>=20
> spaces around the '=3D'

fixed.

> > -        if (strlen(cp) < 2)
> > +        /* valid segments consist of exactly two hex digits, then ':' =
or EOS */
> > +        if (!isxdigit(cp[0])
> > +            || !isxdigit(cp[1])
>=20
> since we have a limit of 80 chars per line, how about putting the two
> conditions above on the same line?

I tried, but found it "not easier to read".=20=20

The way it is, it's really "3 lines for the 3 checks for the 3 bytes"
(and then one check for "all of it"), so I find it more logical.

> Regarding the format string, we concluded on IRC that %hhx is part of
> C99 - why not using it here then?

As I said there: C99 is a compiler standard, but %hhx is something the
library has to provide.  I do not trust C libraries in that regard -
imagine someone compiling OpenVPN with a nice and shiny C99 compiler
and then linking with some stripped down C library for an embedded
system, which doesn't do %hhx.  Interesting memory corruption, impossible
to diagnose.

Now, I have no idea whether uc-libc, musl, ... *do* support %hhx, but
I do not see use of this as particular readability-enhancing while it
carries a portability risk.  %x -> (int) works, everywhere.

> > +        ret->hash[i++] =3D (uint8_t)byte;
>=20
> This cast would go away if byte is declared as uint8_t and we use %hhx
> in the sscanf().

We could sscanf() to ret->hash[i] right away, then - but again, I
do not think the extra step would be better for readability, and it
does carry a risk.

> > -        if (term =3D=3D 0)
> > +        term =3D cp[2];
> > +        if (term =3D=3D '\0')
>=20
> do we really need "term" at al at this point?
> we could directly use cp[2] in the if condition.

If we exit the loop because we have reached (i =3D=3D nbytes), cp will
point at the character "after the end-of-string" (because of cp +=3D3),
so cp[2] is well into "undefined territory" land.

> > +    if (i < nbytes)
> >      {
> > -        msg(msglevel, "hash fingerprint is different length than expec=
ted (%d bytes): %s", nbytes, str);
> > +        msg(msglevel, "hash fingerprint is wrong length - expected %d =
bytes, got %d: %s", nbytes, i, str);
> > +    }
> > +    else if (term !=3D '\0')
>=20
> same here: if we hit the else branch, it means that cp[0,1,2] are all
> defined so we can again compare cp[2] to '\0'.

Actually, no.  We hit this branch when we exit the loop due to
(i=3D=3Dnbytes) after the cp +=3D3;  This happens if you have malformed
input that is too long, so after having found "nbytes", term is ":",
so cp +=3D 3, and then the loop ends.

Pure OpenVPN style would be, of course, to do the cp +=3D 3 first
(and alway), and then look at cp[-1], but no, I'm not going there.

> Should we also print options->verify_hash_depth while at it?

Done!

v2 incoming...  including a bugfix to the original commit :)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CNseZIf+g+2irJvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgh+81AAoJEB2Cnv7KVigSY+4MAIVR5O/IpPMBkimXyroMYVki
S6i0BhIglnYD64omFMFGAaJa9DG/0Broapl0hw2akH0QEvo+FOWis3opKG2jBbBT
NWTCrTLT/ubvAuHIOKUjF+cjnvIOcEkvIELG+OG0BUEfeJ58UMOjLykS9t8mz2RO
AAdHf9kBmY07YB8EZLAalJ5icoqxPlqPPTl4oarL066qiw6x5vM/+/bnS9fNV9qg
zerp+WaYBlnB4hZWK+6IFAQNFYKKZGQ2eL/5MMuO3zIDMui7PJfBWbypNOoCpb8j
nA1UZrrlTfIzGql3kw83cj9PoMcI5zQ29qt+M0lEyuZY+Q/g45Gz6GHbX9wf9NAc
KaB8rMLIRQg3O4jel62kDTDttC8L1vR/MkXjm5JmX3NOfz1uhZhphnnqoKTwWioY
ww8eEV5eXvb5FmRj/eoTzdzA3KA2ZYT96ZoNGdbgzHtCq3w6A/2I5no5Aww5nF1b
GfcdlyJwWKw0NieHvNdbCkS5GiuD5WDJw2J7P82NQg==
=0CR0
-----END PGP SIGNATURE-----

--CNseZIf+g+2irJvr--

