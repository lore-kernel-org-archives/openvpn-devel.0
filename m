From: Gert Doering <gert@...1296...>
Date: Fri, 26 Sep 2025 16:24:36 +0200
Message-ID: <20250926142442.20796-1-gert@...1296...>
In-Reply-To: <gerrit.1758817708000.I473d345d10fc406f76fbdb131c28cc4fc54822fd@...2715...>
References: <gerrit.1758817708000.I473d345d10fc406f76fbdb131c28cc4fc54822fd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco_linux: Fix -Wconversion warnings
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

Combination of using the correct types and some
unavoidable safe size_t->int casts.

Change-Id: I473d345d10fc406f76fbdb131c28cc4fc54822fd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1220
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1220
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 395a38f..d46fa46 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -62,11 +62,6 @@
 
 typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * @brief resolves the netlink ID for ovpn-dco
  *
@@ -110,7 +105,7 @@
 }
 
 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, int cmd)
+ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_msg = nlmsg_alloc();
     if (!nl_msg)
@@ -346,7 +341,7 @@
 
     if (!(nlh->nlmsg_flags & NLM_F_CAPPED))
     {
-        ack_len += err->msg.nlmsg_len - sizeof(*nlh);
+        ack_len += err->msg.nlmsg_len - (int)sizeof(*nlh);
     }
 
     if (len <= ack_len)
@@ -360,8 +355,8 @@
     nla_parse(tb_msg, OVPN_NLMSGERR_ATTR_MAX, attrs, len, NULL);
     if (tb_msg[NLMSGERR_ATTR_MSG])
     {
-        len = strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
-                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
+        len = (int)strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
+                           nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
         msg(M_WARN, "kernel error: %*s", len, (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
     }
 
@@ -606,7 +601,7 @@
     msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, slot, keyid, peerid,
         ciphername);
 
-    const size_t key_len = cipher_kt_key_size(ciphername);
+    const int key_len = cipher_kt_key_size(ciphername);
     const int nonce_tail_len = 8;
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_NEW);
@@ -1303,8 +1298,4 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */

