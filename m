MIME-Version: 1.0
References: <20220812130657.29899-1-a@...2181...>
 <20220812130657.29899-2-a@...2181...>
In-Reply-To: <20220812130657.29899-2-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 12 Aug 2022 18:34:42 +0300
Message-ID: <CAGyAFMWwViz-L95B+wweuGZKOxXV0qb8fPW4wDps=_sBfHnEzw@...278...>
Content-Type: multipart/alternative; boundary="000000000000039adf05e60d0637"
Subject: Re: [Openvpn-devel] [PATCH v100 01/10] do_open_tun: restyle "can
 preserve TUN" check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000039adf05e60d0637
Content-Type: text/plain; charset="UTF-8"

Stared at the code and slightly tested on Windows.

Functionality hasn't changed and code is now easier to read.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 12. elok. 2022 klo 16.08 Antonio Quartulli (a@...2181...) kirjoitti:

> The current condition checking if the TUN interface was preserved is
> dependant on the platform being Android or not. This makes the code
> reasonably ugly, especially because uncrustify can't indent properly.
>
> On top of that, we will require an extra condition only for windows+DCO,
> which will make the check even uglier.
>
> For this reason, factor out the check in a separate function which can
> keep the ifdefs craziness well hidden, while do_open_tun becomes
> (a bit) cleaner.
>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/init.c | 282 +++++++++++++++++++++++----------------------
>  1 file changed, 144 insertions(+), 138 deletions(-)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 82a57bef..4d4c7192 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1716,161 +1716,120 @@ do_init_tun(struct context *c)
>   * Open tun/tap device, ifconfig, call up script, etc.
>   */
>
> +
> +static bool
> +can_preserve_tun(struct tuntap *tt)
> +{
> +#ifdef TARGET_ANDROID
> +    return false;
> +#else
> +    return tt;
> +#endif
> +}
> +
>  static bool
>  do_open_tun(struct context *c)
>  {
>      struct gc_arena gc = gc_new();
>      bool ret = false;
>
> -#ifndef TARGET_ANDROID
> -    if (!c->c1.tuntap)
> +    if (!can_preserve_tun(c->c1.tuntap))
>      {
> -#endif
> -
>  #ifdef TARGET_ANDROID
> -    /* If we emulate persist-tun on android we still have to open a new
> tun and
> -     * then close the old */
> -    int oldtunfd = -1;
> -    if (c->c1.tuntap)
> -    {
> -        oldtunfd = c->c1.tuntap->fd;
> -        free(c->c1.tuntap);
> -        c->c1.tuntap = NULL;
> -        c->c1.tuntap_owned = false;
> -    }
> +        /* If we emulate persist-tun on android we still have to open a
> new tun and
> +         * then close the old */
> +        int oldtunfd = -1;
> +        if (c->c1.tuntap)
> +        {
> +            oldtunfd = c->c1.tuntap->fd;
> +            free(c->c1.tuntap);
> +            c->c1.tuntap = NULL;
> +            c->c1.tuntap_owned = false;
> +        }
>  #endif
>
> -    /* initialize (but do not open) tun/tap object */
> -    do_init_tun(c);
> +        /* initialize (but do not open) tun/tap object */
> +        do_init_tun(c);
>
> -    /* inherit the dco context from the tuntap object */
> -    if (c->c2.tls_multi)
> -    {
> -        c->c2.tls_multi->dco = &c->c1.tuntap->dco;
> -    }
> +        /* inherit the dco context from the tuntap object */
> +        if (c->c2.tls_multi)
> +        {
> +            c->c2.tls_multi->dco = &c->c1.tuntap->dco;
> +        }
>
>  #ifdef _WIN32
> -    /* store (hide) interactive service handle in tuntap_options */
> -    c->c1.tuntap->options.msg_channel = c->options.msg_channel;
> -    msg(D_ROUTE, "interactive service msg_channel=%" PRIu64, (unsigned
> long long) c->options.msg_channel);
> +        /* store (hide) interactive service handle in tuntap_options */
> +        c->c1.tuntap->options.msg_channel = c->options.msg_channel;
> +        msg(D_ROUTE, "interactive service msg_channel=%" PRIu64,
> (unsigned long long) c->options.msg_channel);
>  #endif
>
> -    /* allocate route list structure */
> -    do_alloc_route_list(c);
> +        /* allocate route list structure */
> +        do_alloc_route_list(c);
>
> -    /* parse and resolve the route option list */
> -    ASSERT(c->c2.link_socket);
> -    if (c->options.routes && c->c1.route_list)
> -    {
> -        do_init_route_list(&c->options, c->c1.route_list,
> -                           &c->c2.link_socket->info, c->c2.es,
> &c->net_ctx);
> -    }
> -    if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
> -    {
> -        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
> -                                &c->c2.link_socket->info, c->c2.es,
> -                                &c->net_ctx);
> -    }
> +        /* parse and resolve the route option list */
> +        ASSERT(c->c2.link_socket);
> +        if (c->options.routes && c->c1.route_list)
> +        {
> +            do_init_route_list(&c->options, c->c1.route_list,
> +                               &c->c2.link_socket->info, c->c2.es,
> &c->net_ctx);
> +        }
> +        if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
> +        {
> +            do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
> +                                    &c->c2.link_socket->info, c->c2.es,
> +                                    &c->net_ctx);
> +        }
>
> -    /* do ifconfig */
> -    if (!c->options.ifconfig_noexec
> -        && ifconfig_order() == IFCONFIG_BEFORE_TUN_OPEN)
> -    {
> -        /* guess actual tun/tap unit number that will be returned
> -         * by open_tun */
> -        const char *guess = guess_tuntap_dev(c->options.dev,
> -                                             c->options.dev_type,
> -                                             c->options.dev_node,
> -                                             &gc);
> -        do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
> -                    &c->net_ctx);
> -    }
> +        /* do ifconfig */
> +        if (!c->options.ifconfig_noexec
> +            && ifconfig_order() == IFCONFIG_BEFORE_TUN_OPEN)
> +        {
> +            /* guess actual tun/tap unit number that will be returned
> +             * by open_tun */
> +            const char *guess = guess_tuntap_dev(c->options.dev,
> +                                                 c->options.dev_type,
> +                                                 c->options.dev_node,
> +                                                 &gc);
> +            do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->
> c2.es,
> +                        &c->net_ctx);
> +        }
>
> -    /* possibly add routes */
> -    if (route_order() == ROUTE_BEFORE_TUN)
> -    {
> -        /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored
> */
> -        do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
> -                 c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
> -    }
> +        /* possibly add routes */
> +        if (route_order() == ROUTE_BEFORE_TUN)
> +        {
> +            /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be
> ignored */
> +            do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
> +                     c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
> +        }
>  #ifdef TARGET_ANDROID
> -    /* Store the old fd inside the fd so open_tun can use it */
> -    c->c1.tuntap->fd = oldtunfd;
> -#endif
> -    if (dco_enabled(&c->options))
> -    {
> -        ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
> -    }
> -
> -    /* open the tun device */
> -    open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
> -             c->c1.tuntap, &c->net_ctx);
> -
> -    /* set the hardware address */
> -    if (c->options.lladdr)
> -    {
> -        set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name,
> c->options.lladdr,
> -                   c->c2.es);
> -    }
> -
> -    /* do ifconfig */
> -    if (!c->options.ifconfig_noexec
> -        && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
> -    {
> -        do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
> -                    c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
> -    }
> -
> -    /* run the up script */
> -    run_up_down(c->options.up_script,
> -                c->plugins,
> -                OPENVPN_PLUGIN_UP,
> -                c->c1.tuntap->actual_name,
> -#ifdef _WIN32
> -                c->c1.tuntap->adapter_index,
> +        /* Store the old fd inside the fd so open_tun can use it */
> +        c->c1.tuntap->fd = oldtunfd;
>  #endif
> -                dev_type_string(c->options.dev, c->options.dev_type),
> -                c->c2.frame.tun_mtu,
> -                print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF,
> &gc),
> -                print_in_addr_t(c->c1.tuntap->remote_netmask,
> IA_EMPTY_IF_UNDEF, &gc),
> -                "init",
> -                NULL,
> -                "up",
> -                c->c2.es);
> -
> -#if defined(_WIN32)
> -    if (c->options.block_outside_dns)
> -    {
> -        dmsg(D_LOW, "Blocking outside DNS");
> -        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index,
> c->options.msg_channel))
> +        if (dco_enabled(&c->options))
>          {
> -            msg(M_FATAL, "Blocking DNS failed!");
> +            ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
>          }
> -    }
> -#endif
>
> -    /* possibly add routes */
> -    if ((route_order() == ROUTE_AFTER_TUN) &&
> (!c->options.route_delay_defined))
> -    {
> -        do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
> -                 c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
> -    }
> +        /* open the tun device */
> +        open_tun(c->options.dev, c->options.dev_type,
> c->options.dev_node,
> +                 c->c1.tuntap, &c->net_ctx);
>
> -    ret = true;
> -    static_context = c;
> -#ifndef TARGET_ANDROID
> -}
> -else
> -{
> -    msg(M_INFO, "Preserving previous TUN/TAP instance: %s",
> -        c->c1.tuntap->actual_name);
> +        /* set the hardware address */
> +        if (c->options.lladdr)
> +        {
> +            set_lladdr(&c->net_ctx, c->c1.tuntap->actual_name,
> c->options.lladdr,
> +                       c->c2.es);
> +        }
>
> -    /* explicitly set the ifconfig_* env vars */
> -    do_ifconfig_setenv(c->c1.tuntap, c->c2.es);
> +        /* do ifconfig */
> +        if (!c->options.ifconfig_noexec
> +            && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
> +        {
> +            do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
> +                        c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
> +        }
>
> -    /* run the up script if user specified --up-restart */
> -    if (c->options.up_restart)
> -    {
> +        /* run the up script */
>          run_up_down(c->options.up_script,
>                      c->plugins,
>                      OPENVPN_PLUGIN_UP,
> @@ -1882,24 +1841,71 @@ else
>                      c->c2.frame.tun_mtu,
>                      print_in_addr_t(c->c1.tuntap->local,
> IA_EMPTY_IF_UNDEF, &gc),
>                      print_in_addr_t(c->c1.tuntap->remote_netmask,
> IA_EMPTY_IF_UNDEF, &gc),
> -                    "restart",
> +                    "init",
>                      NULL,
>                      "up",
>                      c->c2.es);
> -    }
> +
>  #if defined(_WIN32)
> -    if (c->options.block_outside_dns)
> -    {
> -        dmsg(D_LOW, "Blocking outside DNS");
> -        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index,
> c->options.msg_channel))
> +        if (c->options.block_outside_dns)
> +        {
> +            dmsg(D_LOW, "Blocking outside DNS");
> +            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index,
> c->options.msg_channel))
> +            {
> +                msg(M_FATAL, "Blocking DNS failed!");
> +            }
> +        }
> +#endif
> +
> +        /* possibly add routes */
> +        if ((route_order() == ROUTE_AFTER_TUN) &&
> (!c->options.route_delay_defined))
>          {
> -            msg(M_FATAL, "Blocking DNS failed!");
> +            do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
> +                     c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
>          }
> +
> +        ret = true;
> +        static_context = c;
>      }
> +    else
> +    {
> +        msg(M_INFO, "Preserving previous TUN/TAP instance: %s",
> +            c->c1.tuntap->actual_name);
> +
> +        /* explicitly set the ifconfig_* env vars */
> +        do_ifconfig_setenv(c->c1.tuntap, c->c2.es);
> +
> +        /* run the up script if user specified --up-restart */
> +        if (c->options.up_restart)
> +        {
> +            run_up_down(c->options.up_script,
> +                        c->plugins,
> +                        OPENVPN_PLUGIN_UP,
> +                        c->c1.tuntap->actual_name,
> +#ifdef _WIN32
> +                        c->c1.tuntap->adapter_index,
> +#endif
> +                        dev_type_string(c->options.dev,
> c->options.dev_type),
> +                        c->c2.frame.tun_mtu,
> +                        print_in_addr_t(c->c1.tuntap->local,
> IA_EMPTY_IF_UNDEF, &gc),
> +                        print_in_addr_t(c->c1.tuntap->remote_netmask,
> IA_EMPTY_IF_UNDEF, &gc),
> +                        "restart",
> +                        NULL,
> +                        "up",
> +                        c->c2.es);
> +        }
> +#if defined(_WIN32)
> +        if (c->options.block_outside_dns)
> +        {
> +            dmsg(D_LOW, "Blocking outside DNS");
> +            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index,
> c->options.msg_channel))
> +            {
> +                msg(M_FATAL, "Blocking DNS failed!");
> +            }
> +        }
>  #endif
>
> -}
> -#endif /* ifndef TARGET_ANDROID */
> +    }
>      gc_free(&gc);
>      return ret;
>  }
> --
> 2.35.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000039adf05e60d0637
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Stared at the code and slightly tested on Windows.<div><br=
></div><div>Functionality hasn&#39;t changed and code is now easier to read=
.</div><div><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lst=
ipakov@...277...">lstipakov@...277...</a>&gt;</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">pe 12. elok. 2022 klo 16=
.08 Antonio Quartulli (<a href=3D"mailto:a@...2181...">a@...2181...</a>) ki=
rjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The cur=
rent condition checking if the TUN interface was preserved is<br>
dependant on the platform being Android or not. This makes the code<br>
reasonably ugly, especially because uncrustify can&#39;t indent properly.<b=
r>
<br>
On top of that, we will require an extra condition only for windows+DCO,<br>
which will make the check even uglier.<br>
<br>
For this reason, factor out the check in a separate function which can<br>
keep the ifdefs craziness well hidden, while do_open_tun becomes<br>
(a bit) cleaner.<br>
<br>
Signed-off-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181..." target=
=3D"_blank">a@...2181...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/init.c | 282 +++++++++++++++++++++++---------------------=
-<br>
=C2=A01 file changed, 144 insertions(+), 138 deletions(-)<br>
<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
index 82a57bef..4d4c7192 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -1716,161 +1716,120 @@ do_init_tun(struct context *c)<br>
=C2=A0 * Open tun/tap device, ifconfig, call up script, etc.<br>
=C2=A0 */<br>
<br>
+<br>
+static bool<br>
+can_preserve_tun(struct tuntap *tt)<br>
+{<br>
+#ifdef TARGET_ANDROID<br>
+=C2=A0 =C2=A0 return false;<br>
+#else<br>
+=C2=A0 =C2=A0 return tt;<br>
+#endif<br>
+}<br>
+<br>
=C2=A0static bool<br>
=C2=A0do_open_tun(struct context *c)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
=C2=A0 =C2=A0 =C2=A0bool ret =3D false;<br>
<br>
-#ifndef TARGET_ANDROID<br>
-=C2=A0 =C2=A0 if (!c-&gt;c1.tuntap)<br>
+=C2=A0 =C2=A0 if (!can_preserve_tun(c-&gt;c1.tuntap))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-#endif<br>
-<br>
=C2=A0#ifdef TARGET_ANDROID<br>
-=C2=A0 =C2=A0 /* If we emulate persist-tun on android we still have to ope=
n a new tun and<br>
-=C2=A0 =C2=A0 =C2=A0* then close the old */<br>
-=C2=A0 =C2=A0 int oldtunfd =3D -1;<br>
-=C2=A0 =C2=A0 if (c-&gt;c1.tuntap)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 oldtunfd =3D c-&gt;c1.tuntap-&gt;fd;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(c-&gt;c1.tuntap);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap_owned =3D false;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If we emulate persist-tun on android we sti=
ll have to open a new tun and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* then close the old */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int oldtunfd =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;c1.tuntap)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oldtunfd =3D c-&gt;c1.tuntap-&gt=
;fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(c-&gt;c1.tuntap);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap_owned =3D false;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 /* initialize (but do not open) tun/tap object */<br>
-=C2=A0 =C2=A0 do_init_tun(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* initialize (but do not open) tun/tap object=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_init_tun(c);<br>
<br>
-=C2=A0 =C2=A0 /* inherit the dco context from the tuntap object */<br>
-=C2=A0 =C2=A0 if (c-&gt;c2.tls_multi)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c2.tls_multi-&gt;dco =3D &amp;c-&gt;c1.t=
untap-&gt;dco;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* inherit the dco context from the tuntap obj=
ect */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;c2.tls_multi)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c2.tls_multi-&gt;dco =3D &=
amp;c-&gt;c1.tuntap-&gt;dco;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0#ifdef _WIN32<br>
-=C2=A0 =C2=A0 /* store (hide) interactive service handle in tuntap_options=
 */<br>
-=C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;options.msg_channel =3D c-&gt;options.ms=
g_channel;<br>
-=C2=A0 =C2=A0 msg(D_ROUTE, &quot;interactive service msg_channel=3D%&quot;=
 PRIu64, (unsigned long long) c-&gt;options.msg_channel);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* store (hide) interactive service handle in =
tuntap_options */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;options.msg_channel =3D c-=
&gt;options.msg_channel;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_ROUTE, &quot;interactive service msg_cha=
nnel=3D%&quot; PRIu64, (unsigned long long) c-&gt;options.msg_channel);<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 /* allocate route list structure */<br>
-=C2=A0 =C2=A0 do_alloc_route_list(c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* allocate route list structure */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_alloc_route_list(c);<br>
<br>
-=C2=A0 =C2=A0 /* parse and resolve the route option list */<br>
-=C2=A0 =C2=A0 ASSERT(c-&gt;c2.link_socket);<br>
-=C2=A0 =C2=A0 if (c-&gt;options.routes &amp;&amp; c-&gt;c1.route_list)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_init_route_list(&amp;c-&gt;options, c-&gt;c=
1.route_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;c-&gt;c2.link_socket-&gt;info, c-&gt;<a href=
=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a>, &amp;c-&g=
t;net_ctx);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (c-&gt;options.routes_ipv6 &amp;&amp; c-&gt;c1.route_ipv6=
_list)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_init_route_ipv6_list(&amp;c-&gt;options, c-=
&gt;c1.route_ipv6_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;c-&gt;c2.link_socket-&gt;info, =
c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</=
a>,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;c-&gt;net_ctx);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* parse and resolve the route option list */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(c-&gt;c2.link_socket);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.routes &amp;&amp; c-&gt;c1.r=
oute_list)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_init_route_list(&amp;c-&gt;op=
tions, c-&gt;c1.route_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;c-&gt;c2.link_socket-&gt;info, c=
-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a=
>, &amp;c-&gt;net_ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.routes_ipv6 &amp;&amp; c-&gt=
;c1.route_ipv6_list)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_init_route_ipv6_list(&amp;c-&=
gt;options, c-&gt;c1.route_ipv6_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;c-&gt;c2.link_soc=
ket-&gt;info, c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_=
blank">c2.es</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;c-&gt;net_ctx);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 /* do ifconfig */<br>
-=C2=A0 =C2=A0 if (!c-&gt;options.ifconfig_noexec<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; ifconfig_order() =3D=3D IFCONFIG_BE=
FORE_TUN_OPEN)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* guess actual tun/tap unit number that will =
be returned<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* by open_tun */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *guess =3D guess_tuntap_dev(c-&gt;<=
a href=3D"http://options.dev" rel=3D"noreferrer" target=3D"_blank">options.=
dev</a>,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0c-&gt;options.dev_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0c-&gt;options.dev_node,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;gc);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_ifconfig(c-&gt;c1.tuntap, guess, c-&gt;c2.f=
rame.tun_mtu, c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_=
blank">c2.es</a>,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;c-&gt;net_ctx);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do ifconfig */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;options.ifconfig_noexec<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; ifconfig_order() =3D=
=3D IFCONFIG_BEFORE_TUN_OPEN)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* guess actual tun/tap unit num=
ber that will be returned<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* by open_tun */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *guess =3D guess_tunt=
ap_dev(c-&gt;<a href=3D"http://options.dev" rel=3D"noreferrer" target=3D"_b=
lank">options.dev</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;options.dev_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;options.dev_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_ifconfig(c-&gt;c1.tuntap, gue=
ss, c-&gt;c2.frame.tun_mtu, c-&gt;<a href=3D"http://c2.es" rel=3D"noreferre=
r" target=3D"_blank">c2.es</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;c-&gt;net_ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 /* possibly add routes */<br>
-=C2=A0 =C2=A0 if (route_order() =3D=3D ROUTE_BEFORE_TUN)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ignore route_delay, would cause ROUTE_BEFOR=
E_TUN to be ignored */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_route(&amp;c-&gt;options, c-&gt;c1.route_li=
st, c-&gt;c1.route_ipv6_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c1.tun=
tap, c-&gt;plugins, c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" targe=
t=3D"_blank">c2.es</a>, &amp;c-&gt;net_ctx);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* possibly add routes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (route_order() =3D=3D ROUTE_BEFORE_TUN)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ignore route_delay, would cau=
se ROUTE_BEFORE_TUN to be ignored */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_route(&amp;c-&gt;options, c-&=
gt;c1.route_list, c-&gt;c1.route_ipv6_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;<a href=3D"http://c2.es" rel=3D"no=
referrer" target=3D"_blank">c2.es</a>, &amp;c-&gt;net_ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#ifdef TARGET_ANDROID<br>
-=C2=A0 =C2=A0 /* Store the old fd inside the fd so open_tun can use it */<=
br>
-=C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;fd =3D oldtunfd;<br>
-#endif<br>
-=C2=A0 =C2=A0 if (dco_enabled(&amp;c-&gt;options))<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap=
-&gt;dco);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* open the tun device */<br>
-=C2=A0 =C2=A0 open_tun(c-&gt;<a href=3D"http://options.dev" rel=3D"norefer=
rer" target=3D"_blank">options.dev</a>, c-&gt;options.dev_type, c-&gt;optio=
ns.dev_node,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c1.tuntap, &amp;c-&g=
t;net_ctx);<br>
-<br>
-=C2=A0 =C2=A0 /* set the hardware address */<br>
-=C2=A0 =C2=A0 if (c-&gt;options.lladdr)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_lladdr(&amp;c-&gt;net_ctx, c-&gt;c1.tuntap=
-&gt;actual_name, c-&gt;options.lladdr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt=
;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a>);<=
br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* do ifconfig */<br>
-=C2=A0 =C2=A0 if (!c-&gt;options.ifconfig_noexec<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; ifconfig_order() =3D=3D IFCONFIG_AF=
TER_TUN_OPEN)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&=
gt;actual_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&g=
t;c2.frame.tun_mtu, c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" targe=
t=3D"_blank">c2.es</a>, &amp;c-&gt;net_ctx);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* run the up script */<br>
-=C2=A0 =C2=A0 run_up_down(c-&gt;options.up_script,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;plugins,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPENVPN_PLUGIN_UP,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&g=
t;actual_name,<br>
-#ifdef _WIN32<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&g=
t;adapter_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Store the old fd inside the fd so open_tun =
can use it */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;fd =3D oldtunfd;<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_type_string(c-=
&gt;<a href=3D"http://options.dev" rel=3D"noreferrer" target=3D"_blank">opt=
ions.dev</a>, c-&gt;options.dev_type),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c2.frame.tun=
_mtu,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(c-=
&gt;c1.tuntap-&gt;local, IA_EMPTY_IF_UNDEF, &amp;gc),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in_addr_t(c-=
&gt;c1.tuntap-&gt;remote_netmask, IA_EMPTY_IF_UNDEF, &amp;gc),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;init&quot;,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;up&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;<a href=3D"h=
ttp://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a>);<br>
-<br>
-#if defined(_WIN32)<br>
-=C2=A0 =C2=A0 if (c-&gt;options.block_outside_dns)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_LOW, &quot;Blocking outside DNS&quot;);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_block_dns(c-&gt;c1.tuntap-&gt;ada=
pter_index, c-&gt;options.msg_channel))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dco_enabled(&amp;c-&gt;options))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Blocking DNS =
failed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ovpn_dco_init(c-&gt;mode, &amp;c=
-&gt;c1.tuntap-&gt;dco);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 }<br>
-#endif<br>
<br>
-=C2=A0 =C2=A0 /* possibly add routes */<br>
-=C2=A0 =C2=A0 if ((route_order() =3D=3D ROUTE_AFTER_TUN) &amp;&amp; (!c-&g=
t;options.route_delay_defined))<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_route(&amp;c-&gt;options, c-&gt;c1.route_li=
st, c-&gt;c1.route_ipv6_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c1.tun=
tap, c-&gt;plugins, c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" targe=
t=3D"_blank">c2.es</a>, &amp;c-&gt;net_ctx);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* open the tun device */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 open_tun(c-&gt;<a href=3D"http://options.dev" =
rel=3D"noreferrer" target=3D"_blank">options.dev</a>, c-&gt;options.dev_typ=
e, c-&gt;options.dev_node,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c1.tun=
tap, &amp;c-&gt;net_ctx);<br>
<br>
-=C2=A0 =C2=A0 ret =3D true;<br>
-=C2=A0 =C2=A0 static_context =3D c;<br>
-#ifndef TARGET_ANDROID<br>
-}<br>
-else<br>
-{<br>
-=C2=A0 =C2=A0 msg(M_INFO, &quot;Preserving previous TUN/TAP instance: %s&q=
uot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;actual_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set the hardware address */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.lladdr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_lladdr(&amp;c-&gt;net_ctx, c=
-&gt;c1.tuntap-&gt;actual_name, c-&gt;options.lladdr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blan=
k">c2.es</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 /* explicitly set the ifconfig_* env vars */<br>
-=C2=A0 =C2=A0 do_ifconfig_setenv(c-&gt;c1.tuntap, c-&gt;<a href=3D"http://=
c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do ifconfig */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;options.ifconfig_noexec<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; ifconfig_order() =3D=
=3D IFCONFIG_AFTER_TUN_OPEN)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_ifconfig(c-&gt;c1.tuntap, c-&=
gt;c1.tuntap-&gt;actual_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c-&gt;c2.frame.tun_mtu, c-&gt;<a href=3D"http://c2.es" rel=3D"no=
referrer" target=3D"_blank">c2.es</a>, &amp;c-&gt;net_ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 /* run the up script if user specified --up-restart */<br>
-=C2=A0 =C2=A0 if (c-&gt;options.up_restart)<br>
-=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* run the up script */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run_up_down(c-&gt;options.up_script,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;plugins,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0OPENVPN_PLUGIN_UP,<br>
@@ -1882,24 +1841,71 @@ else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;c2.frame.tun_mtu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0print_in_addr_t(c-&gt;c1.tuntap-&gt;local, IA_EMPTY_IF_UNDEF, &amp;gc),<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0print_in_addr_t(c-&gt;c1.tuntap-&gt;remote_netmask, IA_EMPTY_IF_UNDEF, &=
amp;gc),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;restart&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;init&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;up&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.e=
s</a>);<br>
-=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0#if defined(_WIN32)<br>
-=C2=A0 =C2=A0 if (c-&gt;options.block_outside_dns)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_LOW, &quot;Blocking outside DNS&quot;);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_block_dns(c-&gt;c1.tuntap-&gt;ada=
pter_index, c-&gt;options.msg_channel))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.block_outside_dns)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_LOW, &quot;Blocking outsi=
de DNS&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_block_dns(c-&gt;c1.=
tuntap-&gt;adapter_index, c-&gt;options.msg_channel))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot=
;Blocking DNS failed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* possibly add routes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((route_order() =3D=3D ROUTE_AFTER_TUN) &am=
p;&amp; (!c-&gt;options.route_delay_defined))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Blocking DNS =
failed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_route(&amp;c-&gt;options, c-&=
gt;c1.route_list, c-&gt;c1.route_ipv6_list,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;<a href=3D"http://c2.es" rel=3D"no=
referrer" target=3D"_blank">c2.es</a>, &amp;c-&gt;net_ctx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 static_context =3D c;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;Preserving previous TUN/TAP =
instance: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;c1.tuntap-&gt;actual_name)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* explicitly set the ifconfig_* env vars */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_ifconfig_setenv(c-&gt;c1.tuntap, c-&gt;<a h=
ref=3D"http://c2.es" rel=3D"noreferrer" target=3D"_blank">c2.es</a>);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* run the up script if user specified --up-re=
start */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.up_restart)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_up_down(c-&gt;options.up_scr=
ipt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c-&gt;plugins,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OPENVPN_PLUGIN_UP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c-&gt;c1.tuntap-&gt;actual_name,<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c-&gt;c1.tuntap-&gt;adapter_index,<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_type_string(c-&gt;<a href=3D"http://options.dev" rel=3D"nore=
ferrer" target=3D"_blank">options.dev</a>, c-&gt;options.dev_type),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c-&gt;c2.frame.tun_mtu,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 print_in_addr_t(c-&gt;c1.tuntap-&gt;local, IA_EMPTY_IF_UNDEF, &a=
mp;gc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 print_in_addr_t(c-&gt;c1.tuntap-&gt;remote_netmask, IA_EMPTY_IF_=
UNDEF, &amp;gc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;restart&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;up&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" target=3D"_bla=
nk">c2.es</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#if defined(_WIN32)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c-&gt;options.block_outside_dns)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmsg(D_LOW, &quot;Blocking outsi=
de DNS&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!win_wfp_block_dns(c-&gt;c1.=
tuntap-&gt;adapter_index, c-&gt;options.msg_channel))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot=
;Blocking DNS failed!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
<br>
-}<br>
-#endif /* ifndef TARGET_ANDROID */<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
-- <br>
2.35.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000039adf05e60d0637--

