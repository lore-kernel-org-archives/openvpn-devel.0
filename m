Date: Wed, 22 Feb 2012 20:03:01 +0100
From: Michael Kress <m-kress@...1660...>
Message-ID: <20120222200301.586867ce@...1661...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/wX+I=Br/FKjgg.H_t+sAWRa"
Subject: [Openvpn-devel] Log level of management interface: patch from 2009
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--MP_/wX+I=Br/FKjgg.H_t+sAWRa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

in May 2009 James committed in
423037e9fbdff7209ca6f305b812a9908a0f4d13 

  "Reduce the debug level (--verb) at which received management
  interface commands are echoed from 7 to 3."

A search for comments or a reason did not reveal more informarion. I use
the management extensively and these regular management commands bloat
the log at the default --verb 3 with at least 3 lines (enter/command/exit). 

I do not wish to start a debate if this is reasonable or not. The fact,
that this #define is still amongst verb 7 defines in the code raises
the feeling, that this has simply been forgotten.

If this is true, you can use the attached patch, that tosses this
single (!) bit. :-) 

-- 
Servus
  Michael

--MP_/wX+I=Br/FKjgg.H_t+sAWRa
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-increase-log-level-for-management-interface.patch

From 78e3853622fe41f4aa638e887f5fd4f064be6c07 Mon Sep 17 00:00:00 2001
From: Michael Kress <m-kress@...1660...>
Date: Wed, 22 Feb 2012 19:50:45 +0100
Subject: [PATCH] Increase the debug level (--verb) at which received management
 interface commands are echoed from 3 to 7.

Signed-off-by: Michael Kress <m-kress@...1660...>
---
 errlevel.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/errlevel.h b/errlevel.h
index 74729c9..726f0b3 100644
--- a/errlevel.h
+++ b/errlevel.h
@@ -133,7 +133,7 @@
 #define D_SEMAPHORE_LOW      LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits (low freq) */
 #define D_SEMAPHORE          LOGLEV(7, 70, M_DEBUG)  /* show Win32 semaphore waits */
 #define D_TEST_FILE          LOGLEV(7, 70, M_DEBUG)  /* show test_file() calls */
-#define D_MANAGEMENT_DEBUG   LOGLEV(3, 70, M_DEBUG)  /* show --management debug info */
+#define D_MANAGEMENT_DEBUG   LOGLEV(7, 70, M_DEBUG)  /* show --management debug info */
 #define D_PLUGIN_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show verbose plugin calls */
 #define D_SOCKET_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show socket.[ch] debugging info */
 #define D_SHOW_PKCS11        LOGLEV(7, 70, M_DEBUG)  /* show PKCS#11 actions */
-- 
1.7.3.4


--MP_/wX+I=Br/FKjgg.H_t+sAWRa--

