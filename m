Message-ID: <52598DAD.7040603@...1832...>
Date: Sat, 12 Oct 2013 19:58:05 +0200
From: Max Muster <Max.Muster@...1832...>
MIME-Version: 1.0
References: <go9r6cg1wcfh4lpwb9664gdd.1381086064578@...1753...>	<5252FB07.3070309@...1832...>
	<0MUUWN-1VMPIC2zpb-00REku@...1825...>
In-Reply-To: <0MUUWN-1VMPIC2zpb-00REku@...1825...>
Subject: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

Yes, your right, there is this one "debugging" line left
(it was just to be sure, the setting of  auth_user_pass_file to "stdin"
is the first thing done).




-------- Original-Nachricht --------
Betreff: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
Von: Davide Brini <dave_br@...1278...>
An: Max Muster <Max.Muster@...1832...>
Kopie (CC): openvpn-devel@lists.sourceforge.net
Datum: Sa 12 Okt 2013 18:25:56 CEST
> So here we go, your points are all valid. The patch you attached has a
> spurious line, or maybe it's just my client that doesn't show it correctly,
> I see
>
> @@ -5835,7 +5872,12 @@
>        VERIFY_PERMISSION (OPT_P_GENERAL);
>        if (p[1])
>  	{
> -	  options->auth_user_pass_file = p[1];
> +          options->auth_user_pass_file = p[1];
> +          if (streq (p[1], INLINE_FILE_TAG) && p[2])
> +            { msg (M_WARN, "options.c \n  !!!SETTING !!! \n_ +5930,12 @@ add_optio"); 
> +              options->auth_user_pass_file = "stdin";
> +              options->auth_user_pass_file_inline = p[2];
> +            }
>  	}
>
> I don't think the !!!SETTING !!! line should be there, so I'm going
> to send a revised patch in a few minutes which essentially includes all your
> suggestions (and is against master, I'm not sure yours was against master).
> I'm also citing your contribution in the new text, which I think is
> deserved.
>
> Thanks also for showing that there is at least another person besides me
> interested in this functionality!
>


