Date: Sun, 9 Oct 2022 10:13:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0KCrIxfNxw1V+cg@...1296...>
References: <20170225004014.28638-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UucWhZzfn35lvpzj"
Content-Disposition: inline
In-Reply-To: <20170225004014.28638-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Ignore auth-nocache for auth-user-pass
 if auth-token is pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--UucWhZzfn35lvpzj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 25, 2017 at 08:40:14AM +0800, Antonio Quartulli wrote:
> When the auth-token option is pushed from the server to the client,
> the latter has to ignore the auth-nocache directive (if specified).
>=20
> The password will now be substituted by the unique token, therefore
> it can't be wiped out, otherwise the next renegotiation will fail.
>=20
> Trac: #840
> Cc: David Sommerseth <openvpn@...2080...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

This patch was still sitting "unanswered" in the list archives (though
it never landed in patchwork, as far as I can see).

NAK :-) - on the basis of "multiple rounds of patches from Arne related
to auth-nocache and/or auth-token have landed in 2.4 and 2.5, so I think
the underlying problem has been fixed for good, AND this patch won't
apply anymore anyway".

(Going through my "open issues" mail heap for all that has auth-user-pass
in the subject, since we finally have inline auth-user-passed done... :-) )

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UucWhZzfn35lvpzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjQoKsAAoJEB2Cnv7KVigSKjkL/1sN8LQ16M6R+S2w+620F/tl
kWDZQw0Bo+yRW5ExjdAze/yDn6KjI+I46mxJwkxEv0yjW4vsFaDNuRDqoKGD+S8L
5tl/SK1/3l2Bp5/0RKkcOjLco2r2iLbszCouAbdo4blLl5P/1DTyyp/p/nN24HvD
cQpCrU566wqSF34H6getDbSwjeLyOk3Tdtd6wXQU6+6YO99L5rhjUwOCRrJtnsu0
aA2yWy0xmo0V6/d7NfwZTnq9JgXQUCGevgr06n3imgzFlgWqKazklHQe6kid4m97
TGlqdKl1hguxZrzE9gZ4HaHFPqLufAra2fWVcnG2Z6deDwQHwxBfwDGt+Q+eOhlM
k6wOMiIfuGUvJb2brtipEZjCmgo0G4bhkkAii8jTwth1NGPZiSH7hKc9PIQ1NiBd
1GlPWjRErRaMUNvf0Ve6z/dgM5YyQzaRToHIo5o2SjzngZUvFwvsRwgjCC8lkc+8
XCpLdgAG/0qhfall7Ap6WNraqjGR/qfKWyy+vCduNA==
=Yr59
-----END PGP SIGNATURE-----

--UucWhZzfn35lvpzj--

