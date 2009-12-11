Message-ID: <4B21A937.2070301@...41...>
Date: Thu, 10 Dec 2009 19:06:47 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4B1F6CEA.2000708@...1114...>
In-Reply-To: <4B1F6CEA.2000708@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn-down-root.so causes a segfault
 on	premature exits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

David,

I've committed a fix for this:

------------------------------------------------------------------------
r5261 | james | 2009-12-10 16:50:03 -0700 (Thu, 10 Dec 2009) | 10 lines
Changed paths:
    M /branches/BETA21/openvpn/plugin/auth-pam/auth-pam.c
    M /branches/BETA21/openvpn/plugin/down-root/down-root.c

Fixed a couple issues in sample plugins auth-pam.c and down-root.c:

1. Fail gracefully rather than segfault if calloc returns NULL.

2. The openvpn_plugin_abort_v1 function can potentially be called
    with handle == NULL.  Add code to detect this case, and if
    so, avoid dereferencing pointers derived from handle.

(Thanks to David Sommerseth for finding this bug).

------------------------------------------------------------------------

Note that there's an implicit semantics in the plugin system that 
plugins will be called with openvpn_plugin_handle_t handle != NULL, with 
the exception of openvpn_plugin_abort_v1.  Abort is treated differently 
since there could conceivably be cases where the plugin has allocated 
resources before openvpn_plugin_open_v(1|2) has established the context. 
  But it's not necessary to check for context == NULL except in the 2 
places addressed by the above commit.

James


David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> If openvpn is interrupted before openvpn_plugin_open_v1() is called,
> there is no context allocated which openvpn_plugin_abort_v1() can use.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> 
> - ---
>  plugin/down-root/down-root.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/plugin/down-root/down-root.c b/plugin/down-root/down-root.c
> index 5e0c002..77497ad 100644
> - --- a/plugin/down-root/down-root.c
> +++ b/plugin/down-root/down-root.c
> @@ -434,7 +434,7 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
>  {
>    struct down_root_context *context = (struct down_root_context *) handle;
> 
> - -  if (context->foreground_fd >= 0)
> +  if (context && context->foreground_fd >= 0)
>      {
>        /* tell background process to exit */
>        send_control (context->foreground_fd, COMMAND_EXIT);
> - -- 
> 1.6.2.5
> 
> (patch attached in addition for convenience)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAksfbOUACgkQDC186MBRfrqSgwCeOZPg+70ryTCCyoW8D9QtLmeF
> pwwAn2pWo9529hvBzlMgj8izabtG9Ioc
> =o0Ym
> -----END PGP SIGNATURE-----
> 
> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> Return on Information:
> Google Enterprise Search pays you back
> Get the facts.
> http://p.sf.net/sfu/google-dev2dev
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

