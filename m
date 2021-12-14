From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:22 -0500
Message-Id: <20211214165928.30676-13-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 12/18] Increase ERR_BUF_SIZE when
 management interface support is enabled
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

From: Selva Nair <selva.nair@...277...>

Sending largish messages to the management interface errors due to
the limited size used for the "error" buffer in x_msg_va(). Although
all intermediate steps allocate required space for the data to
send, it gets truncated at the last step.

This really requires a smarter fix. As a quick relief, we just increase
the buffer size to 10240 when management support is compiled in. Should
be enough for PK_SIGN with undigested message.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/error.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 533354b3..66c1722e 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -37,8 +37,8 @@
 
 /* #define ABORT_ON_ERROR */
 
-#ifdef ENABLE_PKCS11
-#define ERR_BUF_SIZE 8192
+#if defined(ENABLE_PKCS11) || defined(ENABLE_MANAGEMENT)
+#define ERR_BUF_SIZE 10240
 #else
 #define ERR_BUF_SIZE 1280
 #endif
-- 
2.30.2


