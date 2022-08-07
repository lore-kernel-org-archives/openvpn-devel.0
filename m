From: Antonio Quartulli <a@...2181...>
Date: Sun,  7 Aug 2022 11:53:29 +0200
Message-Id: <20220807095329.28819-1-a@...2181...>
In-Reply-To: <20220805151325.14021-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco: disable DCO if --allow-compress
 yes/asym was specified
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
Cc: Antonio Quartulli <a@...2181...>

Allowing compression means that we may accept a pushable compress
setting.
This scenario can't work with DCO therefore disable it when compression
is allowed.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* improve wording for message
---
 src/openvpn/dco.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index c40fe96f..3fd8f82a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -352,9 +352,11 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     }
 
 #if defined(USE_COMP)
-    if (o->comp.alg != COMP_ALG_UNDEF)
+    if (o->comp.alg != COMP_ALG_UNDEF
+        || o->comp.flags & COMP_F_ALLOW_ASYM
+        || o->comp.flags & COMP_F_ALLOW_COMPRESS)
     {
-        msg(msglevel, "Note: Using compression disables data channel offload.");
+        msg(msglevel, "Note: '--allow-compression' is not set to 'no', disabling data channel offload.");
 
         if (o->mode == MODE_SERVER && !(o->comp.flags & COMP_F_MIGRATE))
         {
-- 
2.35.1


