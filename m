From: Richard T Bonhomme <stringvest88@...277...>
Date: Mon, 29 Nov 2021 16:55:38 +0000
Message-Id: <20211129165538.2948077-1-tincantech@...2282...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc/protocol-options.rst: Correct default
 for --allow-compression
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

Signed-off-by: Richard T Bonhomme <tincantech@...2282...>
---
 doc/man-sections/protocol-options.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index c7aa6b0e..bde91779 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -18,13 +18,13 @@ configured in a compatible way between both the local and remote side.
 
   The ``mode`` argument can be one of the following values:
 
-  :code:`asym`  (default)
+  :code:`asym`
       OpenVPN will only *decompress downlink packets* but *not compress
       uplink packets*.  This also allows migrating to disable compression
       when changing both server and client configurations to remove
       compression at the same time is not a feasible option.
 
-  :code:`no`
+  :code:`no`  (default)
       OpenVPN will refuse any non-stub compression.
 
   :code:`yes`
-- 
2.25.1


