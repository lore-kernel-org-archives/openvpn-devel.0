From: Gert Doering <gert@...1296...>
Date: Mon, 28 Nov 2022 12:16:42 +0100
Message-Id: <20221128111642.3483-1-gert@...1296...>
In-Reply-To: <20221126141041.5098-1-gert@...1296...>
References: <20221126141041.5098-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Update PORTS
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

Instead of fully removing PORTS, keep "this is what you want to do for
porting OpenVPN to a new platform" section, and update the PLATFORMS
part to better reflect current status.

v2:
  drop "2.2+" from Linux, and name the fruitish thing "macOS"

Signed-off-by: Gert Doering <gert@...1296...>
---
 PORTS | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/PORTS b/PORTS
index ff76850d..2e5133b0 100644
--- a/PORTS
+++ b/PORTS
@@ -11,20 +11,31 @@ Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 
 PLATFORM STATUS:
 
-  * Linux 2.2+ (supported)
-  * Solaris (supported)
-  * OpenBSD 3.0 (supported but pthreads are broken)
-  * Max OS X Darwin
+Tier 1 platforms - actively tested for every source commit, across
+multiple operating system versions
+
+  * Windows 7 and newer
+  * Windows Server 2012 and newer
+  * Linux
   * FreeBSD
+  * macOS
+
+Tier 2 platforms - it worked at some point, but is not actively tested
+on "latest OS, latest OS libraries" so might break if larger changes
+are done on the platform side
+
+  * OpenBSD
   * NetBSD
-  * Windows
-  * 64 bit platforms -- I have heard reports that
-    OpenVPN runs on Alpha Linux and FreeBSD.
-  * ARM -- I have heard of at least one case
-    where OpenVPN was successfully built and
-    run on the ARM architecture.
+  * DragonFly BSD
+  * Solaris
+  * AIX
+
+For underlying CPU architecture, everything 32 bit or 64 bit (Intel, AMD,
+ARM, PowerPC, SPARC*) should work fine.  16 bit Architectures are unlikely
+to work.
+
 
-PORTING NOTES:
+PORTING GUIDELINE TO A NEW PLATFORM:
 
   * Make sure that OpenSSL will build on your
     platform.
@@ -42,7 +53,7 @@ PORTING NOTES:
     function in tun.c to generate a correct "ifconfig"
     command for your platform.  Note that OpenVPN
     determines the ifconfig path at ./configure time.
-  * Add an ifconfig_order() variant for your OS so
+  * Possibly add an ifconfig_order() variant for your OS so
     openvpn knows whether to call ifconfig before
     or after tun/tap dev open.
   * Add an #ifdef TARGET_YOUROS block in tun.c and define
@@ -77,12 +88,8 @@ PORTING NOTES:
     disabled with an explicit ioctl call if cross-platform
     compatibility is to be preserved.  You can see some
     examples of this in tun.c.
-  * If your system supports pthreads, try building
-    with ./configure --enable-pthread and do a stress
-    test in TLS mode.
-  * Try the ultimate stress test which is --gremlin
-    --reneg-sec 10 in TLS mode (preferably with pthreads
-    enabled), then do a flood ping across the tunnel
+  * Try the ultimate stress test which is --gremlin --reneg-sec 10
+    in TLS mode then do a flood ping across the tunnel
     (ping -f remote-endpoint) in both directions and let
     it run overnight.  --gremlin will induce massive
     corruption and packet loss, but you win if you
-- 
2.35.1


