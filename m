From: chantra <chantra@...1258...>
Date: Fri, 25 Mar 2011 10:24:30 +0100
Message-Id: <1301045070-26677-1-git-send-email-chantra@...1258...>
Subject: [Openvpn-devel] [PATCH] Clarify --tmp-dir option
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


Signed-off-by: chantra <chantra@...1258...>
---
 openvpn.8 |   17 +++++++++++++++++
 options.c |    2 +-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 4eaf0db..0340ee3 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -2926,9 +2926,26 @@ file.
 Specify a directory
 .B dir
 for temporary files.  This directory will be used by
+openvpn processes and script to communicate temporary
+data with openvpn main process. Note that
+the directory must be writable by the OpenVPN process
+after it has dropped it's root privileges.
+
+This directory will be used by in the following cases:
+
+*
 .B \-\-client-connect
 scripts to dynamically generate client-specific
 configuration files.
+
+*
+.B OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
+plugin hook to return success/failure via auth_control_file
+when using deferred auth method
+
+*
+.B OPENVPN_PLUGIN_ENABLE_PF
+plugin hook to pass filtering rules via pf_file
 .\"*********************************************************
 .TP
 .B \-\-hash-size r v
diff --git a/options.c b/options.c
index a991e05..f3ec9a3 100644
--- a/options.c
+++ b/options.c
@@ -411,7 +411,7 @@ static const char usage_message[] =
   "--client-disconnect cmd : Run script cmd on client disconnection.\n"
   "--client-config-dir dir : Directory for custom client config files.\n"
   "--ccd-exclusive : Refuse connection unless custom client config is found.\n"
-  "--tmp-dir dir   : Temporary directory, used for --client-connect return file.\n"
+  "--tmp-dir dir   : Temporary directory, used for --client-connect return file and plugin communication.\n"
   "--hash-size r v : Set the size of the real address hash table to r and the\n"
   "                  virtual address table to v.\n"
   "--bcast-buffers n : Allocate n broadcast buffers.\n"
-- 
1.7.1


