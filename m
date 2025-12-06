From: Gert Doering <gert@...1296...>
Date: Sat,  6 Dec 2025 21:54:53 +0100
Message-ID: <20251206205458.27028-1-gert@...1296...>
In-Reply-To: <gerrit.1765030148000.I99a6604fdfc682f9609bfe7672aa78285084dcb9@...2715...>
References: <gerrit.1765030148000.I99a6604fdfc682f9609bfe7672aa78285084dcb9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Prevent crash on invalid server-ipv6
 argument
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

From: Klemens Nanni <kn@...2273...>

`get_addr_generic()` expects `openvpn_getaddrinfo()` to return a newly
allocated struct, but getaddrinfo(3) failure leaves `*ai = NULL` as-is.

Unlike free(3), freegetaddrinfo(3) requires a valid struct, thus the
following is enough to trigger a NULL pointer dereference in libc:

```
$ openvpn --server-ipv6 ''
2025-12-06 11:59:18 RESOLVE: Cannot resolve host address: :[AF_INET6] (no address associated with name)
Segmentation fault (core dumped)
```

Guard against empty `ai`, i.e. failure, like similar code already does:

```
$ ./openvpn --server-ipv6 ''
2025-12-06 12:05:11 RESOLVE: Cannot resolve host address: :[AF_INET6] (no address associated with name)
Options error: error parsing --server-ipv6 parameter
Use --help for more information.
```

Spotted through a configuration typo "server-ipv6 fd00:/64" with 2.6.17,
reproduced with and tested against 2.7rc3 on OpenBSD/amd64 7.8-current.

Change-Id: I99a6604fdfc682f9609bfe7672aa78285084dcb9
Signed-off-by: Klemens Nanni <kn@...2273...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1418
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1418
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 46bedf4..80c2895 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -189,7 +189,10 @@
         *sep = '/';
     }
 out:
-    freeaddrinfo(ai);
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
     free(var_host);
 
     return ret;

