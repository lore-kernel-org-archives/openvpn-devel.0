Date: Sun, 28 Mar 2021 14:17:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210328121749.GE976@...1296...>
References: <CAALvpZTo6VYxcLXtXXyMsUU-n3JRSOJ-62fny7Zfi28WSDYXmA@...278...>
 <b63128cc-14cf-b1a4-684d-4c3fcb291f04@...2181...>
 <20210328085248.GB976@...1296...>
 <CAALvpZRVrgCb7JZVf=fkgJK73rk8WAHF+Hj_brQO=ww=_yuUMQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iBFCiuOmVjpoRqk4"
Content-Disposition: inline
In-Reply-To: <CAALvpZRVrgCb7JZVf=fkgJK73rk8WAHF+Hj_brQO=ww=_yuUMQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?T=F5ivo_Leedj=E4rv?= <toivol@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

--iBFCiuOmVjpoRqk4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 28, 2021 at 02:03:37PM +0200, T=F5ivo Leedj=E4rv wrote:
> The specific issue I ran into was getpass() having 8 character limit
> on Solaris/illumos.

Ah, thanks for that reminder.  That is, indeed, a strong argument (and
who knows which other platforms might do this and we don't know about
it yet).

> If you don't mind the code being guarded by an #ifdef TARGET_SOLARIS
> then a simple alternative patch would look something like this:
> -        char *gp =3D getpass(prompt);
> +#ifndef TARGET_SOLARIS
> +        char *gp =3D getpass(prompt); /* On Solaris, returns up to 9 byt=
es */
> +#else
> +        char *gp =3D getpassphrase(prompt); /* Returns up to 257 bytes */
> +#endif

No extra #ifdef please - let's go for a v2 of your patch, with the
error checking.

> > Actually we should catch errors here and log them.  If tcsetattr() fail=
s,
> > the tty will be in a messed-up state - so we want to know that it happe=
ned,
> > and possibly also the "why".
>=20
> Right. What you have in mind, would that look like msg(M_ERR,
> "...explanation...") or perhaps an M_WARN?

msg(M_WARN | M_ERRNO, "tcsetattr() failed to restore tty settings")

(or some other wording to that extent) should do.

(Some parts of the code uses the M_* macros differently, but half of that=20
is due to unclear documentation how they should be used, and lack of=20
stringent commit regime :) )

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--iBFCiuOmVjpoRqk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgYHPsAAoJEB2Cnv7KVigSCOoMAJrjy8cNAm+QWyqT+sTnjFtT
J7iLwaOoUYZ7Nyi5CjYBOaeMOE2m0XdRry0z5fYiEfxSflRkoKPS5P3ftKjusL8V
8qDHaA+Iz0piTImso60jBulj7vUE+IsqXk2S3kKrZFQ9clZEh4CQQ8OtLwQ0PJc6
Q9CWnqOEEP6Ph4km0YaMr3gy9OMrW3+z2QzE6b2N0ook87m+9CggD8Sj/3eOXzqM
e4f4zYsbgCZMxEO6YrvKIKYGsmqnJpfL5FP03HzYMYC/d9okSK9FgOJH3lkukoIU
X43ks5hsf8Do4rFdjpkhM9zBFhBfXFWDDc7G4YuHvoitm1HwiHlbui3nnTnEI6G9
p+tNhSN5k2qkgfcbFaVM70FU1jhl7FXqMIK9K0j/43pGoL2gPj3pGghDPbiHqK4S
kmUAuzOwADIq6ZDA1G1XLkETvDzBFinqY6Z79hBBPhCzZkmslDwhxXVHAH+nEoz4
4QBS8dqhYe/5/zTvcwBaXTj+Wn938WgRUuOvB2PVVw==
=1kZ6
-----END PGP SIGNATURE-----

--iBFCiuOmVjpoRqk4--

