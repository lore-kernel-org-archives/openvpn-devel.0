From: Gert Doering <gert@...1296...>
Date: Thu,  4 Dec 2025 13:42:16 +0100
Message-ID: <20251204124221.15206-1-gert@...1296...>
In-Reply-To: <gerrit.1764851842000.I4f9a6baf2bdb45e5b79bf13c9f6fce3b7a2e982c@...2715...>
References: <gerrit.1764851842000.I4f9a6baf2bdb45e5b79bf13c9f6fce3b7a2e982c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Add a section about wolfSSL GPLv3 and
 point out missing TLS PRF support
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

From: Arne Schwabe <arne@...1227...>

Change-Id: I4f9a6baf2bdb45e5b79bf13c9f6fce3b7a2e982c
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1416
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1416
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/README.wolfssl b/README.wolfssl
index 3918d0f..3e531ae 100644
--- a/README.wolfssl
+++ b/README.wolfssl
@@ -28,7 +28,17 @@
  * blowfish support (BF-CBC), you must use something like
    cipher AES-128-CBC to avoid trying to use BF-CBC
  * Windows CryptoAPI support
+ * No TLS1.0 PRF support (No compaitbility with OpenVPN 2.5 or older or
+   other build that do not support TLS EKM)
 
+
+*************************************************************************
+Newer wolfSSL versions (5.8.2 and newer) are GPLv3 licensed and this license is not
+compatible with OpenVPN's GPLv2 license.
+
+However wolfSSL Inc has granted an exception to combine the wolfSSL library
+with OpenVPN and OpenVPN-NL (https://github.com/wolfSSL/wolfssl/blob/master/LICENSING)
+with version 5.8.4 and later.
 *************************************************************************
 To build WolfSSL with post-quantum KEMs built in, the following command is used:
 

