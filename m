From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:32 +0200
Message-Id: <1330546342-17794-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 02/52] package: rpm: strip should be handled
	by package management
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 openvpn.spec.in |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/openvpn.spec.in b/openvpn.spec.in
index c5178e9..c42e7c6 100644
--- a/openvpn.spec.in
+++ b/openvpn.spec.in
@@ -101,7 +101,6 @@ and portability to most major OS platforms.
 %build
 %configure --disable-dependency-tracking %{?with_password_save:--enable-password-save} %{?without_lzo:--disable-lzo} %{?with_kerberos:--with-ssl-headers=/usr/kerberos/include}
 %__make
-%__strip %{name}
 
 # Build down-root plugin
 pushd plugin/down-root
-- 
1.7.3.4


