From: David Sommerseth <davids@...515...>
Date: Fri,  8 May 2020 13:42:43 +0200
Message-Id: <20200508114243.15532-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] options: Fix failing inline
 tls-auth/crypt with persist-key
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

A configuration file using --persist-key and with inlined --tls-auth or
--tls-crypt files was failing in check_file_access().  The file argument
to check_file_access() contained the key file and not the file name.

This was because check_file_access_inline() which calls
check_file_access() if the file is not inlined was told the file was not
an inline file.

The reason the check_file_access_inline() was misled was due to a prior
option_postprocess_mutate() call puts these key files into a connection
block entry in option_postprocess_mutate_ce().  OpenVPN was modified a
long while ago to always use connection blocks in the option structure
for simplicity.  So the "root" key files would be transferred into a
connection entry in this method.

When --persist-key is used, option_postprocess_mutate_ce() will load the
key file and "convert" the option into an inline option.  But in
commit cb2e9218f2bc73fa2 this logic had lost the "inline indicator".  The
result was that the connection entry had the key file content stored in
the object but was "tagged" as a normal file (name) not an inline file.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 611652fd..a37106ce 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2936,6 +2936,7 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
             }
 
             ce->tls_auth_file = (char *)in.data;
+            ce->tls_auth_file_inline = true;
         }
 
         if (ce->tls_crypt_file && !ce->tls_crypt_file_inline)
@@ -2948,6 +2949,7 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
             }
 
             ce->tls_crypt_file = (char *)in.data;
+            ce->tls_crypt_file_inline = true;
         }
     }
 }
-- 
2.26.0


