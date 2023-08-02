From: merten.fermont@...277...
Date: Wed,  2 Aug 2023 13:52:12 +0200
Message-ID: <20230802115212.25000-1-merten.fermont@...277...>
In-Reply-To: <7e3baf77.AWYAACLanAUAAAAAAAAAAWpzJVQAAYCsnhYAAAAAABXTlQBkyU1m@...2677...>
References: <7e3baf77.AWYAACLanAUAAAAAAAAAAWpzJVQAAYCsnhYAAAAAABXTlQBkyU1m@...2677...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Check for client options
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

From: Merten Fermont <merten.fermont@...277...>

Require 'client' or 'tls-client'+'pull' to be declared in the config.
To prevent other errors, 'client' option is added when 'tls-client'
and 'pull' are both declared.

Fixes error that --pull is a unknown option.
---
 openvpn/client/cliopt.hpp       |  1 -
 openvpn/client/cliopthelper.hpp | 11 ++++++++++-
 openvpn/common/options.hpp      |  4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/openvpn/client/cliopt.hpp b/openvpn/client/cliopt.hpp
index 431791f3..ce2e84cc 100644
--- a/openvpn/client/cliopt.hpp
+++ b/openvpn/client/cliopt.hpp
@@ -802,7 +802,6 @@ class ClientOptions : public RC<thread_unsafe_refcount>
         "replay-persist", /* Makes little sense in TLS mode */
         "script-security",
         "sndbuf",
-        "tls-client", /* Always enabled */
         "tmp-dir",
         "tun-ipv6",   /* ignored in v2 as well */
         "txqueuelen", /* so platforms evaluate that in tun, some do not, do not warn about that */
diff --git a/openvpn/client/cliopthelper.hpp b/openvpn/client/cliopthelper.hpp
index 95aa6664..ad3b4445 100644
--- a/openvpn/client/cliopthelper.hpp
+++ b/openvpn/client/cliopthelper.hpp
@@ -367,13 +367,22 @@ class ParseClientConfig
             bool added = false;
 
             // client
-            if (!options.exists("client"))
+            if (options.exists("client"))
+            {
+                options.touch("tls-client", true);
+                options.touch("pull", true);
+            }
+            else if (options.exists("tls-client") && options.exists("pull"))
             {
                 Option opt;
                 opt.push_back("client");
                 options.push_back(std::move(opt));
                 added = true;
             }
+            else
+            {
+                throw option_error("No 'client' or 'tls-client'+'pull' directive declared. Other roles are not supported.");
+            }
 
             // dev
             if (!options.exists("dev"))
diff --git a/openvpn/common/options.hpp b/openvpn/common/options.hpp
index d594c41a..a813647e 100644
--- a/openvpn/common/options.hpp
+++ b/openvpn/common/options.hpp
@@ -1460,11 +1460,11 @@ class OptionList : public std::vector<Option>, public RCCopyable<thread_unsafe_r
     }
 
     // Touch an option, if it exists.
-    void touch(const std::string &name) const
+    void touch(const std::string &name, bool lightly = false) const
     {
         const Option *o = get_ptr(name);
         if (o)
-            o->touch();
+            o->touch(lightly);
     }
 
     // Render object as a string.
-- 
2.41.0


