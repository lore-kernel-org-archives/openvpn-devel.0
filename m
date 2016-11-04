From: Gert Doering <gert@...1296...>
Date: Fri,  4 Nov 2016 11:30:41 +0100
Message-Id: <1478255441-21670-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Poor man's NCP for 2.3 clients.
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

Proper cipher negotiation needs clients that announce IV_NCP=1 and
can handle pushing of ciphers.

2.3 clients can not do that.  To work around that, here's a hacky
patch to make it work.

On the client side, set

  cipher AES-128-CBC
  push-peer-info
  setenv UV_CIPHER AES-128-CBC

(same cipher!).  On the server side, run a client-connect script that
will create a per-instance "cipher $UV_CIPHER" config line if UV_CIPHER
is set.

To make this work, make "cipher" settable per-instance (which it effectively
already is, options.c just did not learn about it) AND delay cipher
initialization even if IV_NCP is not set if the clients sends UV_CIPHER.

Use with care, without the proper server-side script (or plugin), it will
just cause non-working setups.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 2 +-
 src/openvpn/ssl.c     | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 552bf5a..5b943c5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6677,7 +6677,7 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "cipher") && p[1] && !p[2])
     {
-      VERIFY_PERMISSION (OPT_P_NCP);
+      VERIFY_PERMISSION (OPT_P_NCP|OPT_P_INSTANCE);
       options->ciphername = p[1];
     }
   else if (streq (p[0], "ncp-ciphers") && p[1] && !p[2])
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4a0cd6f..5ee1882 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2258,7 +2258,14 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
   if (tls_peer_info_ncp_ver (multi->peer_info) < 2)
     {
       /* Peer does not support NCP */
-      session->opt->ncp_enabled = false;
+      if ( strstr (multi->peer_info, "UV_CIPHER=") != NULL )
+	{
+	  msg( M_INFO, "peer doesn't do NCP, but sends UV_CIPHER, leaving NCP enabled" );
+	}
+      else
+	{
+	  session->opt->ncp_enabled = false;
+	}
     }
 #endif
 
-- 
2.7.3


