From: Gert Doering <gert@...1296...>
Date: Wed, 23 Jul 2025 08:20:06 +0200
Message-ID: <20250723062012.22781-1-gert@...1296...>
In-Reply-To: <gerrit.1753215725000.I18df6ef659cab9525dd7847b7dd3950fc1895dd5@...2715...>
References: <gerrit.1753215725000.I18df6ef659cab9525dd7847b7dd3950fc1895dd5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco_linux: fix case statement by using
 proper error value
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

From: Antonio Quartulli <antonio@...2726...>

A M_ERR constant accidentally slipped in as possible
netlink error value.

Substitute it with the actual code matching the following
error message.

Change-Id: I18df6ef659cab9525dd7847b7dd3950fc1895dd5
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1095
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index c92c196..58051f5 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -143,7 +143,7 @@
             msg(M_ERR, "%s: netlink out of memory error", prefix);
             break;
 
-        case -M_ERR:
+        case -NLE_AGAIN:
             msg(M_WARN, "%s: netlink reports blocking read - aborting wait", prefix);
             break;
 

