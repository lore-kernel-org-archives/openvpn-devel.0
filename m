Date: Wed, 30 Jan 2008 05:33:36 +0100
From: Maximilian Wilhelm <max@...1047...>
Message-ID: <20080130043336.GH31211@...1048...>
References: <20071011233158.GC1416@...1048...>
MIME-Version: 1.0
In-Reply-To: <20071011233158.GC1416@...1048...>
Subject: Re: [Openvpn-devel] [Patch] Fix Null-Pointer bug in init_ssl() when
	no '--ca' is set but '--capath'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Am Friday, den 12 October hub Maximilian Wilhelm folgendes in die Tasten:

Hi!

What about this patch?
I think it should be included in the next -rc as it fixes a crash.


> This little patch fixes a silly bug in init_ssl() in ssl.c where
> options->ca_file is accessed without prior check if it's not NULL.

> The bug was introduced in revision 784.


> diff --git a/ssl.c b/ssl.c
> index 85e9c6f..868edc2 100644
> --- a/ssl.c
> +++ b/ssl.c
> @@ -1228,7 +1228,7 @@ init_ssl (const struct options *options)
>        int status;
>  
>  #if ENABLE_INLINE_FILES
> -      if (!strcmp (options->ca_file, INLINE_FILE_TAG) && options->ca_file_inline)
> +      if (options->ca_file && !strcmp (options->ca_file, INLINE_FILE_TAG) && options->ca_file_inline)
>  	{
>  	  status = use_inline_load_verify_locations (ctx, options->ca_file_inline);
>  	}

Ciao
Max
-- 
	Follow the white penguin.

