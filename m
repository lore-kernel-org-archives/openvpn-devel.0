From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:27 +0200
Message-Id: <20211019183127.614175-22-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 21/21] Always use 8192 bytes for
 ERR_BUF_SIZE
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

The signature messages required by external key managed also break
the 1280 limit. To also avoid this surprise of different behaviour
with PKCS11 enabled/disable, always use the larger size.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/error.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 533354b3c..c36a82659 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -36,12 +36,8 @@
 #endif
 
 /* #define ABORT_ON_ERROR */
-
-#ifdef ENABLE_PKCS11
 #define ERR_BUF_SIZE 8192
-#else
-#define ERR_BUF_SIZE 1280
-#endif
+
 
 struct gc_arena;
 
-- 
2.33.0


