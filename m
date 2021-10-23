From: selva.nair@...277...
Date: Fri, 22 Oct 2021 20:07:06 -0400
Message-Id: <20211023000706.25016-2-selva.nair@...277...>
In-Reply-To: <20211023000706.25016-1-selva.nair@...277...>
References: <20211023000706.25016-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH for 2.5] Ensure the current common_name is
 in the environment for scripts
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

When username-as-common-name is in effect, the common_name
is "CN" from the certificate for auth-user-pass-verify. It gets
changed to "username" after successful authentication. This
changed value gets into the env when client-connect script is
called.

However, "common_name" goes through the cycle of being
"CN", then "username" during every reauth (renegotiation).
As the client-connect script is not called during reneg, the changed
value never gets back into the env. The end result is that the
disconnect script gets "common_name=<CN>" instead of the username.
Unless no reneg steps have happened before disconnect.
(For a more detailed analysis see
https://community.openvpn.net/openvpn/ticket/1434#comment:12)

Fix by adding common_name to env whenever it changes.

Trac: #1434
Very likely applies to #160 as well, but that's too old and
some of the relevant code path has evolved since then.

Same as for 2.6 except for the context change due to PF.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl_verify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 4f3b61d6..0ccd43d0 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -116,6 +116,8 @@ set_common_name(struct tls_session *session, const char *common_name)
         }
 #endif
     }
+    /* update common name in env */
+    setenv_str(session->opt->es, "common_name", common_name);
 }
 
 /*
-- 
2.30.2


