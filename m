Date: Thu, 11 Aug 2022 13:29:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvToJJLJUoQluR9b@...1296...>
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Aw0hc7JmJpw31D1p"
Content-Disposition: inline
In-Reply-To: <202208111003.27BA3jBP091528@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

--Aw0hc7JmJpw31D1p
Content-Type: multipart/mixed; boundary="wM/8XXcuIexoBDC6"
Content-Disposition: inline

--wM/8XXcuIexoBDC6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 11, 2022 at 12:03:45PM +0200, Gert Doering wrote:
> Uncrustify complained about two lines with tabs -> fixed.

Turns out that it's actually 4 lines, and while I did "git apply $patch",
I forgot the "git commit --amend platform.c", so the whitespace errors
landed in the commit, and the *fix* was still sitting in my tree.

Since this is just whitespace, I'll merge the patch as follows,=20
into=20

commit 649874df9edb52a9d85bf9db690b6150fdb6dcc9 (HEAD -> master)
Author: Gert Doering <gert@...1296...>
Date:   Thu Aug 11 13:26:58 2022 +0200

    Apply uncrustify changes that forgotten in the last patch.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wM/8XXcuIexoBDC6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Apply-uncrustify-changes-that-forgotten-in-the-last-.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 649874df9edb52a9d85bf9db690b6150fdb6dcc9 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Thu, 11 Aug 2022 13:26:58 +0200
Subject: [PATCH] Apply uncrustify changes that forgotten in the last patch.

commit 2e359a088226ab1e5 has a few whitespace errors that uncrustify
complained on merge, but due to git handling mistakes, these were not
properly included in the actual commit.  Fix.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/platform.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index e6778b3f..327a2d23 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -205,9 +205,10 @@ need_keep_caps(struct context *c)
  * =3D=3D0: Don't attempt to retain any capabilities, just sitch user/grou=
p.
  *  <0: Try to retain capabilities, but continue on failure.
  */
-void platform_user_group_set(const struct platform_state_user *user_state,
-                             const struct platform_state_group *group_stat=
e,
-                             struct context *c)
+void
+platform_user_group_set(const struct platform_state_user *user_state,
+                        const struct platform_state_group *group_state,
+                        struct context *c)
 {
     int keep_caps =3D need_keep_caps(c);
     unsigned int err_flags =3D (keep_caps > 0) ? M_FATAL : M_NONFATAL;
@@ -249,7 +250,7 @@ void platform_user_group_set(const struct platform_stat=
e_user *user_state,
     if (res =3D=3D -4 || res =3D=3D -6)
     {
         /* -4 and -6 mean failure of setuid/gid respectively.
-           There is no point for us to continue if those failed. */
+         * There is no point for us to continue if those failed. */
         msg(M_ERR, "capng_change_id('%s','%s') failed: %d",
             user_state->username, group_state->groupname, res);
     }
@@ -268,11 +269,11 @@ void platform_user_group_set(const struct platform_st=
ate_user *user_state,
=20
     if (new_uid >=3D 0)
     {
-         msg(M_INFO, "UID set to %s", user_state->username);
+        msg(M_INFO, "UID set to %s", user_state->username);
     }
     if (new_gid >=3D 0)
     {
-         msg(M_INFO, "GID set to %s", group_state->groupname);
+        msg(M_INFO, "GID set to %s", group_state->groupname);
     }
=20
     msg(M_INFO, "Capabilities retained: CAP_NET_ADMIN");
--=20
2.37.1


--wM/8XXcuIexoBDC6--

--Aw0hc7JmJpw31D1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi9OgkAAoJEB2Cnv7KVigSVOAMAKF4xualfhtaTNX3zZO6VPeR
4CMy//4GnXZ0JeiHvyJwQJcuycAmfvCiR2ombfikk1igh7fWedhz39xbGxTyxNwp
Xsl+X5n7EewHaKrcL6OnMJxCU9nmOLmM/P0pia3hfs1MFWeymM67nciuT12Bz2AQ
8/23IJMHYmYt+6pVEmj7xGwpisFmiUbm0rMCQxVqwYkXpSz7c/Iagn0kRhurcMRQ
g02ExEU78XSlYyKOwXrm5zkJMWakp1+DiW/V2Muejaclj19+M+sMpt+A2ApxwfAz
LSeJBdDy72lIbv2bnStYg8KICz+xI9RHQlAhuuzPllm/F3nRPwxiSPDuScAF6vhE
5XNWVm9FiVG3zD/5xVDjdwG29GjGIiBvJD7iHEBN/saiEFQEoeZjiYQcMnG3yv5b
WYsL791pD58GIKqme5ArXoLUIHl4e40hUaL3DUQhSRQtVtTdNethG8uDi1qMGtJj
SmZQo3skEXcFyzEsN6MqyaGqfRLVXXIgDPWi87a3ZA==
=o+0w
-----END PGP SIGNATURE-----

--Aw0hc7JmJpw31D1p--

