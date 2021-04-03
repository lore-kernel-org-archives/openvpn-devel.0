Date: Sat, 3 Apr 2021 15:53:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210403135319.GX976@...1296...>
References: <20210310154754.GH976@...1296...>
 <20210317130312.8585-1-arne@...1227...>
 <20210317130312.8585-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YTcNN5VuguwlzRs8"
Content-Disposition: inline
In-Reply-To: <20210317130312.8585-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Implement deferred auth for
 scripts
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

--YTcNN5VuguwlzRs8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 17, 2021 at 02:03:12PM +0100, Arne Schwabe wrote:
> This patch also refactors the if condition that checks the result of
> the authentication since that has become quite unreadable. It renames
> s1/s2 and extracts some parts of the condition into individual variables
> to make the condition better understandle
>=20
> Patch v2: add refactoring of the if condition
> Patch v4: fix documentation not mentioning method as 2nd line
> Patch v5: fix deferred auth used by both plugin and script not working
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

Looking at the --enable-async-push fix-patch, it seems that this one
also needs to add an inotify watch for ks->script_auth.auth_control_file,
no?

Haven't tested the rest yet.  First glance looks good, but without
"dual-inotify" this looks incomplete.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YTcNN5VuguwlzRs8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgaHNOAAoJEB2Cnv7KVigSGHgL/1EnnPh44P/nGKWKmWKNev0Z
KYtEBqPfts5FOd7BBQtns5LDx28fesqhCZ7AxH/MK3Z85hVggyrH7/91x2N/MWB8
q7q7nMEM58lIy7/5mALO6vfgs/c+IFyqPZfFPkNmR4dSSW6ygnSKAAPh3+0wyc2J
n8xnA9BbVijNQTvIknnOJsZdQ3tFX8ddBo6vePemuyHAEaz4x1UdzTiol2JniI23
s56OzvIxIr/pouTmv3mlYg4UCk+us2a1IXnlXFC0KjTSZRy3TRED+bT27NKcbMNl
o2Ees/amH1pqUUGzBSWXdQTFeh7WRS7EiRFFFpqgd8n0DnBk0DkXW4IY7RRKfVMm
Bb3pEtvkynnEuh+eIWxrzTfo4JYVL1/AtK5Uvp47b0PuadAudFwj7wOTlYt1n7nE
qNzfA58PzSN+IXfR3WHYYhKJKoHL0MhI8hemvQfNPeNJ7j+UIx02LDkfskm1WNkV
yIPwj+YMNqAnLghmBDI+Mus09tEIvzs587PgIaPE9Q==
=gHi/
-----END PGP SIGNATURE-----

--YTcNN5VuguwlzRs8--

