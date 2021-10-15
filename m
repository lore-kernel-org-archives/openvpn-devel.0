From: selva.nair@...277...
Date: Fri, 15 Oct 2021 14:47:33 -0400
Message-Id: <20211015184733.16988-1-selva.nair@...277...>
In-Reply-To: <20211015175330.15760-1-selva.nair@...277...>
References: <20211015175330.15760-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH for 2.5] Fix some more wrong defines in
 config-msvc.h
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

Not sure where these came from, but here goes:

S_IRUSR = 0 --> _S_IREAD
S_IWUSR = 0 --> _S_IWRITE

ENABLE_DEBUG is on, but I do not think we want it in production build.
Changed to ENABLE_DEBUG 0

S_IRGRP is not defined but seems to be used. I have added it, remove if
not required.
This define is based on mingw and matches MS docs on <filesystem>
(https://docs.microsoft.com/en-us/cpp/standard-library/filesystem-enumerations?view=msvc-160)

Should fix Trac #1430 but untested (I do not have a setup at hand for msvc build).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 config-msvc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index a39eeed8..9fc8d1cc 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -5,8 +5,7 @@
 #define ENABLE_DEF_AUTH 1
 #define ENABLE_PF 1
 #define ENABLE_CRYPTO_OPENSSL 1
-#define ENABLE_DEBUG 1
-#define ENABLE_EUREPHIA 1
+#define ENABLE_DEBUG 0
 #define ENABLE_FRAGMENT 1
 #define ENABLE_HTTP_PROXY 1
 #define ENABLE_LZO 1
@@ -144,8 +143,9 @@
 #define in_addr_t uint32_t
 #define ssize_t SSIZE_T
 
-#define S_IRUSR 0
-#define S_IWUSR 0
+#define S_IRUSR _S_IREAD
+#define S_IWUSR _S_IWRITE
+#define S_IRGRP (S_IRUSR >> 3)
 #define R_OK 4
 #define W_OK 2
 #define X_OK 1
-- 
2.20.1


