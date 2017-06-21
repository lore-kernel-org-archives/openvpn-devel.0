Date: Wed, 21 Jun 2017 12:21:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170621102150.GA74026@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
Subject: [Openvpn-devel] NTLM.c security fix / CVE-2017-7520
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--bCsyhTFzCvuiizWE
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline

--liOOAslEiF7prFVr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

most patches that went into the tree today came to me by git-send-email,
so I could re-send them to the list after embargo, and message-id:s=20
referenced in the code match between mailing list, git tree, and
in-reply-to in the ACK mail.

One patch came as a patch attached to a longer mail that I do not want
to bounce "as is" to the list - so here's the patch that originally came
to me as=20

  Message-Id: <CAO5O-EJvHKid-zTj+hmFG_3Gv78ixqCayE9=3DC62DZaxN32WNtQ@...2283...=
...>

and is referenced as such, plus my ACK-and-merge mail, both as attachments.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="guido-ntlm.txt"
Content-Transfer-Encoding: quoted-printable

=46rom 83694284a1b7918fdf55c2e4ebebce2126bd92fa Mon Sep 17 00:00:00 2001
=46rom: Guido Vranken <guidovranken@...277...>
Date: Fri, 19 May 2017 14:04:25 +0200
Subject: [PATCH] Prevent two kinds of stack buffer OOB reads and a crash for
 invalid input data

Signed-off-by: Guido Vranken <guidovranken@...277...>
---
 src/openvpn/ntlm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 0c43681..bb8679f 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -197,7 +197,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const cha=
r *phase_2, struct gc_are
      */
=20
     char pwbuf[sizeof(p->up.password) * 2]; /* for unicode password */
-    char buf2[128]; /* decoded reply from proxy */
+    unsigned char buf2[128]; /* decoded reply from proxy */
     unsigned char phase3[464];
=20
     char md4_hash[MD4_DIGEST_LENGTH+5];
@@ -303,7 +303,13 @@ ntlm_phase_3(const struct http_proxy_info *p, const ch=
ar *phase_2, struct gc_are
                 tib_len =3D 96;
             }
             {
-                char *tib_ptr =3D buf2 + buf2[0x2c];           /* Get Targ=
et Information block pointer */
+                char *tib_ptr;
+                int tib_pos =3D buf2[0x2c];
+                if (tib_pos + tib_len > sizeof(buf2))
+                {
+                    return NULL;
+                }
+                tib_ptr =3D buf2 + tib_pos;                               =
/* Get Target Information block pointer */
                 memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);           /*=
 Copy Target Information block into the blob */
             }
         }
--=20
2.1.4


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="guido-ntlm.reply"
Content-Transfer-Encoding: quoted-printable

=46rom: Gert Doering <gert@...1296...>
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: [PATCH applied] Re: Prevent two kinds of stack buffer OOB reads an=
d a crash for invalid input data
In-Reply-To: <CAO5O-EJvHKid-zTj+hmFG_3Gv78ixqCayE9=3DC62DZaxN32WNtQ@...2284...=
ail.com>
References: <CAO5O-EJvHKid-zTj+hmFG_3Gv78ixqCayE9=3DC62DZaxN32WNtQ@...2285...=
il.com>

ACK.

Your patch has been applied to the master, release/2.4, 2.3 and 2.2 branch.

commit 7718c8984f04b507c1885f363970e2124e3c6c77 (master)
commit 043fe327878eba75efa13794c9845f85c3c629f2 (release/2.4)
commit f38a4a105979b87ebebe9be1c3d323116d3fb924 (release/2.3)
commit 4bec9d25d519a56bc40458e947d3dfa964b82b13 (release/2.2)
Author: Guido Vranken
Date:   Fri May 19 14:04:25 2017 +0200

     Prevent two kinds of stack buffer OOB reads and a crash for invalid in=
put data

     CVE: 2017-7520
     Signed-off-by: Guido Vranken <guidovranken@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <CAO5O-EJvHKid-zTj+hmFG_3Gv78ixqCayE9=3DC62DZaxN32WNtQ@...2286...=
l.gmail.com>
     URL: https://www.mail-archive.com/search?l=3Dmid&q=3DCAO5O-EJvHKid-zTj=
+hmFG_3Gv78ixqCayE9=3DC62DZaxN32WNtQ@...278...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


--liOOAslEiF7prFVr--

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZSki9AAoJEB2Cnv7KVigSxs4L/iQWWUkIeHAO0JXtbdAsDnta
cobBWCLe3ZnmXWzcKenKMO02Q8bjfu2GgZc/dcKsDtQmKEz3YG1DiMTGBL3PDmCp
at4EvKa2jSMcN3oIPwoMyrMNTgScLRlJ6fl4EbpLCp7x2H/N74I5X7enPRdQs7Dt
qxdyCKJ9cKUZQMb5d5v3crITDVZCtY/fvzbLhj0ooMkHX23991pF8yl3bScfwCyx
3cqXEgxlF36muFBSD91Gt3NZIt+2EtJNVpH1GTziZ9vBCz68ssI32jB0j+qon99O
XlQP7fJ2FnttfqMcZmoUmq5KyLCI1E/gSLp1oDZY8p9NmKCa2KRtPcaK59YdwUxp
JzudcPpmb3e8xKZQKTzRfMKLV77sI24M+IglV8fu7witTx7cR12f6fCgDlRvptgP
vPKJxhR93Q2Kp9XUZ4+LnBVJVOguvstPGVMrDPzVRtNdDgiSfSHFsst2dvz01c0u
I5gxMe1XVELGzr64qpI8QU6f/zqaiMU+te0/vvmdGw==
=syET
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

