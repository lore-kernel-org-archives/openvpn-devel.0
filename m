From: David Sommerseth <dazo@...384...>
Date: Tue, 14 Aug 2012 11:57:29 +0200
Message-Id: <1344938249-5885-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] [RFC] Add a warning if --client-config-dir
	related config file cannot be opened
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

From: David Sommerseth <davids@...1347...>

This will cause a warning in the log file if --client-config-dir
is configured but OpenVPN could not find or open the config file
for the connecting client.

OpenVPN will also look for a file named 'DEFAULT' if a file named
as the client's TLS Common Name cannot be found.  To hide this
warning above, create an empty 'DEFAULT' file inside the
 --client-config-dir.

Signed-off-by: David Sommerseth <davids@...1347...>
Cc: jeff@...1394...
---

This patch is a result after some discssion on the #openvpn-devel IRC
channel, where it seems many users do not realise the config files inside
the --client-config-dir is not processed, due to wrong path, filename or
lacking file access.

Currently it is not easy to provide a better warning message which gives
a more fine grained reason why it fails.  But I consider this still a
better approach than the current one, which just silently fails.

 src/openvpn/multi.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9876b80..e1048f51 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1659,6 +1659,11 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 					 &option_types_found,
 					 mi->context.c2.es);
 		}
+              else
+                {
+                  msg (M_WARN, "[CCD] Failed to import client config for '%s'",
+                       tls_common_name (mi->context.c2.tls_multi, false));
+                }
 	    }
 	}
 
-- 
1.7.10.2


