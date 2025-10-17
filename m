From: Gert Doering <gert@...1296...>
Date: Fri, 17 Oct 2025 22:57:24 +0200
Message-ID: <20251017205730.8450-1-gert@...1296...>
In-Reply-To: <gerrit.1760700482000.I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4@...2715...>
References: <gerrit.1760700482000.I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] route: Add #endif comment for uncrustify
 compliance
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

Cherry-pick dca6b03098ab0f3ef808c891673305651dc6704a
broke uncrustify compliance. Apparently this one added
line pushed it over the limit to require the #endif
comment.

Change-Id: I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1284
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1284
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3ff9717..75e94c2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2368,7 +2368,7 @@
     {
         gateway_needed = true;
     }
-#endif
+#endif /* ifndef _WIN32 */
 
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();

