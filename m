From: Steffan Karger <steffan@...1856...>
Message-ID: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
Date: Tue, 21 Feb 2017 20:42:57 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E6C11312877AF6331E8044C0"
Subject: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib without
 AES-256-CTR or SHA256
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------E6C11312877AF6331E8044C0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

The attached patch from trac #825 fixes a silly bug in my --tls-crypt
code.  I already confirmed this in trac, but now also on the list:

ACK to the attached patch.

-Steffan

--------------E6C11312877AF6331E8044C0
Content-Type: text/x-patch;
	name="0001-Fix-segfault-when-using-crypto-library-without-AES-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fix-segfault-when-using-crypto-library-without-AES-2.pa";
	filename*1="tch"

From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00 2001
From: "Simon (simix)" <via-trac>
Date: Tue, 21 Feb 2017 20:34:15 +0100
Subject: [PATCH] Fix segfault when using crypto lib without AES-256-CTR or
 SHA256

Openvpn segfaults on RHEL5/CentOS5 when using --tls-crypt, because it
doesn't have AES-256-CTR support:

openvpn[15330]: OpenVPN 2.4.0 x86_64-redhat-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] built on Jan 17 2017
openvpn[15330]: library versions: OpenSSL 0.9.8e-fips-rhel5 01 Jul 2008, LZO 2.09, LZ4 1.7.5
openvpn[15331]: NOTE: the current --script-security setting may allow this configuration to call user-defined scripts
kernel: openvpn[15331]: segfault at 0000000000000008 rip 000000000040ebe0 rsp 00007fffdcfc5738 error 4

This patch fixes it so it shows:

openvpn[424]: ERROR: --tls-crypt requires AES-256-CTR support.
openvpn[424]: Exiting due to fatal error

Trac: #825
---
 src/openvpn/tls_crypt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index a227379..bda14fd 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -51,9 +51,7 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
 
     struct key_type kt;
     kt.cipher = cipher_kt_get("AES-256-CTR");
-    kt.cipher_length = cipher_kt_key_size(kt.cipher);
     kt.digest = md_kt_get("SHA256");
-    kt.hmac_length = md_kt_size(kt.digest);
 
     if (!kt.cipher)
     {
@@ -64,6 +62,9 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
         msg(M_FATAL, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
     }
 
+    kt.cipher_length = cipher_kt_key_size(kt.cipher);
+    kt.hmac_length = md_kt_size(kt.digest);
+
     crypto_read_openvpn_key(&kt, key, key_file, key_inline, key_direction,
                             "Control Channel Encryption", "tls-crypt");
 }
-- 
2.7.4


--------------E6C11312877AF6331E8044C0--

