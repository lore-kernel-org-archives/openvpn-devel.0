Date: Sun, 7 Oct 2018 09:18:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181007071834.GY962@...1296...>
References: <1477672963-5724-6-git-send-email-heiko.hund@...1489...>
 <20171112082435.15447-1-heiko.hund@...1489...>
 <1700099c-a320-ca5d-384d-cdc35f3e4153@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rXXdS9IWuK35PRlJ"
Content-Disposition: inline
In-Reply-To: <1700099c-a320-ca5d-384d-cdc35f3e4153@...2080...>
Subject: Re: [Openvpn-devel] [PATCHv2 5/7] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--rXXdS9IWuK35PRlJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm going through open patches in patchwork, and noticed the argv stuff
- I remembered that David had reviewed it, but going through the mails
now I can see that we have no ACK yet, because there are changes needed.

On Mon, Nov 13, 2017 at 12:49:27PM +0100, David Sommerseth wrote:
> Thanks a lot for putting a renewed effort into this.  I've reviewed
> this and compile tested with GCC 4.8.5, 6.3.1 and 7.2.1 - as there
> are some warnings appearing; I'll come back to them in a bit.
[..]
> > +argv_printf_arglist(struct argv *a, const char *format, va_list arglis=
t)
> > +{
> > +    struct gc_arena gc =3D gc_new();
> > +    const char *delim =3D 035;
>=20
> argv.c:217:25: warning: initialization makes pointer from integer without=
 a cast [-Wint-conversion]
>      const char *delim =3D 035;
>=20
> argv.c:227:34: warning: passing argument 2 of ???argv_prep_format??? make=
s integer from pointer without a cast [-Wint-conversion]
>      f =3D argv_prep_format(format, delim, &argc, &gc);
>                                   ^~~~~

This really is a bug.  It's declared to be a pointer, but it is used to
just transport "an integer value" (035).  It is valid C, but the compiler
is correct in questioning our motives...

> Shouldn't *delim be just delim?  I'd propose using:
>=20
>    const char delim =3D 0x1D;  /* ASCII group separator character */
>=20
> This also kills all the warnings above.

Yes.

Heiko, can you do a v3 round of the remaining argv patches, taking David's
comments into account?  Then we can get it into master and finish this
work...

thanks!

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rXXdS9IWuK35PRlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbubNKAAoJEB2Cnv7KVigSca4L/0HUjp66v05cf/57MFcK6Zqn
tuI2C6NnQYQWjjfYVigxmuj+fnrlUkixi7ky+OUz1MSjdf6Rlc9COrPHzsjfCtfu
zWOjdSU6A1bKxCgIoc75uHy87EYTkh5Nvl5CDFvH22ilSOx5tXLQaLWPr5aY4w6K
Ls41yyGB4D7V7R1BHIhE4XTg7I3F87fBfahVn80LaLoQyGEoHwRzjj7xtoYDOd6v
Ar6CRgURFW5KUKFf1/4dxwT7igzYor/2HVLqR6aV7MLhapLHYmYz1nS7PkvMvIxj
A4O7EpFF1Ap7EC8wl0OKepuJLEmDu2i4x6V3vBBMz4Vf006bpyA9BpGi4UTg9B52
6lCbbUtzDpVh6WHABjYfXpM3kEqhV3gQFua0LY8Mmfk10AfN91y1RsZQsN8rud4B
Ey1IBuhcvnYQzZojMJRjcy9Kmk9Q0ktBubCX6fNlDym5xF+N1QtGXdQ3RGTqvgfc
gFhrlVXVGZjfvdB75yR8T+cYAixQ7JM3HQHFFAqj+A==
=soYz
-----END PGP SIGNATURE-----

--rXXdS9IWuK35PRlJ--

