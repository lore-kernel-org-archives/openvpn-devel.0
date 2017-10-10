From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:20 +0200
Message-Id: <20171010231130.6832-3-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 03/13] RtlIpv6AddressToStringW() and
 RtlIpv4AddressToStringW() require mstcpip.h
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

From: Simon Rozman <simon@...2293...>

---
 src/openvpnserv/interactive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 4b08086..2019d38 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,6 +33,7 @@
 #include <stdio.h>
 #include <sddl.h>
 #include <shellapi.h>
+#include <mstcpip.h>
 
 #ifdef HAVE_VERSIONHELPERS_H
 #include <versionhelpers.h>
-- 
2.9.0.windows.1


