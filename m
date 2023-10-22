From: Gert Doering <gert@...1296...>
Date: Sun, 22 Oct 2023 10:27:40 +0200
Message-ID: <20231022082751.8868-1-gert@...1296...>
In-Reply-To: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
References: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: warn if DATA_V1 packets are sent to
 userspace
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

From: Lev Stipakov <lev@...515...>

Servers 2.4.0 - 2.4.4 support peer-id and AEAD ciphers,
but only send DATA_V1 packets. With DCO enabled on the
client, connection is established but not working.

This is because DCO driver(s) are unable to handle
DATA_V1 packets and forwards them to userspace, where
they silently disappear since crypto context is in
DCO and not in userspace.

Starting from 2.4.5 server sends DATA_V2 so problem
doesn't happen.

We cannot switch to non-DCO on the fly, so we log this
and advice user to upgrade the server to 2.4.5 or newer.

Github: fixes OpenVPN/openvpn#422

Change-Id: I8cb2cb083e3cdadf187b7874979d79af3974e759
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/368
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d8ad0d1..40f21bc 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1047,6 +1047,24 @@
 
         if (c->c2.tls_multi)
         {
+            uint8_t opcode = *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
+
+            /*
+             * If DCO is enabled, the kernel drivers require that the
+             * other end only sends P_DATA_V2 packets. V1 are unknown
+             * to kernel and passed to userland, but we cannot handle them
+             * either because crypto context is missing - so drop the packet.
+             *
+             * This can only happen with particular old (2.4.0-2.4.4) servers.
+             */
+            if ((opcode == P_DATA_V1) && dco_enabled(&c->options))
+            {
+                msg(D_LINK_ERRORS,
+                    "Data Channel Offload doesn't support DATA_V1 packets. "
+                    "Upgrade your server to 2.4.5 or newer.");
+                c->c2.buf.len = 0;
+            }
+
             /*
              * If tls_pre_decrypt returns true, it means the incoming
              * packet was a good TLS control channel packet.  If so, TLS code
@@ -1057,9 +1075,8 @@
              * will load crypto_options with the correct encryption key
              * and return false.
              */
-            uint8_t opcode = *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
-            if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf, &co,
-                                floated, &ad_start))
+            if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf,
+                                &co, floated, &ad_start))
             {
                 /* Restore pre-NCP frame parameters */
                 if (is_hard_reset_method2(opcode))

