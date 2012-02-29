From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:28:02 +0200
Message-Id: <1330547285-18481-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547285-18481-1-git-send-email-alon.barlev@...277...>
References: <1330547285-18481-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [easy-rsa 1/4] cleanup: fix execute permission
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
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 easy-rsa/1.0/list-crl
 mode change 100644 => 100755 easy-rsa/1.0/make-crl
 mode change 100644 => 100755 easy-rsa/1.0/revoke-crt
 mode change 100755 => 100644 easy-rsa/2.0/openssl-0.9.6.cnf
 mode change 100755 => 100644 easy-rsa/2.0/openssl-0.9.8.cnf
 mode change 100755 => 100644 easy-rsa/2.0/openssl-1.0.0.cnf
 mode change 100755 => 100644 easy-rsa/2.0/vars
 mode change 100755 => 100644 easy-rsa/Windows/init-config.bat

diff --git a/easy-rsa/1.0/list-crl b/easy-rsa/1.0/list-crl
old mode 100644
new mode 100755
diff --git a/easy-rsa/1.0/make-crl b/easy-rsa/1.0/make-crl
old mode 100644
new mode 100755
diff --git a/easy-rsa/1.0/revoke-crt b/easy-rsa/1.0/revoke-crt
old mode 100644
new mode 100755
diff --git a/easy-rsa/2.0/openssl-0.9.6.cnf b/easy-rsa/2.0/openssl-0.9.6.cnf
old mode 100755
new mode 100644
diff --git a/easy-rsa/2.0/openssl-0.9.8.cnf b/easy-rsa/2.0/openssl-0.9.8.cnf
old mode 100755
new mode 100644
diff --git a/easy-rsa/2.0/openssl-1.0.0.cnf b/easy-rsa/2.0/openssl-1.0.0.cnf
old mode 100755
new mode 100644
diff --git a/easy-rsa/2.0/vars b/easy-rsa/2.0/vars
old mode 100755
new mode 100644
diff --git a/easy-rsa/Windows/init-config.bat b/easy-rsa/Windows/init-config.bat
old mode 100755
new mode 100644
-- 
1.7.3.4


