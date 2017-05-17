From: =?utf-8?Q?Adam_=C5=A0tevko?= <adam.stevko@...277...>
Mime-Version: 1.0 (1.0)
Date: Wed, 17 May 2017 10:53:58 +0200
Message-Id: <8925EED7-0E13-4DEE-B3F8-1A5E3E970F4A@...277...>
Subject: [Openvpn-devel] [PATCH] OpenVPN rpm packaging - iproute2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

this patch adds support to build openvpn rpms with iproute2 support. It's a=
 rather simple change, which defaults to off. Please review.

Cheers,
Adam

Date: Fri, 12 May 2017 12:00:50 +0200
Subject: [PATCH] Add option to enable iproute2 support

---
distro/rpm/openvpn.spec.in | 10 +++++++++-
1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/distro/rpm/openvpn.spec.in b/distro/rpm/openvpn.spec.in
index 20a8c890..eca39257 100644
--- a/distro/rpm/openvpn.spec.in
+++ b/distro/rpm/openvpn.spec.in
@@ -10,6 +10,10 @@
#
# Allow passwords to be read from files
#   rpmbuild -tb [openvpn.x.tar.gz] --define 'with_password_save 1'
+#
+# Enable iproute2 support
+#   rpmbuild -tb [openvpn.x.tar.gz] --define 'with_iproute2 1'
+#

Summary:    OpenVPN is a robust and highly flexible VPN daemon by James Yon=
an.
Name:        @PACKAGE@
@@ -52,6 +56,9 @@ Requires:    openssl       >=3D 0.9.7
%{?with_pkcs11:BuildRequires:    pkcs11-helper-devel}
%{?with_pkcs11:Requires:    pkcs11-helper}

+%{?with_iproute2:BuildRequires:    iputils}
+%{?with_iproute2:Requires:    iputils}
+
#
# Description
#
@@ -102,7 +109,8 @@ Development support for OpenVPN.
   %{?with_password_save:--enable-password-save} \
   %{!?without_lzo:--enable-lzo} \
   %{?with_pkcs11:--enable-pkcs11} \
-    %{?without_pam:--disable-plugin-auth-pam}
+    %{?without_pam:--disable-plugin-auth-pam} \
+    %{?with_iproute2:--enable-iproute2}
%__make

#
--=20
2.13.0

