From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Feb 2012 18:30:41 +0100
Message-ID: <1329413441-22538-5-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] make MSVC link against shell32 as well
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

Windows API CommandLineToArgvW(), introduced in Windows unicode path
commit 71bbbd76c62630c88441237d72fe5b61f0b45b2a, is defined therein.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 win/msvc.mak.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/win/msvc.mak.in b/win/msvc.mak.in
index 115e395..191f370 100644
--- a/win/msvc.mak.in
+++ b/win/msvc.mak.in
@@ -31,7 +31,7 @@ LZO_DYNAMIC = lzo2.lib
 
 INCLUDE_DIRS = -I$(OPENSSL)/include -I$(POLARSSL)/include -I$(LZO)/include -I$(PKCS11_HELPER)/include
 
-LIBS = $(OPENSSL_DYNAMIC) $(POLARSSL_DYNAMIC) $(PKCS11_HELPER_DYNAMIC) $(LZO_DYNAMIC) ws2_32.lib crypt32.lib iphlpapi.lib winmm.lib user32.lib gdi32.lib advapi32.lib wininet.lib
+LIBS = $(OPENSSL_DYNAMIC) $(POLARSSL_DYNAMIC) $(PKCS11_HELPER_DYNAMIC) $(LZO_DYNAMIC) ws2_32.lib crypt32.lib iphlpapi.lib winmm.lib user32.lib gdi32.lib advapi32.lib wininet.lib shell32.lib
 
 LIB_DIRS = -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSSL)\build\library -LIBPATH:$(PKCS11_HELPER)\lib -LIBPATH:$(LZO)\lib
 
-- 
1.7.5.4


