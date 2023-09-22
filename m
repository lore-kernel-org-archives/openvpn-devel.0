From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Sep 2023 12:50:55 +0200
Message-Id: <20230922105055.37969-1-frank@...2641...>
In-Reply-To: <gerrit.1694436141000.If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542@...2715...>
References: <gerrit.1694436141000.If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Warn user if INFO control command is too
 long
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

"INFO_PRE,..." command length is limited to 256 bytes. If the server
implementation pushes command which is too long, warn the user and
don't send the truncated command to a management client.

Change-Id: If3c27a2a2ba24f2af0e3e3c95eea57ed420b2542
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/329
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d468211..19849c5 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -244,8 +244,14 @@
          * for management greeting and we don't want to confuse the client
          */
         struct buffer out = alloc_buf_gc(256, &gc);
-        buf_printf(&out, ">%s:%s", "INFOMSG", m);
-        management_notify_generic(management, BSTR(&out));
+        if (buf_printf(&out, ">%s:%s", "INFOMSG", m))
+        {
+            management_notify_generic(management, BSTR(&out));
+        }
+        else
+        {
+            msg(D_PUSH_ERRORS, "WARNING: Received INFO command is too long, won't notify management client.");
+        }
 
         gc_free(&gc);
     }

