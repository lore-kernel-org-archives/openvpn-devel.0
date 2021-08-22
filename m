From: selva.nair@...277...
Date: Sun, 22 Aug 2021 11:28:20 -0400
Message-Id: <20210822152820.7072-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Minor doc correction: tls-crypt-v2 key
 generation
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/tls-crypt-v2.txt  | 4 ++--
 src/openvpn/options.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
index 3798791f..f6a6a139 100644
--- a/doc/tls-crypt-v2.txt
+++ b/doc/tls-crypt-v2.txt
@@ -58,7 +58,7 @@ Implementation
 When setting up a tls-crypt-v2 group (similar to generating a tls-crypt or
 tls-auth key previously):
 
-1. Generate a tls-crypt-v2 server key using OpenVPN's ``--tls-crypt-v2-genkey server``.
+1. Generate a tls-crypt-v2 server key using OpenVPN's ``--genkey tls-crypt-v2-server``.
    This key contains 2 512-bit keys, of which we use:
 
    * the first 256 bits of key 1 as AES-256-CTR encryption key ``Ke``
@@ -73,7 +73,7 @@ tls-auth key previously):
 
 When provisioning a client, create a client-specific tls-crypt key:
 
-1. Generate 2048 bits client-specific key ``Kc`` using OpenVPN's ``--tls-crypt-v2-genkey client``
+1. Generate 2048 bits client-specific key ``Kc`` using OpenVPN's ``--genkey tls-crypt-v2-client``
 
 2. Optionally generate metadata
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7e146db9..0e398c0f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -614,7 +614,7 @@ static const char usage_message[] =
     "                  see --secret option for more info.\n"
     "--tls-crypt-v2 key : For clients: use key as a client-specific tls-crypt key.\n"
     "                  For servers: use key to decrypt client-specific keys.  For\n"
-    "                  key generation (--tls-crypt-v2-genkey): use key to\n"
+    "                  key generation (--genkey tls-crypt-v2-client): use key to\n"
     "                  encrypt generated client-specific key.  (See --tls-crypt.)\n"
     "--genkey tls-crypt-v2-client [keyfile] [base64 metadata]: Generate a\n"
     "                  fresh tls-crypt-v2 client key, and store to\n"
-- 
2.20.1


