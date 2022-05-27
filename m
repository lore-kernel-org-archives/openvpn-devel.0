From: Heiko Hund <heiko@...2662...>
Date: Fri, 27 May 2022 03:24:55 +0200
Message-Id: <20220527012457.1819262-3-heiko@...2662...>
In-Reply-To: <20220527012457.1819262-1-heiko@...2662...>
References: <20220527012457.1819262-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] remove dead foreign-option parsing code
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

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/options.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 65f4d889..bc3fd6a2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5531,13 +5531,6 @@ add_option(struct options *options,
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
-#endif
-#if 0
-    else if (streq(p[0], "foreign-option") && p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
-        foreign_option(options, p, 3, es);
-    }
 #endif
     else if (streq(p[0], "echo") || streq(p[0], "parameter"))
     {
-- 
2.32.0


