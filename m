Content-Type: multipart/alternative;
 boundary="------------05yDJXJKmtYtjtb856W5RMjo"
Message-ID: <a82d032f-4010-4368-b667-1f398ac309cb@...1227...>
Date: Tue, 29 Apr 2025 10:24:12 +0200
MIME-Version: 1.0
References: <20250428214629.49104-1-kn@...2273...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20250428214629.49104-1-kn@...2273...>
Subject: Re: [Openvpn-devel] [SPAM] [PATCH] Skip tmp-dir check unless
 actualy used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Klemens Nanni <kn@...2273...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------05yDJXJKmtYtjtb856W5RMjo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 28.04.2025 um 23:46 schrieb Klemens Nanni:
> As per the manual, it is subject to `chroot` and used only by
> `client-connect` and `plugin`.
>
> Without additional code being run and `chroot /var/empty/` (amongst
> `user`, `persist-*`, etc.) set to reduce run-time privileges as much as
> possible, the default temporary is still required upon start:
>
> Options error: Temporary directory (--tmp-dir) fails with '/var/empty///tmp': No such file or directory (errno=2)
>
> `tmp-dir /` works around this, but should not be needed.
>
> In this setup, client and server have no create/write filesystem access
> at all after privilege drop;  with this fix, ktrace(1) (on OpenBSD)
> shows no namei(9) lookup being made at runtime (after `chroot`):
>
> 	# ktrace -d -i -tn ./openvpn --config ./conf --tmp-dir /nonexistent/
> 	...^C
> 	# kdump | grep -q -e/tmp -e/nonexistent ; echo $?
> ---
>   src/openvpn/options.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 96119c48..effa8d0f 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -4149,8 +4149,17 @@ options_postprocess_filechecks(struct options *options)
>       /* ** Config related ** */
>       errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
>                                        R_OK|X_OK, "--client-config-dir");
> -    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
> -                                     R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
> +
> +    msg(M_WARN|M_NOPREFIX, "tmp_dir = '%s'", options->tmp_dir);
> +    if (options->client_connect_script
> +#ifdef ENABLE_PLUGIN
> +        || options->plugin_list
> +#endif /* ENABLE_PLUGIN */
> +       )
> +    {
> +        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
> +                                         R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
> +    }
>   

There are more instances where the tmp dir is used. Just to name one of 
the top of my head is tls-crypt-v2-verify. I wonder if the benefit herre 
is big enough. As you said, even in your ro scenario it can be 
workarounded with specifying an existing directory.

Arne

--------------05yDJXJKmtYtjtb856W5RMjo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Am 28.04.2025 um 23:46 schrieb Klemens
      Nanni:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250428214629.49104-1-kn@...2273...">
      <pre wrap="" class="moz-quote-pre">As per the manual, it is subject to `chroot` and used only by
`client-connect` and `plugin`.

Without additional code being run and `chroot /var/empty/` (amongst
`user`, `persist-*`, etc.) set to reduce run-time privileges as much as
possible, the default temporary is still required upon start:

Options error: Temporary directory (--tmp-dir) fails with '/var/empty///tmp': No such file or directory (errno=2)

`tmp-dir /` works around this, but should not be needed.

In this setup, client and server have no create/write filesystem access
at all after privilege drop;  with this fix, ktrace(1) (on OpenBSD)
shows no namei(9) lookup being made at runtime (after `chroot`):

	# ktrace -d -i -tn ./openvpn --config ./conf --tmp-dir /nonexistent/
	...^C
	# kdump | grep -q -e/tmp -e/nonexistent ; echo $?
---
 src/openvpn/options.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 96119c48..effa8d0f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4149,8 +4149,17 @@ options_postprocess_filechecks(struct options *options)
     /* ** Config related ** */
     errs |= check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir,
                                      R_OK|X_OK, "--client-config-dir");
-    errs |= check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,
-                                     R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+
+    msg(M_WARN|M_NOPREFIX, "tmp_dir = '%s'", options-&gt;tmp_dir);
+    if (options-&gt;client_connect_script
+#ifdef ENABLE_PLUGIN
+        || options-&gt;plugin_list
+#endif /* ENABLE_PLUGIN */
+       )
+    {
+        errs |= check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,
+                                         R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+    }
 
</pre>
    </blockquote>
    <p>There are more instances where the tmp dir is used. Just to name
      one of the top of my head is tls-crypt-v2-verify. I wonder if the
      benefit herre is big enough. As you said, even in your ro scenario
      it can be workarounded with specifying an existing directory.</p>
    <p><span style="white-space: pre-wrap">Arne
</span></p>
  </body>
</html>

--------------05yDJXJKmtYtjtb856W5RMjo--

