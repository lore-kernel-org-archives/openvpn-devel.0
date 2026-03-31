From: Gert Doering <gert@...1296...>
Date: Tue, 31 Mar 2026 08:01:05 +0200
Message-ID: <20260331060112.5195-1-gert@...1296...>
In-Reply-To: <gerrit.1774906039000.I1a6dfc175075636bc7a5761215547077a9dc397a@...2715...>
References: <gerrit.1774906039000.I1a6dfc175075636bc7a5761215547077a9dc397a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_ncp: Fix type of "found" parameter
 of check_pull_client_ncp
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

From: Frank Lichtenheld <frank@...2641...>

In commit 91fd9614f980b02772e4dfbb09144c822ec97df0 type
of "found" was changed to uint64_t. But due to -Wconversion
not yet enabled in all of init.c one occurence of the old
type was missed.

Change-Id: I1a6dfc175075636bc7a5761215547077a9dc397a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1594
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1594
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index fdac6925..649665a 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -307,7 +307,7 @@
 }
 
 bool
-check_pull_client_ncp(struct context *c, const unsigned int found)
+check_pull_client_ncp(struct context *c, const uint64_t found)
 {
     if (found & OPT_P_NCP)
     {
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 837f662..dc3a750 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -49,7 +49,7 @@
  *
  * @return  Wether the client NCP process suceeded or failed
  */
-bool check_pull_client_ncp(struct context *c, unsigned int found);
+bool check_pull_client_ncp(struct context *c, uint64_t found);
 
 /**
  * Iterates through the ciphers in server_list and return the first

