From: Simon Rozman <simon@...2293...>
Date: Mon, 15 Jan 2018 12:47:28 +0100
Message-Id: <20180115114728.13672-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH] Document missing OpenVPN states
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

---
 doc/management-notes.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index a9ba18a..908b981 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -362,6 +362,8 @@ ADD_ROUTES    -- Adding routes to system.
 CONNECTED     -- Initialization Sequence Completed.
 RECONNECTING  -- A restart has occurred.
 EXITING       -- A graceful exit is in progress.
+RESOLVE       -- (Client only) DNS lookup
+TCP_CONNECT   -- (Client only) Connecting to TCP server
 
 Command examples:
 
-- 
2.9.0.windows.1


