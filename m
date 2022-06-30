From: selva.nair@...277...
Date: Thu, 30 Jun 2022 15:05:48 -0400
Message-Id: <20220630190549.16675-2-selva.nair@...277...>
In-Reply-To: <20220630190549.16675-1-selva.nair@...277...>
References: <20220630190549.16675-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Reactivate record_peer_info in manage.c
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

From: Selva Nair <selva.nair@...277...>

--management-client has an obscure and undocumented feature
to take a file argument where the peer's address and port are
recorded. This has become dead code over time.

- reactivate the dead code
- make it work with v6 addresses as well
- do not exit on error in writing the record

Signed-off-by: Selva Nair <selva.nair@...277...>
---

Alternatively we could remove this "feature" and related code.

 src/openvpn/manage.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 21c7ccdd..548d3b9a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1621,23 +1621,19 @@ man_record_peer_info(struct management *man)
     if (man->settings.write_peer_info_file)
     {
         bool success = false;
-#ifdef HAVE_GETSOCKNAME
         if (socket_defined(man->connection.sd_cli))
         {
-            struct sockaddr_in addr;
+            struct sockaddr_storage addr;
             socklen_t addrlen = sizeof(addr);
             int status;
 
-            CLEAR(addr);
             status = getsockname(man->connection.sd_cli, (struct sockaddr *)&addr, &addrlen);
-            if (!status && addrlen == sizeof(addr))
+            if (!status)
             {
-                const in_addr_t a = ntohl(addr.sin_addr.s_addr);
-                const int p = ntohs(addr.sin_port);
                 FILE *fp = platform_fopen(man->settings.write_peer_info_file, "w");
                 if (fp)
                 {
-                    fprintf(fp, "%s\n%d\n", print_in_addr_t(a, 0, &gc), p);
+                    fprintf(fp, "%s\n", print_sockaddr((struct sockaddr *)&addr, &gc));
                     if (!fclose(fp))
                     {
                         success = true;
@@ -1645,12 +1641,10 @@ man_record_peer_info(struct management *man)
                 }
             }
         }
-#endif /* ifdef HAVE_GETSOCKNAME */
         if (!success)
         {
             msg(D_MANAGEMENT, "MANAGEMENT: failed to write peer info to file %s",
                 man->settings.write_peer_info_file);
-            throw_signal_soft(SIGTERM, "management-connect-failed");
         }
     }
     gc_free(&gc);
-- 
2.30.2


