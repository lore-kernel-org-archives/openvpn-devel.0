From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon,  2 Apr 2012 14:37:41 +0300
Message-Id: <1333366661-6711-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333041552-6752-1-git-send-email-alon.barlev@...277...>
References: <1333041552-6752-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] cleanup: add .gitattributes to control eol
	style explicitly
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Having the text auto detection is a risk, as the detection may detect
text files that are not text and vise versa.

Having global setting will create confusion and differentiate between
users. So this patch also move this to local repository.

Having git to check out files differently in different OS is also
a not correct, as checkouts may be used in shares or in *NIX emulation
environments, so it have no effect.

Another issue is packaging, if we change out the tree differently
in several OSes, we may have different package content, which is
something that should be avoided.

Currently any editor of MS supports LF end of lines, so there is no
need to convert source files while checking out.

The visual studio files should be stored as CRLF as they are generated
by visual studio every save, in a way that CRLF are added.

I handled only the files that may be touch by MS users.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitattributes |    7 +++++++
 Makefile.am    |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100644 .gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..34463f9
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1,7 @@
+*.c eol=lf
+*.h eol=lf
+*.rc eol=lf
+*.txt eol=lf
+*.bat eol=lf
+*.vc*proj* eol=crlf
+*.sln eol=crlf
diff --git a/Makefile.am b/Makefile.am
index 68aa0a8..ab3e3d2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -52,6 +52,7 @@ dist_doc_DATA = \
 
 dist_noinst_DATA = \
 	.gitignore \
+	.gitattributes \
 	PORTS \
 	README.IPv6 TODO.IPv6 \
 	README.polarssl \
-- 
1.7.3.4


