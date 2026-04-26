Date: Sun, 26 Apr 2026 17:42:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ae4yZ7aYJyzX-i2z@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AJsKHi8cto2USXrv"
Content-Disposition: inline
Subject: [Openvpn-devel] non-public patches in recent releases (CVEs)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--AJsKHi8cto2USXrv
Content-Type: multipart/mixed; boundary="+yq+TVETvHELcyjw"
Content-Disposition: inline

--+yq+TVETvHELcyjw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

unlike normal "patch on the list (directly or via gerrit), ACK/+2 in
public, commit + merge info on the list", patches that carry a CVE
tag are handled privately.  Whether or not this is always necessary
could certainly be debated, but however, in the last releases=20
(2.7.2, 2.6.20, and master) we had two of them.

To enable verification that the source has what was discussed and
approved, I'll attach the patches plus the relevant commit IDs.

commit 64fae9d82989ede6c92e230c594ab9335c05df8d (master)
commit 4a2c827c2536aa03a1d6c7cc916689a46c067187 (release/2.7)
commit 4472265ea2d18b88bb5f59fb30d4067a0323aff5 (release/2.6)
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Apr 10 16:59:53 2026 +0200

    Ensure that buffer of freed session are not used
    CVE: 2026-40215

commit fa129d7153f7292f7b6f7341601ae97d5c47e36e (master)
commit 607e2fcb9cbcff785abfa372c7a59029767b5ed9 (release/2.7)
commit 0dc820fe1d0de369d101702151fa06fff0eb360c (release/2.6)
Author: Steffan Karger <steffan@...1856...>
Date:   Sun Apr 12 13:37:56 2026 +0200

    tls-crypt-v2: Avoid interpreting opcode as part of WKc
    CVE: 2026-35058

Details in the commit logs, and on the web

https://community.openvpn.net/Security%20Announcements/CVE-2026-40215
https://community.openvpn.net/Security%20Announcements/CVE-2026-35058


both are not of the "the world will end" category, but the ASSERT() one
is nasty as you can make a remote server stop itself *iff* tls-crypt-v2
is used, and you can create a sufficiently-malformed packet, signed with
a valid tls-crypt-v2 client key.

So, you should see that you upgrade *your servers*.

Clients are not affected.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+yq+TVETvHELcyjw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-tls-crypt-v2-Avoid-interpreting-opcode-as-part-of-WK.patch
Content-Transfer-Encoding: quoted-printable

=46rom fa129d7153f7292f7b6f7341601ae97d5c47e36e Mon Sep 17 00:00:00 2001
=46rom: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Apr 2026 13:37:56 +0200
Subject: [PATCH 1/2] tls-crypt-v2: Avoid interpreting opcode as part of WKc

The buffer we pass to tls_crypt_v2_extract_client_key contains the
entire received control channel packet. We should skip the opcode before
trying to read WKC.

This logic error is a second bug behind the XlabAI finding, next too the
too-strict ASSERT in tls_crypt_unwrap.

Also remove a too strict ASSERT in tls_crypt_unwrap.  We already check
a few lines later for a too short packet and return a proper error
("packet too short").

XlabAI found a way of triggering this ASSERT that requires a tls-crypt-v2
client key that has a specific property (a specific byte need to have a
specific value, about 1/256 probability). If an attacker can get hold of
such a tls-crypt-v2 client key or observe a handshake using such a key,
the attacker can trigger the ASSERT, crashing the server. Setups that do
not use tls-crypt-v2 are not affected.

Independently, Cisco Talos reported a way to trigger this ASSERT with any
tls-crypt-v2 key but this requires the attacker to be also in possession
of the private key part of the tls-crypt-v2 client key or to inject packet
into a live session of a client session.

CVE: 2026-35058
Reported-By: XlabAI Team of Tencent Xuanwu Lab (xlabai@...3025...)
Reported-By: Guannan Wang (wgnbuaa@...277...
Reported-By: Zhanpeng Liu (pkugenuine@...277...)
Reported-By: Guancheng Li (lgcpku@...277...)
Reported-By: Emma Reuter of Cisco ASIG (TALOS-2026-2381)
Signed-off-by: Steffan Karger <steffan@...1856...>
Signed-off-by: Arne Schwabe <arne@...1227...>

Change-Id: I623733c0476c98f436d19009ee8990693c1579b5
Private-URL: https://github.com/OpenVPN/openvpn-private-issues/issues/111
Acked-by: Gert Doering <gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tls_crypt.c                   |  4 ++--
 tests/unit_tests/openvpn/test_tls_crypt.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 70889dcf..e91f80cf 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -216,7 +216,6 @@ tls_crypt_unwrap(const struct buffer *src, struct buffe=
r *dst, struct crypto_opt
     gc_init(&gc);
=20
     ASSERT(opt);
-    ASSERT(src->len > 0);
     ASSERT(ctx->cipher);
     ASSERT(packet_id_initialized(&opt->packet_id) || (opt->flags & CO_IGNO=
RE_PACKET_ID));
=20
@@ -619,7 +618,8 @@ tls_crypt_v2_extract_client_key(struct buffer *buf, str=
uct tls_wrap_ctx *ctx,
     struct buffer wrapped_client_key =3D *buf;
     uint16_t net_len =3D 0;
=20
-    if (BLENZ(&wrapped_client_key) < sizeof(net_len))
+    if (!buf_advance(&wrapped_client_key, 1)
+        || BLENZ(&wrapped_client_key) < 1 + sizeof(net_len))
     {
         msg(D_TLS_ERRORS, "Can not read tls-crypt-v2 client key length");
         return false;
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 1776d71c..161ee908 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -518,7 +518,16 @@ tls_crypt_v2_wrap_unwrap_max_metadata(void **state)
         .mode =3D TLS_WRAP_CRYPT,
         .tls_crypt_v2_server_key =3D ctx->server_keys.encrypt,
     };
-    assert_true(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL=
, true));
+
+    /* a buffer that only contains the wrapped key should fail */
+    assert_false(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NUL=
L, true));
+
+    /* add a opcode in front of the key to make it valid to extract */
+    struct buffer wkcop =3D alloc_buf_gc(buf_len(&ctx->wkc) + 1, &ctx->gc);
+    buf_write_u8(&wkcop, 0x50);
+    buf_copy(&wkcop, &ctx->wkc);
+    assert_true(tls_crypt_v2_extract_client_key(&wkcop, &wrap_ctx, NULL, t=
rue));
+
     tls_wrap_free(&wrap_ctx);
 }
=20
--=20
2.53.0


--+yq+TVETvHELcyjw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-Ensure-that-buffer-of-freed-session-are-not-used.patch
Content-Transfer-Encoding: quoted-printable

=46rom 64fae9d82989ede6c92e230c594ab9335c05df8d Mon Sep 17 00:00:00 2001
=46rom: Arne Schwabe <arne@...1227...>
Date: Fri, 10 Apr 2026 16:59:53 +0200
Subject: [PATCH 2/2] Ensure that buffer of freed session are not used

In a race condition an old TLS session could still try to send a packet but
also get replaced by a new session. In this case, the buffer of the new
session is still referenced. Add the check_session_buf_not_used function
to mitigate this problem.

Also make the check if the to_link pointer is in one of the memory
regions a bit better even though this not make a difference with the
way we use these structs. But better safe than sorry.

A better solution to remove the TM_INITIAL state and handle reconnecting
session in their own complete tls_multi is a more involved fix that requires
a lot more refactoring.

CVE: 2026-40215
Reported-By: XlabAI Team of Tencent Xuanwu Lab (xlabai@...3025...)
Reported-By: Guannan Wang (wgnbuaa@...277...
Reported-By: Zhanpeng Liu (pkugenuine@...277...)
Reported-By: Guancheng Li (lgcpku@...277...)
Signed-off-by: Arne Schwabe <arne@...1227...>

Change-Id: I7c5fa2a7a2563b7a8955d386411f3ceffe5b092f
Private-URL: https://github.com/OpenVPN/openvpn-private-issues/issues/112
Acked-by: Gert Doering <gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5868d531..d332359c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3290,6 +3290,7 @@ tls_multi_process(struct tls_multi *multi, struct buf=
fer *to_link,
                 if (i =3D=3D TM_ACTIVE && ks_lame->state >=3D S_GENERATED_=
KEYS
                     && !multi->opt.single_session)
                 {
+                    check_session_buf_not_used(to_link, session);
                     move_session(multi, TM_LAME_DUCK, TM_ACTIVE, true);
                 }
                 else
@@ -3363,6 +3364,7 @@ tls_multi_process(struct tls_multi *multi, struct buf=
fer *to_link,
      */
     if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL].key[KS_PRIMAR=
Y]))
     {
+        check_session_buf_not_used(to_link, &multi->session[TM_ACTIVE]);
         move_session(multi, TM_ACTIVE, TM_INITIAL, true);
         tas =3D tls_authentication_status(multi);
         msg(D_TLS_DEBUG_LOW,
--=20
2.53.0


--+yq+TVETvHELcyjw--

--AJsKHi8cto2USXrv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAmnuMmQACgkQHYKe/spW
KBLogAv+OLC6exJrijZNwXga09BUn/+hkDbj+gLr1ANTOxOCTWl/rDeU3mT86og+
NsoEp6CxpK9ovHfezr5HpiMhn9yNr4cTADDypDHYntb+BmVEQmH08ZsJIcDEosyI
BzScQZmAX0J+fbnj09/1llQrSRo5v+X5kynpTD7VSC1nyoHvUa4KOsfMreU+jcKI
FTGAi0H8i3eHCOpIzrSNqQYPNRBKlr1QshHhjI1TH0S0KnX8rWLP+u5gbzdTuzr/
qAfQlahEJHuUh3tgQXT3c6hqSTQKWbQdBdHC1rWmSsSspxVZQUCMzVGlxkF7+mon
pjEk2RmhQzOFU0ZmHblsXIQ2jjem1w1UNsygajPlPdvtAGWsdqu1nffbkmVmxh4A
fwHBZfFvJgTpU5JULigseznv1red0fIelFH/pqN/DQM6izxlWbGdKOKpeqnd20Ll
F3rebKTHj2RxgYdiO8+Q2asYVA0hphLLxgBpE+R1gBscMvVEa34IZY2KEO7RiMnf
imDRMo9t
=TMFW
-----END PGP SIGNATURE-----

--AJsKHi8cto2USXrv--

