From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jan 2016 11:22:19 +0100
Message-Id: <1451730139-25563-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Complete push-peer-info documentation and
	allow IV_PLAT_VER for other platforms than Windows if the
	client UI supplies it.
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
 doc/openvpn.8     | 6 ++++++
 src/openvpn/ssl.c | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 6d5807f..52ebe59 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2962,6 +2962,12 @@ IV_HWADDR=<mac address> -- the MAC address of clients default gateway
 
 IV_LZO_STUB=1 -- if client was built with LZO stub capability
 
+IV_UI_VER=<gui_id> <version> -- the UI version of a UI if one is
+running, for example "de.blinkt.openvpn 0.5.47" for the
+Android app.
+
+IV_PLAT_VER=x.y - the version of the operating system, e.g. 6.1 for Windows 7.
+
 UV_<name>=<value> -- client environment variables whose names start with "UV_"
 .\"*********************************************************
 .TP
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9465846..39da06f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1879,8 +1879,10 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 	{
 	  if (e->string)
 	    {
-	      if (((strncmp(e->string, "UV_", 3)==0 && session->opt->push_peer_info_detail >= 2)
-		   || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0))
+	      if ((((strncmp(e->string, "UV_", 3)==0 ||
+		     strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER"))==0)&&
+		    session->opt->push_peer_info_detail >= 2)
+		   || (strncmp(e->string,"IV_PLAT_VER=",sizeof("IV_PLAT_VER=")-1)==0))
 		  && buf_safe(&out, strlen(e->string)+1))
 		buf_printf (&out, "%s\n", e->string);
 	    }
-- 
2.5.4 (Apple Git-61)


