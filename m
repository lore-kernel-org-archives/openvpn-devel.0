Message-ID: <4BD54411.4080603@...1114...>
Date: Mon, 26 Apr 2010 09:43:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272235375-20327-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1272235375-20327-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid repetition of "this config may
 cache	passwords in memory"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 00:42, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> For OpenVPN clients with long living connections, this message is repeated
> everytime the connection is renegotiated.  This patch removes this behaviour
> and will only show this warning once.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  misc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/misc.c b/misc.c
> index 643ffad..7052584 100644
> --- a/misc.c
> +++ b/misc.c
> @@ -1588,14 +1588,16 @@ void
>  purge_user_pass (struct user_pass *up, const bool force)
>  {
>    const bool nocache = up->nocache;
> +  static warn_shown = false;

Well, this came as a surprise when I just quickly looked through it now
in the morning.  I'll have recheck this one ... I'm pretty sure I wrote
'static bool' as the variable declaration.  That's more proper anyway.
I'll fix this today.

>    if (nocache || force)
>      {
>        CLEAR (*up);
>        up->nocache = nocache;
>      }
> -  else
> +  else if (!warn_shown)
>      {
>        msg (M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
> +      warn_shown = true;
>      }
>  }
>  


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvVRBEACgkQDC186MBRfrpJ6ACfVC1LzHDOvzUHtSN6QSKzELSh
EP8An23EMCXf3cKVILvgjXq56NHSyC6m
=e+I7
-----END PGP SIGNATURE-----

