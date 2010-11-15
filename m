From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 09:05:45 +0100
Message-Id: <1289808348-17463-5-git-send-email-dazo@...384...>
In-Reply-To: <1289808348-17463-1-git-send-email-dazo@...384...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 3/6] Fixed potential misinterpretation of
	boolean logic
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
Cc: David Sommerseth <dazo@...384...>

The GNU C compiler warned about a potential issue with an if()
expression missing an extra set of parentheses.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 ssl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ssl.c b/ssl.c
index c05d34f..8644ae4 100644
--- a/ssl.c
+++ b/ssl.c
@@ -940,7 +940,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
       if (opt->verify_export_cert)
         {
           gc = gc_new();
-          if (tmp_file=get_peer_cert(ctx, opt->verify_export_cert,&gc))
+          if ((tmp_file=get_peer_cert(ctx, opt->verify_export_cert,&gc)))
            {
              setenv_str(opt->es, "peer_cert", tmp_file);
            }
-- 
1.7.2.3


