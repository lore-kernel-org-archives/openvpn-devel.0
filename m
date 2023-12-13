From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 13 Dec 2023 11:53:08 +0100
Message-Id: <20231213105308.121460-1-frank@...2641...>
In-Reply-To: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
References: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Extend the error message when TLS 1.0
 PRF fails
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

This error will probably become more and more common in the future when
more and more systems will drop TLS 1.0 PRF support. We are already
seeing people stumbling upon this (see GitHub issue #460)

The current error messages

  TLS Error: PRF calcuation failed
  TLS Error: generate_key_expansion failed

are not very helpful for people that do not have deep understanding
of TLS or the OpenVPN protocol. Improve this message to give a normal
user a chance to understand that the peer needs to be OpenVPN 2.6.x or
newer.

Change-Id: Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/456
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 6eddb68..7597412 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1477,7 +1477,12 @@
     {
         if (!generate_key_expansion_openvpn_prf(session, &key2))
         {
-            msg(D_TLS_ERRORS, "TLS Error: PRF calcuation failed");
+            msg(D_TLS_ERRORS, "TLS Error: PRF calculation failed. Your system "
+                "might not support the old TLS 1.0 PRF calculation anymore or "
+                "the policy does not allow it (e.g. running in FIPS mode). "
+                "The peer did not announce support for the modern TLS Export "
+                "feature that replaces the TLS 1.0 PRF (requires OpenVPN "
+                "2.6.x or higher)");
             goto exit;
         }
     }

