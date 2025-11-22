From: Gert Doering <gert@...1296...>
Date: Sat, 22 Nov 2025 17:25:47 +0100
Message-ID: <20251122162553.12254-1-gert@...1296...>
In-Reply-To: <gerrit.1763650333000.Ie7308d549182a95b86cd113e4a8cc65ff45ba3d7@...2715...>
References: <gerrit.1763650333000.Ie7308d549182a95b86cd113e4a8cc65ff45ba3d7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tls_crypt: Fix Coverity complaint in
 tls_crypt_v2_check_client_key_age
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

From: Frank Lichtenheld <frank@...2641...>

Coverity complained about "overflow_before_widen" because
there is a theoretical overflow that can happen even though
the target value is wide enough. For useful values of max_days
this is irrelevant but Coverity is not wrong, so change the
code accordingly.

Change-Id: Ie7308d549182a95b86cd113e4a8cc65ff45ba3d7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1385
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1385
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 318c939..9026cff 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -539,7 +539,7 @@
     int64_t timestamp;
     memcpy(&timestamp, metadata + 1, sizeof(int64_t));
     timestamp = (int64_t)ntohll((uint64_t)timestamp);
-    int64_t max_age_in_seconds = max_days * 24 * 60 * 60;
+    int64_t max_age_in_seconds = (int64_t)max_days * 24 * 60 * 60;
     if (now - timestamp > max_age_in_seconds)
     {
         msg(M_WARN, "ERROR: Client key is too old.");

