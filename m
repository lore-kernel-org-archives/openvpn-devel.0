Date: Sat, 30 Apr 2022 18:12:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ym1f+Jmvfj28Or6s@...1296...>
References: <20220402070902.30282-5-a@...2181...>
 <20220411133528.27279-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HThcY/IcZcaX6but"
Content-Disposition: inline
In-Reply-To: <20220411133528.27279-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] ovpn-dco: introduce linux
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--HThcY/IcZcaX6but
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 11, 2022 at 03:35:28PM +0200, Antonio Quartulli wrote:
> Implement the data-channel offloading using the ovpn-dco kernel
> module. See README.dco.md for more details.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---

I've browsed through the code a bit to see if I can spot "unsafe"
constructs (memory, pointers), or anything else noteworthy - since
this is not the actual current code, it's hard to ACK.

We should move forward with "get this merged, and if the good folks
testing this find new breakages, make this extra (smaller) patches=20
on top, with proper credit"...

That said...  a few things, in addition to the IN6_IS_ADDR_V4MAPPED() thing:


> +int
> +dco_p2p_add_new_peer(struct context *c)
> +{
> +    if (!dco_enabled(&c->options))
> +    {
> +        return 0;
> +    }
[..]
> +
> +    if (dco_enabled(&c->options) && !c->c2.link_socket->info.dco_install=
ed)
> +    {

This second "dco_enabled()" check looks very unnecessary...

Not sure about the "if (!dco_installed)" check here - this seems to guard
against double installment of this socket, but from the code flow I'm
not sure how this could happen?

> +void
> +dco_remove_peer(struct context *c)
> +{
> +    if (!dco_enabled(&c->options))
> +    {
> +        return;
> +    }
> +    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_add=
ed)
> +    {
> +        c->c2.tls_multi->dco_peer_added =3D false;
> +        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id);
> +    }

"traditional code ordering" would have the " =3D false" after the
actual dco_del_peer() call... but that's of only aesthetic significance.

> +void
> +dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
> +{
> +    msg(D_DCO_DEBUG, "%s: peer_id=3D%d", __func__, multi->peer_id);
[..]
> +
> +    struct key_state *primary =3D tls_select_encryption_key(multi);
> +    ASSERT(!primary || primary->dco_status !=3D DCO_NOT_INSTALLED);
> +
> +    /* no primary key available -> no usable key exists, therefore we sh=
ould
> +     * tell DCO to simply wipe all keys
> +     */
> +    if (!primary)
> +    {

"First, we ASSERT() if primary is NULL, and then, we do some action
on primary being NULL"?


> +    struct key_state *secondary =3D dco_get_secondary_key(multi, primary=
);
> +    ASSERT(!secondary || secondary->dco_status !=3D DCO_NOT_INSTALLED);

Can you be sure that there always will be a valid and authorized secondary
key when this fires?

> +
> +    /* the current primary key was installed as secondary in DCO, this m=
eans
> +     * that userspace has promoted it and we should tell DCO to swap keys
> +     */
> +    if (primary->dco_status =3D=3D DCO_INSTALLED_SECONDARY)
> +    {
> +        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=
=3D%d id2=3D%d",
> +            primary->key_id, secondary ? secondary->key_id : -1);
> +
> +        dco_swap_keys(dco, multi->peer_id);
> +        primary->dco_status =3D DCO_INSTALLED_PRIMARY;
> +        if (secondary)
> +        {
> +            secondary->dco_status =3D DCO_INSTALLED_SECONDARY;
> +        }
> +    }
> +
> +    /* if we have no secondary key anymore, inform DCO about it */
> +    if (!secondary && multi->dco_keys_installed =3D=3D 2)
> +    {
> +        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
> +        multi->dco_keys_installed =3D 1;
> +    }

Since you ASSERT()ed on "!secondary", it is guaranteed to be not-NULL
here...


> +static int
> +dco_install_key(struct tls_multi *multi, struct key_state *ks,
> +                const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
> +                const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
> +                const char *ciphername)
> +
> +{
> +    msg(D_DCO_DEBUG, "%s: peer_id=3D%d keyid=3D%d", __func__, multi->pee=
r_id,
> +        ks->key_id);
> +
> +    /* Install a key in the PRIMARY slot only when no other key exist.
> +     * From that moment on, any new key will be installed in the SECONDA=
RY
> +     * slot and will be promoted to PRIMARY when userspace says so (a sw=
ap
> +     * will be performed in that case)
> +     */
> +    dco_key_slot_t slot =3D OVPN_KEY_SLOT_PRIMARY;
> +    if (multi->dco_keys_installed > 0)
> +    {
> +        slot =3D OVPN_KEY_SLOT_SECONDARY;
> +    }
> +
> +    int ret =3D dco_new_key(multi->dco, multi->peer_id, ks->key_id, slot,
> +                          encrypt_key, encrypt_iv,
> +                          decrypt_key, decrypt_iv,
> +                          ciphername);
> +    if ((ret =3D=3D 0) && (multi->dco_keys_installed < 2))
> +    {
> +        multi->dco_keys_installed++;
> +        switch (slot)
> +        {
> +            case OVPN_KEY_SLOT_PRIMARY:
> +                ks->dco_status =3D DCO_INSTALLED_PRIMARY;
> +                break;

I find this code slightly confusing.  So when there are 2 keys installed
and this function is called to install a new (upcoming secondary key),
it will never set "ks->dco_status", then?  Because the whole if()
construct is not called...

Doing this in a switch seems overly complicated anyway, compared to

   ks->dco_status =3D ( slot =3D=3D OVPN_KEY_SLOT_PRIMARY )? DCO_INSTALLED_=
PRIMARY:
                                                       DCO_INSTALLED_SECOND=
ARY;


> +int
> +init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
> +                const struct key2 *key2, int key_direction,
> +                const char *ciphername, bool server)
> +{
> +    struct key_direction_state kds;
> +    key_direction_state_init(&kds, key_direction);
> +
> +    return dco_install_key(multi, ks,
> +                           key2->keys[kds.out_key].cipher,
> +                           key2->keys[(int)server].hmac,
> +                           key2->keys[kds.in_key].cipher,
> +                           key2->keys[1 - (int)server].hmac,
> +                           ciphername);
> +}

This "_bi" stuff is "bidirectional data channel key", right?

(I tried to understand more, and the only easy-to-understand sections
I found were related to "static openvpn key" reading, which we don't
do in DCO mode...)

[..]
> +
> +/* These methods are currently Linux specific but likely to be used any
> + * platform that implements Server side DCO
> + */
> +
> +void
> +dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
> +                   struct mroute_addr *addr)
> +{
> +#if defined(TARGET_LINUX)
> +    if (!dco_enabled(&m->top.options))
> +    {
> +        return;
> +    }
> +
> +    int addrtype =3D (addr->type & MR_ADDR_MASK);
> +
> +    /* If we do not have local IP addr to install, skip the route */
> +    if ((addrtype =3D=3D MR_ADDR_IPV6 && !mi->context.c2.push_ifconfig_i=
pv6_defined)
> +        || (addrtype =3D=3D MR_ADDR_IPV4 && !mi->context.c2.push_ifconfi=
g_defined))
> +    {
> +        return;
> +    }

Should we have a warning here?  "iroute requested but cannot be installed
because no gateway/peer ip known"?

Otherwise we'll end up with a valid config that "silently does nothing".

(If we print that warning elsewhere, fine with me)


> +    struct context *c =3D &mi->context;
> +    const char *dev =3D c->c1.tuntap->actual_name;
> +
> +    if (addrtype =3D=3D MR_ADDR_IPV6)
> +    {
> +        int netbits =3D 128;
> +        if (addr->type & MR_WITH_NETBITS)
> +        {
> +            netbits =3D addr->netbits;
> +        }

Side note: I wonder why we have that distinction anyway... a
"MR WITHOUT NETBITS" would just be a "host route", so it could
always set /128 in the iroute parsing code...  but this is outside
of *this* patch to clean up.

> +
> +        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, netbits,
> +                         &mi->context.c2.push_ifconfig_ipv6_local, dev, =
0,
> +                         DCO_IROUTE_METRIC);
> +    }
> +    else if (addrtype =3D=3D MR_ADDR_IPV4)
> +    {
> +        int netbits =3D 32;
> +        if (addr->type & MR_WITH_NETBITS)
> +        {
> +            netbits =3D addr->netbits;
> +        }

... and here for IPv4 host routes...

[..]

dco.h:

> +#if defined(TARGET_LINUX)
> +#define DCO_DEFAULT_METRIC  200
> +#else
> +#define DCO_DEFAULT_METRIC  0
> +#endif

I find that define confusing, and I think the change to do_open_tun() /=20
do_init_route_list() is not a good way to do it.

If we're having that conditional for the "default metric in=20
route_option_list" anyway, it should just be "DCO_DEFAULT_METRIC"
(not platform dependent), and set in do_init_route_list().

See below...


> diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
[..]
> +/**
> + * The following are the DCO APIs used to control the driver.
> + * They are implemented by either dco_linux.c or dco_win.c
> + */

If this is the API, shouldn't it go to dco.h then?  The other parts
of dco_internal.h look more like "helper functions that multiple
DCO implementations need"


> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
[..]

I have not looked into detail into the netlink stuff (that would
need to have a parallel look into the kernel module and a deeper
understanding on what's going on)

> +/**
> + * Send a preprared netlink message and registers cb as callback if non-=
null.

Typo "prep*r*ared"

> +static int
> +ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb c=
b,
> +                 const char *prefix)
> +{
> +    dco->status =3D 1;
> +
> +    if (cb)
> +    {
> +        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);
> +    }
> +    else
> +    {
> +        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, NULL, dco);
> +    }

As Frank already commented - if cb is NULL, you can just always pass on=20
"cb", instead of having a second branch that spells out "NULL"...

> +struct sockaddr *
> +mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc)
> +{
> +    struct sockaddr_in6 *sock6 =3D ((struct sockaddr_in6 *)sock);
> +    if (sock->sa_family =3D=3D AF_INET6
> +        && memcmp(&sock6->sin6_addr, "\x00\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\xff\xff", 12)=3D=3D0)
> +    {

See previous mail, IN6_IS_ADDR_V4MAPPED()

> +int
> +dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
> +             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
> +             struct in_addr *remote_in4, struct in6_addr *remote_in6)
> +{
> +    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
[..]
> +    nla_nest_end(nl_msg, attr);
> +
> +
> +    ret =3D ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);

double blank line here


> +static int
> +ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unused)),
> +                 struct nlmsgerr *err, void *arg)
> +{
> +    struct nlmsghdr *nlh =3D (struct nlmsghdr *)err - 1;
> +    struct nlattr *tb_msg[NLMSGERR_ATTR_MAX + 1];
> +    int len =3D nlh->nlmsg_len;
> +    struct nlattr *attrs;
> +    int *ret =3D arg;
> +    int ack_len =3D sizeof(*nlh) + sizeof(int) + sizeof(*nlh);
> +
> +    *ret =3D err->error;
> +
> +    if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
> +    {
> +        return NL_STOP;
> +    }

This is a bunch of magic with no explanation on what it does...

Maybe a comment before the function when this callback function is
called, what sort of context it expects, and what it can do?


> +static void
> +ovpn_dco_init_netlink(dco_context_t *dco)
> +{
> +    dco->ovpn_dco_id =3D resolve_ovpn_netlink_id(M_ERR);
> +
> +    dco->nl_sock =3D nl_socket_alloc();
> +
> +

double blank line

> +    if (!dco->nl_sock)
> +    {
> +        msg(M_ERR, "Cannot create netlink socket");
> +    }
> +
> +    /* TODO: Why are we setting this buffer size? */
> +    nl_socket_set_buffer_size(dco->nl_sock, 8192, 8192);

This is a very good question :-)

> +static void
> +ovpn_dco_uninit_netlink(dco_context_t *dco)
> +{
> +    nl_socket_free(dco->nl_sock);
> +    dco->nl_sock =3D NULL;
> +
> +    /* Decrease reference count */
> +    nl_cb_put(dco->nl_cb);
> +
> +    memset(dco, 0, sizeof(*dco));

CLEAR(dco);


> +static int
> +mcast_family_handler(struct nl_msg *msg, void *arg)
> +{
> +    dco_context_t *dco =3D arg;
> +    struct nlattr *tb[CTRL_ATTR_MAX + 1];
> +    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
> +
> +    nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
> +              genlmsg_attrlen(gnlh, 0), NULL);
> +
> +    if (!tb[CTRL_ATTR_MCAST_GROUPS])
> +    {
> +        return NL_SKIP;
> +    }

This, again, is a function full of magic, and desperately lacking a
few comments on the why and how...

> +/**
> + * Lookup the multicast id for OpenVPN. This method and its help method =
currently
> + * hardcode the lookup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS=
 but
> + * extended in the future if we need to lookup more than one mcast id.

Missing a "... 'can be' extended ..." here?

What is that multicast ID being used for?  Why would one want more than
one?


> +static int
> +ovpn_handle_msg(struct nl_msg *msg, void *arg)
> +{
> +    dco_context_t *dco =3D arg;
> +
> +    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
> +    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
> +    struct nlmsghdr *nlh =3D nlmsg_hdr(msg);

This seems to be the most magic of all the undocumented function
here...?  (Can you spot the pattern of my comments? ;-) )


> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
[..]


I am skipping all the rest from here to init.c, due to "it's 4000 lines
of patch review" - I want to get to the point about the metric, and
will continue with forward.c later.


> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 21adc3cf..60c941a2 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
[..]
> @@ -1299,15 +1300,23 @@ do_init_timers(struct context *c, bool deferred)
>      }
>=20=20
>      /* initialize pings */
> -
> -    if (c->options.ping_send_timeout)
> +    if (dco_enabled(&c->options))
>      {
> -        event_timeout_init(&c->c2.ping_send_interval, c->options.ping_se=
nd_timeout, 0);
> +        /* The DCO kernel module will send the pings instead of user spa=
ce */
> +        event_timeout_clear(&c->c2.ping_rec_interval);
> +        event_timeout_clear(&c->c2.ping_send_interval);
>      }

Do we actually need to clear these, as opposed to "just do not call
event_timeout_init()"?

>      if (!deferred)
> @@ -1381,13 +1390,13 @@ do_alloc_route_list(struct context *c)
>  static void
>  do_init_route_list(const struct options *options,
>                     struct route_list *route_list,
> +                   int metric,
>                     const struct link_socket_info *link_socket_info,
>                     struct env_set *es,
>                     openvpn_net_ctx_t *ctx)
>  {
>      const char *gw =3D NULL;
>      int dev =3D dev_type_enum(options->dev, options->dev_type);
> -    int metric =3D 0;

I find the addition of an extra parameter and the accompanying=20
extra code in do_init_tun() to be a complicated way to get to the
desired result.  You have "options" here, so you can just do

   int metric =3D 0;
   if (dco_enabled(options))
   {
       metric =3D DCO_DEFAULT_METRIC;
   }

and get to the same result more easily.


>      if (dev =3D=3D DEV_TYPE_TUN && (options->topology =3D=3D TOP_NET30 |=
| options->topology =3D=3D TOP_P2P))
>      {
> @@ -1418,12 +1427,12 @@ do_init_route_list(const struct options *options,
>  static void
>  do_init_route_ipv6_list(const struct options *options,
>                          struct route_ipv6_list *route_ipv6_list,
> +                        int metric,
>                          const struct link_socket_info *link_socket_info,
>                          struct env_set *es,
>                          openvpn_net_ctx_t *ctx)
>  {
>      const char *gw =3D NULL;
> -    int metric =3D -1;            /* no metric set */

Same here...

>      gw =3D options->ifconfig_ipv6_remote;         /* default GW =3D remo=
te end */
>      if (options->route_ipv6_default_gateway)
[..]

> @@ -1715,12 +1730,24 @@ do_open_tun(struct context *c)
>      ASSERT(c->c2.link_socket);
>      if (c->options.routes && c->c1.route_list)
>      {
> -        do_init_route_list(&c->options, c->c1.route_list,
> +        int metric =3D 0;
> +        if (dco_enabled(&c->options))
> +        {
> +            metric =3D DCO_DEFAULT_METRIC;
> +        }
> +
> +        do_init_route_list(&c->options, c->c1.route_list, metric,
>                             &c->c2.link_socket->info, c->c2.es, &c->net_c=
tx);
>      }
>      if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
>      {
> -        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
> +        int metric =3D -1;
> +        if (dco_enabled(&c->options))
> +        {
> +            metric =3D DCO_DEFAULT_METRIC;
> +        }
> +
> +        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list, metr=
ic,
>                                  &c->c2.link_socket->info, c->c2.es,
>                                  &c->net_ctx);
>      }

... and with the suggested change to do_init_route*_list(), this
change can totally go.


> @@ -2014,6 +2046,7 @@ tun_abort(void)
>   * Handle delayed tun/tap interface bringup due to --up-delay or --pull
>   */
>=20=20
> +
>  /**
>   * Helper for do_up().  Take two option hashes and return true if they a=
re not
>   * equal, or either one is all-zeroes.

Spurious extra new line.


> @@ -2034,23 +2067,6 @@ do_up(struct context *c, bool pulled_options, unsi=
gned int option_types_found)
>      {
>          reset_coarse_timers(c);
>=20=20
> -        if (pulled_options)
> -        {
> -            if (!do_deferred_options(c, option_types_found))
> -            {
> -                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options"=
);
> -                return false;
> -            }
> -        }
> -        else if (c->mode =3D=3D MODE_POINT_TO_POINT)
> -        {
> -            if (!do_deferred_p2p_ncp(c))
> -            {
> -                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated=
 protocol options");
> -                return false;
> -            }
> -        }
> -
>          /* if --up-delay specified, open tun, do ifconfig, and run up sc=
ript now */
>          if (c->options.up_delay || PULL_DEFINED(&c->options))
>          {
> @@ -2076,6 +2092,23 @@ do_up(struct context *c, bool pulled_options, unsi=
gned int option_types_found)
>              }
>          }
>=20=20
> +        if (pulled_options)
> +        {
> +            if (!do_deferred_options(c, option_types_found))
> +            {
> +                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options"=
);
> +                return false;
> +            }
> +        }
> +        else if (c->mode =3D=3D MODE_POINT_TO_POINT)
> +        {
> +            if (!do_deferred_p2p_ncp(c))
> +            {
> +                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated=
 protocol options");
> +                return false;
> +            }
> +        }
> +
>          if (c->c2.did_open_tun)
>          {
>              c->c1.pulled_options_digest_save =3D c->c2.pulled_options_di=
gest;


On this, I can't see an obvious reason why the two blocks (what is
show in the diff, and the "options_hash_changed_or_zero()" block) need to=20
change order - can you help me understand?


>  /*
>   * Handle non-tun-related pulled options.
>   */
> @@ -2286,15 +2333,54 @@ do_deferred_options(struct context *c, const unsi=
gned int found)
>          }
>  #endif
>=20=20
> +        if (c->c2.did_open_tun)
> +        {
> +            /* If we are in DCO mode we need to set the new peer options=
 now */
> +            int ret =3D dco_p2p_add_new_peer(c);
> +            if (ret < 0)
> +            {
> +                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
> +                return false;
> +            }
> +        }

That comment reads as if we "set the new options for an existing peer",
but the code reads as if this is creating the peer, with the new options.

If that interpretation is right, maybe

  /* if we are in DCO mode, we now have all information needed and
   * can proceed to create the peer
   */

or something?


Enough for today.  More modules to come.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--HThcY/IcZcaX6but
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJibV/4AAoJEB2Cnv7KVigS4pcMAKSEXglfA2DLxW+mXa2I5euG
FGqIrwwQOKa1kc1Z4cVAOwQmCPyIGd/doMsiS2Qih0LzR8mdvG4xkGMBL3fwACM+
/H5ZBpnPqog7LntuWo13P6C91efTKS/S+DJnT7wEdujcvmvdQ8hfEFCgz7oXyrL1
O6qJA4ft3W2KrH+7DPlV/dUvElwA1G6QCzAP8vH9lTEkt/3rVfPXbAsS2a3tAbcn
wq5CC8xsgT28QMqhADLd5LELSO8BiDIKXepaDuhWQi2K1VrddFeSs72Tiw6/nque
ci/XBeJyxjYTPW2y/izjAo+eUruE3Fqu5B7vCN+23BPM43eLVuEJdKfSALE7lE0a
xB18yqIjCD3rzYs9wUqTrMNwFA2Oz/IRix1zweKXVStl3NrHD4dft+mgxvN7PgQH
tbROOjrcwsfIyu1ooBwr2UA1nniys/ReNc1ASudTij4da+bEXAxPHmcefa99bOFI
4+bAeXRBTzRfSoCXsGkt9v0NXKu93kjMaA634f3NdQ==
=ktvK
-----END PGP SIGNATURE-----

--HThcY/IcZcaX6but--

