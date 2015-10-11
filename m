From: Arne Schwabe <arne@...1227...>
Date: Sun, 11 Oct 2015 15:47:46 +0200
Message-Id: <1444571266-6598-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Do not set the buffer size by default but
	rely on the operation system default.
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
 ChangeLog             | 3 +++
 doc/openvpn.8         | 4 ++--
 src/openvpn/options.c | 4 ----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 7b945c8..9642adf 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,9 @@
 OpenVPN Change Log
 Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
 
+2015.xx.xx -- Version 2.4.0
+	- sndbuf and recvbuf default now to OS default instead of 65k
+
 2012.09.12 -- Version 2.3_beta1
 Arne Schwabe (7):
       Fixes error: --key fails with EXTERNAL_PRIVATE_KEY: No such file or directory if --management-external-key is used
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3a86409..b6d5aed 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1433,12 +1433,12 @@ connection problems) with the following options:
 .TP
 .B \-\-sndbuf size
 Set the TCP/UDP socket send buffer size.
-Currently defaults to 65536 bytes.
+Defaults to operation system default.
 .\"*********************************************************
 .TP
 .B \-\-rcvbuf size
 Set the TCP/UDP socket receive buffer size.
-Currently defaults to 65536 bytes.
+Defaults to operation system default.
 .\"*********************************************************
 .TP
 .B \-\-mark value
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6823167..2b0af34 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -785,10 +785,6 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_FEATURE_TUN_PERSIST
   o->persist_mode = 1;
 #endif
-#ifndef WIN32
-  o->rcvbuf = 65536;
-  o->sndbuf = 65536;
-#endif
 #ifdef TARGET_LINUX
   o->tuntap_options.txqueuelen = 100;
 #endif
-- 
1.9.5 (Apple Git-50.3)


