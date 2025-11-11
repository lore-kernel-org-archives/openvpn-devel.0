From: Gert Doering <gert@...1296...>
Date: Tue, 11 Nov 2025 16:52:31 +0100
Message-ID: <20251111155239.31747-1-gert@...1296...>
In-Reply-To: <gerrit.1762517501000.Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af@...2715...>
References: <gerrit.1762517501000.Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl: Change tls_send_payload size
 argument to size_t
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

There is only one caller of this function and it
wants it to be size_t. So move the size_t to int
conversion one step down in the call chain. Do not
switch key_state_write_plaintext_const, yet, since
that is a backend function and so needs way more
work.

Change-Id: Ic90c5a0e48bda4a02d5e11c4c161f388cc8805af
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1355
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1355
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5bbac13..cffb310 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -365,11 +365,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 send_control_channel_string_dowork(struct tls_session *session, const char *str,
                                    msglvl_t msglevel)
@@ -827,6 +822,11 @@
 #endif /* ENABLE_MANAGEMENT */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 check_coarse_timers(struct context *c)
 {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 908854a..398c9ae 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4032,7 +4032,7 @@
  */
 
 bool
-tls_send_payload(struct key_state *ks, const uint8_t *data, int size)
+tls_send_payload(struct key_state *ks, const uint8_t *data, size_t size)
 {
     bool ret = false;
 
@@ -4042,7 +4042,8 @@
 
     if (ks->state >= S_ACTIVE)
     {
-        if (key_state_write_plaintext_const(&ks->ks_ssl, data, size) == 1)
+        ASSERT(size <= INT_MAX);
+        if (key_state_write_plaintext_const(&ks->ks_ssl, data, (int)size) == 1)
         {
             ret = true;
         }
@@ -4053,7 +4054,7 @@
         {
             ks->paybuf = buffer_list_new();
         }
-        buffer_list_push_data(ks->paybuf, data, (size_t)size);
+        buffer_list_push_data(ks->paybuf, data, size);
         ret = true;
     }
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index ffcc7c4..db8a798 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -426,7 +426,7 @@
 /*
  * Send a payload over the TLS control channel
  */
-bool tls_send_payload(struct key_state *ks, const uint8_t *data, int size);
+bool tls_send_payload(struct key_state *ks, const uint8_t *data, size_t size);
 
 /*
  * Receive a payload through the TLS control channel

