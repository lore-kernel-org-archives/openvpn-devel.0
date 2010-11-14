Message-ID: <4CDFD060.6030104@...1114...>
Date: Sun, 14 Nov 2010 13:04:48 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <000001cb632c$a2bb8420$e8328c60$@soto@...1413...>
In-Reply-To: <000001cb632c$a2bb8420$e8328c60$@soto@...1413...>
Subject: Re: [Openvpn-devel] Variable common_name can be blank in
 client-connect script
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
To: Carlos Soto <carlos.soto@...1413...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/10/10 20:56, Carlos Soto wrote:
> Author: Carlos Soto <carlos.soto at terra.es <mailto:carlos.soto@...1413...>>
> 
> Variable common_name can be blank in client-connect script
> 
> If a server is configured with auth-user-pass-optional and
> username-as-common-name it is possible that the auth-user-pass-verify
> script will validate a connection with no username as it is optional. It
> that case the common_name becames blank and client-connect script may
> fail because it does not have a value for the common name. I think that
> the common name should never be blank so in cases where the username is
> blank and the username-as-common-name option is enabled, the common_name
> should keep its original value.
> 
> diff --git a/ssl.c b/ssl.c
> index a1268ac..381ab07 100644
> --- a/ssl.c
> +++ b/ssl.c
> 
> @@ -3718,7 +3718,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
>           if (man_def_auth != KMDA_UNDEF)
>             ks->auth_deferred = true;
>  #endif
> -         if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
> +         if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
> && (strlen (up->username)))
>             set_common_name (session, up->username);
>  #ifdef ENABLE_DEF_AUTH
>           msg (D_HANDSHAKE, "TLS: Username/Password authentication %s
> for username '%s' %s",
>  

Sorry for not having responded earlier, but I'm going through the patch
queue these days.

I'm also giving this patch a NAK.

This is a critical change of current behaviour and might lead to
misunderstandings when configuring such a setup you describe.

We can however discuss if we can accept such a behaviour this patch will
introduce by doing it configurable as a flag to
- --username-as-common-name.  But I really struggle to see this being an
important feature OpenVPN should have.  As Gert already said, if the
username is blank, it's blank.  Using --username-as-common-name, I would
also expect CN to be blank.

If CN is sometimes username and sometimes CN, that's going to be a mess
to handle properly for most setups.  And in those cases where this might
be needed, it might really be that --username-as-common-name is not the
right option to use.  It might be writing a separate --plugin to handle
such situation properly to your needs is a better approach.

Such a plug-in should be able to grant access in those cases where you
have a mixture of people not sending usernames and you want to
authenticate against the client certificate CN instead.  With such a
plug-in you should be able to skip the usage of
- --username-as-common-name.   I believe this would be a much cleaner
approach, as it's the authentication phase which decides if this
situation with a blank username is correct or not.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzf0GAACgkQDC186MBRfrp42ACgjd2fKwrZEiq9X+o2fmtfLEP0
xGcAni10TG8Afk7I95pg7XJKKJ0Ylq3C
=hewl
-----END PGP SIGNATURE-----

