From: Arne Schwabe <arne@...1227...>
Date: Mon, 11 Mar 2013 21:10:50 +0100
Message-Id: <1363032651-23934-3-git-send-email-arne@...1227...>
In-Reply-To: <1363032651-23934-1-git-send-email-arne@...1227...>
References: <1363032651-23934-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/4] Move static prototype definition from
	header into c file
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
 src/openvpn/tun.c |    2 ++
 src/openvpn/tun.h |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4b0365d..9912b07 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -73,6 +73,8 @@ static void solaris_error_close (struct tuntap *tt, const struct env_set *es, co
 #include <stropts.h>
 #endif
 
+static void clear_tuntap (struct tuntap *tuntap);
+
 bool
 is_dev_type (const char *dev, const char *dev_type, const char *match_type)
 {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 8622bf8..c3fc62e 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -203,8 +203,6 @@ tuntap_defined (const struct tuntap *tt)
  * Function prototypes
  */
 
-static void clear_tuntap (struct tuntap *tuntap);
-
 void open_tun (const char *dev, const char *dev_type, const char *dev_node,
 	       struct tuntap *tt);
 
-- 
1.7.9.5


