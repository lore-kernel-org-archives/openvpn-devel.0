From: Gert Doering <gert@...1296...>
Date: Wed, 12 Feb 2025 13:36:52 +0100
Message-ID: <20250212123652.18183-1-gert@...1296...>
In-Reply-To: <gerrit.1739361204000.I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce@...2715...>
References: <gerrit.1739361204000.I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix typo in positive_atoi
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

This is a code path that only affects Android

Change-Id: I3f05318fb6f8d9e32d07532a4f0c6ccf8fb757ce
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/889
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 218d8a6..3ae44db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8316,7 +8316,7 @@
 #if defined(TARGET_ANDROID)
         else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
         {
-            o->http_proxy_port = positiove_atoi(p[3], msglevel);
+            o->http_proxy_port = positive_atoi(p[3], msglevel);
             o->http_proxy = p[2];
         }
 #endif

