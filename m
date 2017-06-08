MIME-Version: 1.0
From: Guido Vranken <guidovranken@...277...>
Date: Fri, 9 Jun 2017 00:04:36 +0200
Message-ID: <CAO5O-E+HdfHNAK=--55054AB374U-Ky4q_-3M114makfPdSnBw@...278...>
Subject: [Openvpn-devel] [PATCH] Fix memory leak in add_option() for option
 'connection'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch ensures that if an error occurs while processing
the 'connection' directive of an options specification,
the variable 'struct options sub', which is initialized
with init_options(), is properly freed with uninit_options().

Signed-off-by: Guido Vranken <guidovranken@...277...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 91d8280..b4ecff0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5302,12 +5302,14 @@ add_option(struct options *options,
             if (!sub.ce.remote)
             {
                 msg(msglevel, "Each 'connection' block must contain
exactly one 'remote' directive");
+                uninit_options(&sub);
                 goto err;
             }

             e = alloc_connection_entry(options, msglevel);
             if (!e)
             {
+                uninit_options(&sub);
                 goto err;
             }
             *e = sub.ce;
-- 
2.1.4

