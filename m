From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 22 Sep 2020 13:00:21 +0300
Message-Id: <20200922100021.20329-1-lstipakov@...277...>
In-Reply-To: <20200929065535.GJ976@...1296...>
References: <20200929065535.GJ976@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Alias ADAPTER_DOMAIN_SUFFIX to DOMAIN
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

ADAPTER_DOMAIN_SUFFIX is an openvpn3 replacement for
DOMAIN, which is used there for split-dns. This option is pushed
by modern Access Server.

This change improves compatibility between OpenVPN
community client and Access Server.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v2:
    - fixed long line in C code
    - left out --help change
    - slightly changed man text
 
 doc/man-sections/vpn-network-options.rst | 4 ++++
 src/openvpn/options.c                    | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 825dd1ca..26682789 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -114,6 +114,10 @@ routing.
   :code:`DOMAIN` ``name``
         Set Connection-specific DNS Suffix to :code:`name`.
 
+  :code:`ADAPTER_DOMAIN_SUFFIX` ``name``
+        Alias to :code:`DOMAIN`. This is a compatibility option, it
+        should not be used in new deployments.
+
   :code:`DOMAIN-SEARCH` ``name``
         Add :code:`name` to the domain search list.
         Repeat this option to add more entries. Up to
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4b22d3d9..3df803db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7440,7 +7440,8 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_IPWIN32);
         bool ipv6dns = false;
 
-        if (streq(p[1], "DOMAIN") && p[2])
+        if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX"))
+            && p[2])
         {
             o->domain = p[2];
         }
-- 
2.17.1


