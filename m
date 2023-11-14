From: Gert Doering <gert@...1296...>
Date: Tue, 14 Nov 2023 15:16:53 +0100
Message-ID: <20231114141653.10486-1-gert@...1296...>
In-Reply-To: <gerrit.1699964322000.I53eaee85d7b284af6bc63da5f6d8f310ddd96c47@...2715...>
References: <gerrit.1699964322000.I53eaee85d7b284af6bc63da5f6d8f310ddd96c47@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] config.h: fix incorrect defines for
 _wopen()
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

From: Lev Stipakov <lev@...515...>

This is a regression from commit

  01341840 ("add basic CMake based build")

S_IRUSR and S_IWUSR should NOT be defined as 0 but
as _S_IREAD and _S_IWRITE, as it was already fixed in commit

  077445d0 ("Fix some more wrong defines in config-msvc.h")

Those are used as permission mode when opening a file. Passing
zero makes file read-only, which break for example --status-file
functionality.

Github: fixes OpenVPN/openvpn#454
Trac: #1430

Change-Id: I53eaee85d7b284af6bc63da5f6d8f310ddd96c47
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/429
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index f2cdd39..1c0dd6f 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -469,8 +469,8 @@
 #define strncasecmp strnicmp
 #define strcasecmp _stricmp
 
-#define S_IRUSR 0
-#define S_IWUSR 0
+#define S_IRUSR _S_IREAD
+#define S_IWUSR _S_IWRITE
 #define R_OK 4
 #define W_OK 2
 #define X_OK 1

