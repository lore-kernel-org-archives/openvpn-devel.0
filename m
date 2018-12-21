MIME-Version: 1.0
Date: Fri, 21 Dec 2018 07:43:28 +0100
From: Richard van den Berg <richard@...2482...>
Message-ID: <c042fd01f62d707477c37e0298e303f1@...2482...>
Subject: [Openvpn-devel] [PATCH] Fix error message when using RHEL init
 script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

In RHEL 7 /etc/sysconfig/network is no longer used (still there but 
empty). This results in the following error when openvpn starts:

Dec 20 09:01:25 localhost openvpn: /etc/rc.d/init.d/openvpn: line 94: [: 
=: unary operator expected

---
  distro/rpm/openvpn.init.d.rhel | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/distro/rpm/openvpn.init.d.rhel 
b/distro/rpm/openvpn.init.d.rhel
index cdf3e9de..bfde2216 100755
--- a/distro/rpm/openvpn.init.d.rhel
+++ b/distro/rpm/openvpn.init.d.rhel
@@ -91,7 +91,7 @@ work=/etc/openvpn
  . /etc/sysconfig/network

  # Check that networking is up.
-if [ ${NETWORKING} = "no" ]
+if [ "${NETWORKING}" = "no" ]
  then
    echo "Networking is down"
    exit 0
-- 
2.11.0



