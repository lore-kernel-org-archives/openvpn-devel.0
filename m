From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:19 -0500
Message-Id: <20211214165928.30676-10-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 09/18] Allow management client to
 announce pss padding support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

The --management-external-key option can currently indicate support
for 'nopadding' or 'pkcs1' signatures in the client. Add 'pss' as an
option to announce that PSS signing requests are accepted.

To match, extend the algorithm string in PK_SIGN request to
include the following format:

- RSA_PKCS1_PSS_PADDING,hashlag=name,saltlen=[max|digest]

Here 'name' is the short common name of the hash algorithm.
E.g., SHA1, SHA256 etc.

Existing formats 'ECDSA' and 'RSA_PKCS1_PADDING' are unchanged.

v2 changes: Fix typos and other sloppiness in documentation and
commit message.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/man-sections/management-options.rst |  8 +++++++-
 doc/management-notes.txt                | 22 ++++++++++++++++++----
 src/openvpn/manage.h                    |  1 +
 src/openvpn/options.c                   | 11 ++++++++---
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/doc/man-sections/management-options.rst b/doc/man-sections/management-options.rst
index de0d47e7..b173a1ea 100644
--- a/doc/man-sections/management-options.rst
+++ b/doc/man-sections/management-options.rst
@@ -90,9 +90,15 @@ server and client mode operations.
      management-external-key
      management-external-key nopadding
      management-external-key pkcs1
+     management-external-key pss
+
+  or any combination like:
+  ::
+
      management-external-key nopadding pkcs1
+     management-external-key pkcs1 pss
 
-  The optional parameters :code:`nopadding` and :code:`pkcs1` signal
+  The optional parameters :code:`nopadding` :code:`pkcs1` and :code:`pss` signal
   support for different padding algorithms. See
   :code:`doc/mangement-notes.txt` for a complete description of this
   feature.
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 84e3d04b..169a5efe 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -1019,10 +1019,24 @@ can be indicated in the signing request only if the client version is > 2"
 
 The currently defined padding algorithms are:
 
- - RSA_PKCS1_PADDING  -  PKCS1 padding and RSA signature
- - RSA_NO_PADDING     -  No padding may be added for the signature
- - ECDSA              -  EC signature.
-
+ - RSA_PKCS1_PADDING            -  PKCS1 padding and RSA signature
+ - RSA_NO_PADDING               -  No padding may be added for the signature
+ - ECDSA                        -  EC signature.
+ - RSA_PKCS1_PSS_PADDING,params -  RSA signature with PSS padding
+
+   The params for PSS are specified as 'hashalg=name,saltlen=[max|digest]'.
+
+   The hashalg names are short common names such as SHA256, SHA224, etc.
+   PSS saltlen="digest" means use the same size as the hash to sign, while
+   "max" indicates maximum possible saltlen which is
+   '(nbits-1)/8 - hlen - 2'. Here 'nbits' is the number of bits in the
+   key modulus and 'hlen' the size in octets of the hash.
+   (See: RFC 8017 sec 8.1.1 and 9.1.1)
+
+   In the case of PKCS1_PADDING, when the hash algorithm is not legacy
+   MD5-SHA1, the hash is encoded with DigestInfo header before presenting
+   to the management interface. This is identical to CKM_RSA_PKCS in Cryptoki
+   as well as what RSA_private_encrypt() in OpenSSL expects.
 
 COMMAND -- certificate (OpenVPN 2.4 or higher)
 ----------------------------------------------
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 04dc98d1..5ed27c0c 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -339,6 +339,7 @@ struct management *management_init(void);
 #define MF_QUERY_REMOTE             (1<<13)
 #define MF_QUERY_PROXY              (1<<14)
 #define MF_EXTERNAL_CERT            (1<<15)
+#define MF_EXTERNAL_KEY_PSSPAD      (1<<16)
 
 bool management_open(struct management *man,
                      const char *addr,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fb427410..3ec9025b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -60,6 +60,7 @@
 #include "forward.h"
 #include "ssl_verify.h"
 #include "platform.h"
+#include "xkey_common.h"
 #include <ctype.h>
 
 #include "memdbg.h"
@@ -2207,14 +2208,14 @@ options_postprocess_verify_ce(const struct options *options,
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-#if  defined(ENABLE_MANAGEMENT)
+#if defined(ENABLE_MANAGEMENT) && !defined(HAVE_XKEY_PROVIDER)
     if ((tls_version_max() >= TLS_VER_1_3)
         && (options->management_flags & MF_EXTERNAL_KEY)
         && !(options->management_flags & (MF_EXTERNAL_KEY_NOPADDING))
         )
     {
-        msg(M_ERR, "management-external-key with OpenSSL 1.1.1 requires "
-            "the nopadding argument/support");
+        msg(M_FATAL, "management-external-key with TLS 1.3 or later requires "
+            "nopadding argument/support");
     }
 #endif
     /*
@@ -5571,6 +5572,10 @@ add_option(struct options *options,
             {
                 options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
             }
+            else if (streq(p[j], "pss"))
+            {
+                options->management_flags |= MF_EXTERNAL_KEY_PSSPAD;
+            }
             else
             {
                 msg(msglevel, "Unknown management-external-key flag: %s", p[j]);
-- 
2.30.2


