From: Gert Doering <gert@...1296...>
Date: Tue, 18 Jun 2024 14:01:56 +0200
Message-ID: <20240618120156.4836-1-gert@...1296...>
In-Reply-To: <gerrit.1718369712000.I913bb70c5e527e78e7cdb43110e23a8944f35a22@...2715...>
References: <gerrit.1718369712000.I913bb70c5e527e78e7cdb43110e23a8944f35a22@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove "experimental" denotation for
 --fast-io
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

This option is very old (from SVN days) and has been
used by Access Server for many years. I don't think it
makes sense to claim that it is "experimental" at this
point.

Change-Id: I913bb70c5e527e78e7cdb43110e23a8944f35a22
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/664
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index f8a0f48..eb9cf28 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -215,7 +215,7 @@
   are supported by OpenSSL.
 
 --fast-io
-  (Experimental) Optimize TUN/TAP/UDP I/O writes by avoiding a call to
+  Optimize TUN/TAP/UDP I/O writes by avoiding a call to
   poll/epoll/select prior to the write operation. The purpose of such a
   call would normally be to block until the device or socket is ready to
   accept the write. Such blocking is unnecessary on some platforms which
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index abcde89..f2c7536 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -268,7 +268,7 @@
 #if ENABLE_IP_PKTINFO
     "--multihome     : Configure a multi-homed UDP server.\n"
 #endif
-    "--fast-io       : (experimental) Optimize TUN/TAP/UDP writes.\n"
+    "--fast-io       : Optimize TUN/TAP/UDP writes.\n"
     "--remap-usr1 s  : On SIGUSR1 signals, remap signal (s='SIGHUP' or 'SIGTERM').\n"
     "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-restart.\n"
     "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-restart.\n"

