From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <16645.47913.650600.619643@...253...>
Subject: [Openvpn-devel] [PATCH - 2 of 4]  minimal change to PUSH_DEFINED
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Jul 26 19:18:00 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

This patch is of little import, but I thought I would submit it
anyway.

openvpn has a "PUSH_DEFINED" macro which is used to determine how the
configuration summary, which is exchanged for consistency checking, is
created.

PUSH_DEFINE should be equivalent to "something might get pushed".  It
is currently true iff push_list is non-NULL.  However there is another
case when things are pushed. i.e. if ifconfig_pool is defined.
So this patch corrects PUSH_DEFINED.

Thanks,
NeilBrown


### Diffstat output
 ./options.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./options.h~current~ ./options.h
--- ./options.h~current~	2004-07-27 11:44:12.000000000 +1000
+++ ./options.h	2004-07-27 11:44:12.000000000 +1000
@@ -340,7 +340,7 @@ struct options
 
 #if P2MP
 #define PULL_DEFINED(opt) ((opt)->pull)
-#define PUSH_DEFINED(opt) ((opt)->push_list)
+#define PUSH_DEFINED(opt) ((opt)->push_list || (opt)->ifconfig_pool_defined)
 #else
 #define PULL_DEFINED(opt) (false)
 #define PUSH_DEFINED(opt) (false)

