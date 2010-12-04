From: Matthias Andree <matthias.andree@...68...>
Date: Sat,  4 Dec 2010 14:02:37 +0100
Message-Id: <1291467757-7115-1-git-send-email-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH] Remove excess semicolon (invalid C99).
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
Cc: Matthias Andree <matthias.andree@...68...>

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 misc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc.h b/misc.h
index 3f22ca0..f449601 100644
--- a/misc.h
+++ b/misc.h
@@ -143,7 +143,7 @@ openvpn_run_script (const struct argv *a, const struct env_set *es, const unsign
 
   openvpn_snprintf(msg, sizeof(msg), "WARNING: Failed running command (%s)", hook);
   return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
-};
+}
 
 #ifdef HAVE_STRERROR
 /* a thread-safe version of strerror */
-- 
1.7.3.2.5.gf772c


