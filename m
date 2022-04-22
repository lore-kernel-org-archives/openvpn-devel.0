Date: Fri, 22 Apr 2022 17:52:11 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1632774663.198868.1650642731983@...2642...>
In-Reply-To: <20220422134038.3801239-4-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422134038.3801239-4-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 03/28] Move pre decrypt lite check to
 its own function
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



> Arne Schwabe <arne@...1227...> hat am 22.04.2022 15:40 geschrieben:
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index 4fbe3c1a3..910268333 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -39,6 +39,20 @@
>  #include <sys/inotify.h>
>  #endif
>  
> +static bool
> +do_pre_decrypt_check(struct multi_context *m)
> +{
> +    if (!m->top.c2.tls_auth_standalone)
> +    {
> +        return false;
> +    }
> +    if (!tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
> +    {
> +        return false;
> +    }
> +    return true;

Shouldn't this be
if (!m->top.c2.tls_auth_standalone)
{
   return true;
}
if (tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
{
   return true;
}
return false;

Your patch seems to mangle the logic in several different ways.

> +}
> +
>  /*
>   * Get a client instance based on real address.  If
>   * the instance doesn't exist, create it while
> @@ -95,8 +109,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
>          }
>          if (!mi)
>          {
> -            if (!m->top.c2.tls_auth_standalone
> -                || tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
> +            if (do_pre_decrypt_check(m))
>              {
>                  if (frequency_limit_event_allowed(m->new_connection_limiter))
>                  {

--
Frank Lichtenheld

