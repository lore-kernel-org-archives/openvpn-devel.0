Sender: Angel Abad <angelabad@...277...>
Date: Sun, 24 Jul 2022 19:46:30 +0200
From: Angel Abad <angel@...334...>
Message-ID: <Yt2Fdvaom94pVcOQ@...2684...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] PUSH_BUNDLE_SIZE is too short
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Description: PUSH_BUNDLE_SIZE is too short
Author: Angel Abad <angel@...334...>
---

Hello, we have problem with a large used openvpn server, our server push to clients
almos 150 routes, we havent problem with windows clients, but with linux clients push
options are cut, and the clients fail to configure beacouse the route commmands are cut.

We look code and verify that push bundle size is only 1024, so push options on linux are cut
on this size. We looked openvpn3 too, and there this limit is 2048

https://github.com/OpenVPN/openvpn3/blob/e1a35028a82acaf5ae6caeae321d83c36477d27c/openvpn/tun/linux/client/sitnl.hpp#L50

Could you please increase this limit on openvpn2 or provide a configuration option to
increase it?

Thanks in advance!

--- openvpn-2.6.0~git20220518+dco.orig/src/openvpn/common.h
+++ openvpn-2.6.0~git20220518+dco/src/openvpn/common.h
@@ -72,7 +72,7 @@ typedef unsigned long ptr_type;
  * This parameter controls the maximum size of a bundle
  * of pushed options.
  */
-#define PUSH_BUNDLE_SIZE 1024
+#define PUSH_BUNDLE_SIZE 2048
 
 /*
  * In how many seconds does client re-send PUSH_REQUEST if we haven't yet received a reply

