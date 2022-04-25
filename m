Date: Mon, 25 Apr 2022 15:08:55 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1819498256.337104.1650892135929@...2642...>
In-Reply-To: <20220425122709.4148015-1-arne@...1227...>
References: <20220422134038.3801239-4-arne@...1227...>
 <20220425122709.4148015-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Move pre decrypt lite check to its
 own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Arne Schwabe <arne@...1227...> hat am 25.04.2022 14:27 geschrieben:
[...]
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index 4fbe3c1a3..780ca171d 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -39,6 +39,17 @@
>  #include <sys/inotify.h>
>  #endif
>  
> +static bool
> +do_pre_decrypt_check(struct multi_context *m)
> +{
> +    ASSERT(m->top.c2.tls_auth_standalone);
> +    if (!tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
> +    {
> +        return false;
> +    }
> +    return true;

You could replace four lines with one:

return tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf));

But that might not make sense due to changes in later patches? Haven't checked.

Regards,
--
Frank Lichtenheld

