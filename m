From: Alon Bar-Lev <alon.barlev@...277...>
Date: Fri, 27 Apr 2012 16:40:54 +0300
Message-Id: <1335534054-14895-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz28aDw=eyLbQRBXU1KaaXom937adipzcAh_UW0rvuB7XQ@...278...>
References: <CAOazyz28aDw=eyLbQRBXU1KaaXom937adipzcAh_UW0rvuB7XQ@...278...>
Subject: [Openvpn-devel] [PATCH] build: fix typo in --enable-save-password
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index e808cb4..7140d17 100644
--- a/configure.ac
+++ b/configure.ac
@@ -168,6 +168,7 @@ AC_ARG_ENABLE(
 AC_ARG_ENABLE(
 	[password-save],
 	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file @<:@default=yes@:>@])],
+	,
 	[enable_password_save="no"]
 )
 
-- 
1.7.3.4


