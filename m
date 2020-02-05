From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20200205124615.15758-2-domagoj@...2540...>
Date: Wed,  5 Feb 2020 13:46:14 +0100
In-Reply-To: <20200205124615.15758-1-domagoj@...2540...>
References: <20200205124615.15758-1-domagoj@...2540...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Skip DNS address validation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

When adding IPv4 DNS servers without interactive service use
"validate=3Dno", on Windows 7 and higher, to skip time consuming automatic
address validation, that is on by default.

Fix uses adapted code from commit 786e06a

Signed-off-by: Domagoj Pensa <domagoj@...2540...>
---
 src/openvpn/tun.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index af09e676..9f369f74 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5216,6 +5216,7 @@ netsh_ifconfig_options(const char *type,
     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();
     bool delete_first =3D false;
+    bool is_dns =3D !strcmp(type, "dns");
=20
     /* first check if we should delete existing DNS/WINS settings from TAP=
 interface */
     if (test_first)
@@ -5259,6 +5260,14 @@ netsh_ifconfig_options(const char *type,
                             type,
                             flex_name,
                             print_in_addr_t(addr_list[i], 0, &gc));
+
+                /* disable slow address validation on Windows 7 and higher=
 */
+                /* only for DNS */
+                if (is_dns && win32_version_info() >=3D WIN_7)
+                {
+                    argv_printf_cat(&argv, "%s", "validate=3Dno");
+                }
+
                 netsh_command(&argv, 2, M_FATAL);
=20
                 ++count;
--=20
2.25.0



