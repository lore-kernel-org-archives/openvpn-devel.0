From: Arne Schwabe <arne@...1227...>
Date: Thu, 30 May 2013 23:34:40 +0200
Message-Id: <1369949680-9499-1-git-send-email-arne@...1227...>
In-Reply-To: <1369949255-7302-1-git-send-email-arne@...1227...>
References: <1369949255-7302-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v2] Fix #ifdefs for P2MP_SERVER
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 src/openvpn/ssl.c        |    2 +-
 src/openvpn/ssl_common.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 12da365..088eea8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2043,7 +2043,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
   username_status = read_string (buf, up->username, USER_PASS_LEN);
   password_status = read_string (buf, up->password, USER_PASS_LEN);
 
-#ifdef P2MP_SERVER
+#if P2MP_SERVER
   /* get peer info from control channel */
   free (multi->peer_info);
   multi->peer_info = read_string_alloc (buf);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 06ce0dd..7e52f9a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -485,7 +485,7 @@ struct tls_multi
   time_t tas_last;
 #endif
 
-#ifdef P2MP_SERVER
+#if P2MP_SERVER
   /*
    * A multi-line string of general-purpose info received from peer
    * over control channel.
-- 
1.7.9.5


