From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Jan 2025 17:10:25 +0100
Message-Id: <20250121161025.37545-1-frank@...2641...>
In-Reply-To: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
References: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] mudp.c: keep offset value when
 resetting buffer
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

dco-win requires control packets to be prepended
with sockaddr. For that, an offset value in buffer
must be kept. Doing it always doesn't harm and makes
code cleaner compared to adding "if (dco_win_server)"
condition.

Change-Id: I145573555aaace5e94774b5f977d032d3747ed72
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/814
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6137578..1a3a4c7 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -54,7 +54,9 @@
 
     struct context *c = &m->top;
 
-    buf_reset_len(&c->c2.buffers->aux_buf);
+    /* dco-win server requires prepend with sockaddr, so preserve offset */
+    ASSERT(buf_init(&c->c2.buffers->aux_buf, buf.offset));
+
     buf_copy(&c->c2.buffers->aux_buf, &buf);
     m->hmac_reply = c->c2.buffers->aux_buf;
     m->hmac_reply_dest = &m->top.c2.from;

