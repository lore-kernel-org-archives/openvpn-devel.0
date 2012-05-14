From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 15 May 2012 01:29:40 +0300
Message-Id: <1337034580-26987-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1337034580-26987-1-git-send-email-alon.barlev@...277...>
References: <1337034580-26987-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] build: spec: we support openssl >= 0.9.7
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
 distro/rpm/openvpn.spec.in |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/distro/rpm/openvpn.spec.in b/distro/rpm/openvpn.spec.in
index de46f59..3c316bf 100644
--- a/distro/rpm/openvpn.spec.in
+++ b/distro/rpm/openvpn.spec.in
@@ -30,8 +30,8 @@ BuildRoot:	%{_tmppath}/%{name}-%(id -un)
 
 AutoReq: 0
 
-BuildRequires:	openssl-devel >= 0.9.6
-Requires:	openssl       >= 0.9.6
+BuildRequires:	openssl-devel >= 0.9.7
+Requires:	openssl       >= 0.9.7
 
 %if "%{_vendor}" == "Mandrakesoft"
 %{!?without_lzo:BuildRequires:	liblzo1-devel >= 1.07}
-- 
1.7.3.4


