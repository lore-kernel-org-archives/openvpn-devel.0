MIME-Version: 1.0
References: <CAEeEfvzkhp_FQ8cnOZcASiVbDN8=+Gw_2sV5SNonL5x7OYb1jA@...278...>
 <892bc3fa-b752-b959-1ea4-19b106c0915c@...1227...>
In-Reply-To: <892bc3fa-b752-b959-1ea4-19b106c0915c@...1227...>
From: Merten Fermont <merten.fermont@...277...>
Date: Thu, 27 Jul 2023 14:21:29 +0200
Message-ID: <CAEeEfvyw2AKiKV1DW2mPA8C332pK7nroA9=BtpqEND2TPGmFog@...278...>
Subject: Re: [Openvpn-devel] [PATCH OpenVPN3] Add 'pull' to ignored options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Arne,

I changed my patch to check the client and client+pull options.
Giving an error when neither options are declared.

This however may break current implementations that depend on 'client'
not being a required option?

Greetings,
Merten

Subject: [PATCH] Check for client options

Require 'client' or 'tls-client'+'pull' to be declared in the config.
To prevent other errors, 'client' option is added when 'tls-client'
and 'pull' are both declared.

Fixes error that --pull is an unknown option.
---
openvpn/client/cliopt.hpp       |  1 -
openvpn/client/cliopthelper.hpp | 11 ++++++++++-
openvpn/common/options.hpp      |  4 ++--
3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/openvpn/client/cliopt.hpp b/openvpn/client/cliopt.hpp
index f7be44a8..8c52a5c0 100644
--- a/openvpn/client/cliopt.hpp
+++ b/openvpn/client/cliopt.hpp
@@ -801,7 +801,6 @@ class ClientOptions : public RC<thread_unsafe_refcount>
        "replay-persist", /* Makes little sense in TLS mode */
        "script-security",
        "sndbuf",
-        "tls-client", /* Always enabled */
        "tmp-dir",
        "tun-ipv6",   /* ignored in v2 as well */
        "txqueuelen", /* so platforms evaluate that in tun, some do
not, do not warn about that */
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
+                throw option_error("No 'client' or
'tls-client'+'pull' directive declared. Other roles are not
supported.");
+            }

            // dev
            if (!options.exists("dev"))
diff --git a/openvpn/common/options.hpp b/openvpn/common/options.hpp
index d594c41a..a813647e 100644
--- a/openvpn/common/options.hpp
+++ b/openvpn/common/options.hpp
@@ -1460,11 +1460,11 @@ class OptionList : public std::vector<Option>,
public RCCopyable<thread_unsafe_r
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

On Thu, 27 Jul 2023 at 11:14, Arne Schwabe <arne@...1227...> wrote:
>
> Am 27.07.23 um 10:52 schrieb Merten Fermont:
> > Fixes error that --pull is an unknown option in client config.
> > ---
> > openvpn/client/cliopt.hpp | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/openvpn/client/cliopt.hpp b/openvpn/client/cliopt.hpp
> > index f7be44a8..431791f3 100644
> > --- a/openvpn/client/cliopt.hpp
> > +++ b/openvpn/client/cliopt.hpp
> > @@ -797,6 +797,7 @@ class ClientOptions : public RC<thread_unsafe_refcount>
> >          "mute-replay-warnings",
> >          "nobind", /* only behaviour in v3 client anyway */
> >          "prng",
> > +        "pull", /* option is implied by 'client' */
> >          "rcvbuf",         /* present in many configs */
> >          "replay-persist", /* Makes little sense in TLS mode */
> >          "script-security",
>
>
> While that will work, it would be better to not ignore that option but
> handle it in a similar way to --client. In general we should actually
> throw an error if neither client or tls-client+pull are present as
> OpenVPN3 cannot operate without these in p2p mode.
>
> Arne
>

