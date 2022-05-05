Date: Thu, 5 May 2022 13:49:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YnO53yJ4oY9k3ynp@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9xIXlYtKgTuBkQ8z"
Content-Disposition: inline
Subject: [Openvpn-devel] FYI: .git-blame-ignore-revs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--9xIXlYtKgTuBkQ8z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

JFYI, I have added the last two "just whitespace" patches to
the master .git-blame-ignore-revs file

diff --git a/.git-blame-ignore-revs b/.git-blame-ignore-revs
index 1e940dba..c104cce9 100644
--- a/.git-blame-ignore-revs
+++ b/.git-blame-ignore-revs
@@ -39,3 +39,9 @@ f57431cdc88f22fa4d7962946f0d3187fe058539
=20
 # The Great Reformatting - first phase
 81d882d5302b8b647202a6893b57dfdc61fd6df2
+
+# Fix trailing-whitespace errors in last patch.
+3282632d9325267c850072db7545a884a1637f51
+
+# The Great Reformatting of 2022
+abe49856d81f51136d543539202a0bf8fb946474


... pushed as commit 1f1b8980a5914590.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9xIXlYtKgTuBkQ8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJic7nfAAoJEB2Cnv7KVigS+asMAKDBNFwB5S+Hiq7kFn4zhFxj
8necxBbDKdGhD1bSZwVxt1pBbfC2oDEOW4yR74QpxzfPCa+v9QJ3IfPiUmdZfVVA
BS3ZTL5InHDmyOO/L1LDV5qpqpueGEcistzfcWXjykFpVUiZv7N4Uimwovf4lKqN
xaxG9rbPgHaP1LGvzhaoUHT8TFQXq5qpBcAgOIUP6PXx8KkqKd7ocZAHlVizyTz9
X4Fax/sMQCQol71ge6lrqzUtKPYUbiONZOTjKow3pO+xRrQ9rsHjdQhEVt+zmMpJ
GvpEzr66e7SgcT2pwmP1jK8tIawaafKr9r2Lvl5pBVFTgZmo1XVmdarTt6BpadgZ
ckAo2Ek8d7aYGHtpA+crBwXYMbGPoPgiM7oaLtRabnC/CVvUQoyj4LUtu6eusPTt
pbZ/7f/u3jaKpYkmMeWJd0L7Z+ohLVPLjOmLFRQA+EfmrzJHlxtWERAfyb9bJzML
HBVG1V19txy4HfUHHU1hGR3/x5wT3KOJyeb/i0EbvQ==
=e2eg
-----END PGP SIGNATURE-----

--9xIXlYtKgTuBkQ8z--

