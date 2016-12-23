Date: Fri, 23 Dec 2016 22:36:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161223213649.GM78624@...1296...>
References: <1482524791-5788-1-git-send-email-steffan@...1856...>
	<CAKuzo_jKfWW0TA2TUzFhPFOQa6JjtfDNpiAStTUp4vyT+7yOOw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GaDTZZn2ADWB060d"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jKfWW0TA2TUzFhPFOQa6JjtfDNpiAStTUp4vyT+7yOOw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add nl_for_brace=add to uncrustify.conf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--GaDTZZn2ADWB060d
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 23, 2016 at 04:23:48PM -0500, Selva Nair wrote:
> nl_after_semicolon
> (I know no one here writes x=3D1; y=3D2; z=3D 3; on the same line,

Well... looking at route.c, seems I've been guilty of a few such
cases...

But then, I'm not sure I consider this necessarily a "MUST CHANGE!"
bad style:

route.c:        msg(M_WARN|M_ERRNO, "GDG6: socket() failed" ); goto done;
route.c:        msg(M_WARN|M_ERRNO, "GDG6: send() failed" ); goto done;
route.c:        msg(M_WARN|M_ERRNO, "GDG6: recv() failed" ); goto done;

(that's your typical "talk to weird APIs with lots of system calls that
supposedly never fail but you need to check the return code for each=20
of them anyway, as they *could*" code ugliness...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GaDTZZn2ADWB060d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYXZjwAAoJEB2Cnv7KVigSlD4L/2DIkfDWrPg1ow865FM5M/fM
iDK8wa5jWgrrxrsBePPpn/Esj9XBrntAdF+eyJPGUWW+Ux6z5+xA8CujLWX1hqGy
MWYqB8CoY8eGmzul/b2BzTpFqccc2hXYOoh0kzHk3cB99P2Bdb+8aez20+TKyqX5
5CGX+Ea1Dt8Slq/4aGlrvKG/kkMm5y/4397cROCOypz6JJD+X98W3kdkKxz3P2g9
ujI2UGr5iYZ1UVLGvM+JCGGObsxTRDbO2sI/b72zaUxbVHWZN/EKd30IEKvXmDyv
Ac5HOU5Osc0opj4RHVveiJnMn19IDRcivbPQfVhwhAjWR2rtT/GIIWb9hyaUehC2
O6dlxxpL2SC1ZunsW7jPmDJVa2SQ0/KloJog1v7s1hnFopI4beAWQ2IF9Q5ASAEo
Gtlbbfuw784Ty2pFvF0Ru9Q6ojExo08b3CRj8k5wVYoGXVkY/ueREHkzgF1yKHWB
qv3Mx2dAkzQK+rTfsBG31l7rmvg6wDdjwrk+WWRG5Q==
=PSHE
-----END PGP SIGNATURE-----

--GaDTZZn2ADWB060d--

