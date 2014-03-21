From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:40 +0100
Message-Id: <1395407925-25518-8-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH_07/12=5D_Don=E2=80=99t_show_th?=
	=?utf-8?q?e_connection_profile_store_in_options-=3Ece_if_there_is_?=
	=?utf-8?q?a_connection=5Flist_defined=2E?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Entries in options->ce are never used and overwritten by the first usable connection profile on initialisation.
---
 src/openvpn/options.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cb2cf95..c5746c5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1406,8 +1406,6 @@ show_connection_entry (const struct connection_entry *o)
 static void
 show_connection_entries (const struct options *o)
 {
-  msg (D_SHOW_PARMS, "Connection profiles [default]:");
-  show_connection_entry (&o->ce);
  if (o->connection_list)
    {
      const struct connection_list *l = o->connection_list;
@@ -1418,6 +1416,11 @@ show_connection_entries (const struct options *o)
 	 show_connection_entry (l->array[i]);
        }
    }
+ else
+   {
+     msg (D_SHOW_PARMS, "Connection profiles [default]:");
+     show_connection_entry (&o->ce);
+   }
   msg (D_SHOW_PARMS, "Connection profiles END");
 }
 
-- 
1.8.5.2 (Apple Git-48)


