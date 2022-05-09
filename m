Message-ID: <17301b80-0f23-46b9-89ef-1aec7e381247@...2181...>
Date: Mon, 9 May 2022 17:48:03 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220402070902.30282-5-a@...2181...>
 <20220411133528.27279-1-a@...2181...> <Ym1f+Jmvfj28Or6s@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Ym1f+Jmvfj28Or6s@...1296...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 30/04/2022 18:12, Gert Doering wrote:
> Hi,
> 
> On Mon, Apr 11, 2022 at 03:35:28PM +0200, Antonio Quartulli wrote:
>> Implement the data-channel offloading using the ovpn-dco kernel
>> module. See README.dco.md for more details.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
> 
> I've browsed through the code a bit to see if I can spot "unsafe"
> constructs (memory, pointers), or anything else noteworthy - since
> this is not the actual current code, it's hard to ACK.
> 
> We should move forward with "get this merged, and if the good folks
> testing this find new breakages, make this extra (smaller) patches
> on top, with proper credit"...
> 
> That said...  a few things, in addition to the IN6_IS_ADDR_V4MAPPED() thing:

Thanks for pointing that out. I am switching to IN6_IS_ADDR_V4MAPPED()

> 
> 
>> +int
>> +dco_p2p_add_new_peer(struct context *c)
>> +{
>> +    if (!dco_enabled(&c->options))
>> +    {
>> +        return 0;
>> +    }
> [..]
>> +
>> +    if (dco_enabled(&c->options) && !c->c2.link_socket->info.dco_installed)
>> +    {
> 
> This second "dco_enabled()" check looks very unnecessary...
> 
> Not sure about the "if (!dco_installed)" check here - this seems to guard
> against double installment of this socket, but from the code flow I'm
> not sure how this could happen?

You are right - this is more a precondition.

I removed the if entirely (the dco_enabled() check is obviously uselss) 
and moved the !dco_installed condition as an assert at the top of the 
function.

> 
>> +void
>> +dco_remove_peer(struct context *c)
>> +{
>> +    if (!dco_enabled(&c->options))
>> +    {
>> +        return;
>> +    }
>> +    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_added)
>> +    {
>> +        c->c2.tls_multi->dco_peer_added = false;
>> +        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id);
>> +    }
> 
> "traditional code ordering" would have the " = false" after the
> actual dco_del_peer() call... but that's of only aesthetic significance.

well, makes sense. moved the assignment to the second line.

> 
>> +void
>> +dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
>> +{
>> +    msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->peer_id);
> [..]
>> +
>> +    struct key_state *primary = tls_select_encryption_key(multi);
>> +    ASSERT(!primary || primary->dco_status != DCO_NOT_INSTALLED);
>> +
>> +    /* no primary key available -> no usable key exists, therefore we should
>> +     * tell DCO to simply wipe all keys
>> +     */
>> +    if (!primary)
>> +    {
> 
> "First, we ASSERT() if primary is NULL, and then, we do some action
> on primary being NULL"?

hmm the ASSERT has two conditions in logic *or*:

"ASSERT(!primary || primary->dco_status != DCO_NOT_INSTALLED);"

Either primary is NULL or (if not-NULL) then its status must be 
NOT_INSTALLED.

This means that after the ASSERT we don't know yet if primary was NULL 
or not.


> 
> 
>> +    struct key_state *secondary = dco_get_secondary_key(multi, primary);
>> +    ASSERT(!secondary || secondary->dco_status != DCO_NOT_INSTALLED);
> 
> Can you be sure that there always will be a valid and authorized secondary
> key when this fires?

Same as above: secondary may either be NULL or NOT_INSTALLED.

> 
>> +
>> +    /* the current primary key was installed as secondary in DCO, this means
>> +     * that userspace has promoted it and we should tell DCO to swap keys
>> +     */
>> +    if (primary->dco_status == DCO_INSTALLED_SECONDARY)
>> +    {
>> +        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=%d id2=%d",
>> +            primary->key_id, secondary ? secondary->key_id : -1);
>> +
>> +        dco_swap_keys(dco, multi->peer_id);
>> +        primary->dco_status = DCO_INSTALLED_PRIMARY;
>> +        if (secondary)
>> +        {
>> +            secondary->dco_status = DCO_INSTALLED_SECONDARY;
>> +        }
>> +    }
>> +
>> +    /* if we have no secondary key anymore, inform DCO about it */
>> +    if (!secondary && multi->dco_keys_installed == 2)
>> +    {
>> +        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
>> +        multi->dco_keys_installed = 1;
>> +    }
> 
> Since you ASSERT()ed on "!secondary", it is guaranteed to be not-NULL
> here...

As per above.

> 
> 
>> +static int
>> +dco_install_key(struct tls_multi *multi, struct key_state *ks,
>> +                const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
>> +                const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
>> +                const char *ciphername)
>> +
>> +{
>> +    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d", __func__, multi->peer_id,
>> +        ks->key_id);
>> +
>> +    /* Install a key in the PRIMARY slot only when no other key exist.
>> +     * From that moment on, any new key will be installed in the SECONDARY
>> +     * slot and will be promoted to PRIMARY when userspace says so (a swap
>> +     * will be performed in that case)
>> +     */
>> +    dco_key_slot_t slot = OVPN_KEY_SLOT_PRIMARY;
>> +    if (multi->dco_keys_installed > 0)
>> +    {
>> +        slot = OVPN_KEY_SLOT_SECONDARY;
>> +    }
>> +
>> +    int ret = dco_new_key(multi->dco, multi->peer_id, ks->key_id, slot,
>> +                          encrypt_key, encrypt_iv,
>> +                          decrypt_key, decrypt_iv,
>> +                          ciphername);
>> +    if ((ret == 0) && (multi->dco_keys_installed < 2))
>> +    {
>> +        multi->dco_keys_installed++;
>> +        switch (slot)
>> +        {
>> +            case OVPN_KEY_SLOT_PRIMARY:
>> +                ks->dco_status = DCO_INSTALLED_PRIMARY;
>> +                break;
> 
> I find this code slightly confusing.  So when there are 2 keys installed
> and this function is called to install a new (upcoming secondary key),
> it will never set "ks->dco_status", then?  Because the whole if()
> construct is not called...

Correct. This means we are at runtime, hence both keys are already 
INSTALLED, so no need to alter the status.

We could move the switch/case out and keep only the key_installed++ 
under the double condition. But it would be a useless assignment anyway.

> 
> Doing this in a switch seems overly complicated anyway, compared to
> 
>     ks->dco_status = ( slot == OVPN_KEY_SLOT_PRIMARY )? DCO_INSTALLED_PRIMARY:
>                                                         DCO_INSTALLED_SECONDARY;
> 

With enums I always prefer to use switch/case to properly enumerate all 
possible cases. Now here we have two values only, so we could skip the 
switch/case. I think it's just a matter of taste.

But your compact solution looks nice - I'll go with it!

> 
>> +int
>> +init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
>> +                const struct key2 *key2, int key_direction,
>> +                const char *ciphername, bool server)
>> +{
>> +    struct key_direction_state kds;
>> +    key_direction_state_init(&kds, key_direction);
>> +
>> +    return dco_install_key(multi, ks,
>> +                           key2->keys[kds.out_key].cipher,
>> +                           key2->keys[(int)server].hmac,
>> +                           key2->keys[kds.in_key].cipher,
>> +                           key2->keys[1 - (int)server].hmac,
>> +                           ciphername);
>> +}
> 
> This "_bi" stuff is "bidirectional data channel key", right?

yes..

> 
> (I tried to understand more, and the only easy-to-understand sections
> I found were related to "static openvpn key" reading, which we don't
> do in DCO mode...)
> 
> [..]
>> +
>> +/* These methods are currently Linux specific but likely to be used any
>> + * platform that implements Server side DCO
>> + */
>> +
>> +void
>> +dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
>> +                   struct mroute_addr *addr)
>> +{
>> +#if defined(TARGET_LINUX)
>> +    if (!dco_enabled(&m->top.options))
>> +    {
>> +        return;
>> +    }
>> +
>> +    int addrtype = (addr->type & MR_ADDR_MASK);
>> +
>> +    /* If we do not have local IP addr to install, skip the route */
>> +    if ((addrtype == MR_ADDR_IPV6 && !mi->context.c2.push_ifconfig_ipv6_defined)
>> +        || (addrtype == MR_ADDR_IPV4 && !mi->context.c2.push_ifconfig_defined))
>> +    {
>> +        return;
>> +    }
> 
> Should we have a warning here?  "iroute requested but cannot be installed
> because no gateway/peer ip known"?
> 
> Otherwise we'll end up with a valid config that "silently does nothing".
> 
> (If we print that warning elsewhere, fine with me)

I am not even sure anything can work if the server does not know the 
client VPN IP. The latter is needed also for basic traffic (i.e. 
directed to the peer itself).

> 
> 
>> +    struct context *c = &mi->context;
>> +    const char *dev = c->c1.tuntap->actual_name;
>> +
>> +    if (addrtype == MR_ADDR_IPV6)
>> +    {
>> +        int netbits = 128;
>> +        if (addr->type & MR_WITH_NETBITS)
>> +        {
>> +            netbits = addr->netbits;
>> +        }
> 
> Side note: I wonder why we have that distinction anyway... a
> "MR WITHOUT NETBITS" would just be a "host route", so it could
> always set /128 in the iroute parsing code...  but this is outside
> of *this* patch to clean up.

don't open the can..

> 
>> +
>> +        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, netbits,
>> +                         &mi->context.c2.push_ifconfig_ipv6_local, dev, 0,
>> +                         DCO_IROUTE_METRIC);
>> +    }
>> +    else if (addrtype == MR_ADDR_IPV4)
>> +    {
>> +        int netbits = 32;
>> +        if (addr->type & MR_WITH_NETBITS)
>> +        {
>> +            netbits = addr->netbits;
>> +        }
> 
> ... and here for IPv4 host routes...
> 
> [..]
> 
> dco.h:
> 
>> +#if defined(TARGET_LINUX)
>> +#define DCO_DEFAULT_METRIC  200
>> +#else
>> +#define DCO_DEFAULT_METRIC  0
>> +#endif
> 
> I find that define confusing, and I think the change to do_open_tun() /
> do_init_route_list() is not a good way to do it.
> 
> If we're having that conditional for the "default metric in
> route_option_list" anyway, it should just be "DCO_DEFAULT_METRIC"
> (not platform dependent), and set in do_init_route_list().

mh yeah, I am also not super happy about this.

> 
> See below...
> 
> 
>> diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
> [..]
>> +/**
>> + * The following are the DCO APIs used to control the driver.
>> + * They are implemented by either dco_linux.c or dco_win.c
>> + */
> 
> If this is the API, shouldn't it go to dco.h then?  The other parts
> of dco_internal.h look more like "helper functions that multiple
> DCO implementations need"
> 
> 
>> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> [..]
> 
> I have not looked into detail into the netlink stuff (that would
> need to have a parallel look into the kernel module and a deeper
> understanding on what's going on)

or maybe by just looking at the API. I may need to add some more doc to 
make them more clear.

> 
>> +/**
>> + * Send a preprared netlink message and registers cb as callback if non-null.
> 
> Typo "prep*r*ared"

fixed

> 
>> +static int
>> +ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
>> +                 const char *prefix)
>> +{
>> +    dco->status = 1;
>> +
>> +    if (cb)
>> +    {
>> +        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);
>> +    }
>> +    else
>> +    {
>> +        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, NULL, dco);
>> +    }
> 
> As Frank already commented - if cb is NULL, you can just always pass on
> "cb", instead of having a second branch that spells out "NULL"...

fixed


> 
>> +struct sockaddr *
>> +mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc)
>> +{
>> +    struct sockaddr_in6 *sock6 = ((struct sockaddr_in6 *)sock);
>> +    if (sock->sa_family == AF_INET6
>> +        && memcmp(&sock6->sin6_addr, "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff", 12)==0)
>> +    {
> 
> See previous mail, IN6_IS_ADDR_V4MAPPED()

fixed

> 
>> +int
>> +dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
>> +             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
>> +             struct in_addr *remote_in4, struct in6_addr *remote_in6)
>> +{
>> +    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
> [..]
>> +    nla_nest_end(nl_msg, attr);
>> +
>> +
>> +    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
> 
> double blank line here

fixed

> 
> 
>> +static int
>> +ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unused)),
>> +                 struct nlmsgerr *err, void *arg)
>> +{
>> +    struct nlmsghdr *nlh = (struct nlmsghdr *)err - 1;
>> +    struct nlattr *tb_msg[NLMSGERR_ATTR_MAX + 1];
>> +    int len = nlh->nlmsg_len;
>> +    struct nlattr *attrs;
>> +    int *ret = arg;
>> +    int ack_len = sizeof(*nlh) + sizeof(int) + sizeof(*nlh);
>> +
>> +    *ret = err->error;
>> +
>> +    if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
>> +    {
>> +        return NL_STOP;
>> +    }
> 
> This is a bunch of magic with no explanation on what it does...

copied from other netlink programs :]

> 
> Maybe a comment before the function when this callback function is
> called, what sort of context it expects, and what it can do?
> 


Sure will add a comment. To give an idea: it simply sets the error in 
the variable pointed by *arg, so that it can be retrieved from the code 
doing the netlink call.

The rest is just ugly blabla to parse the message and get a more verbose 
error message, if any was sent by the kernel.

> 
>> +static void
>> +ovpn_dco_init_netlink(dco_context_t *dco)
>> +{
>> +    dco->ovpn_dco_id = resolve_ovpn_netlink_id(M_ERR);
>> +
>> +    dco->nl_sock = nl_socket_alloc();
>> +
>> +
> 
> double blank line
> 
>> +    if (!dco->nl_sock)
>> +    {
>> +        msg(M_ERR, "Cannot create netlink socket");
>> +    }
>> +
>> +    /* TODO: Why are we setting this buffer size? */
>> +    nl_socket_set_buffer_size(dco->nl_sock, 8192, 8192);
> 
> This is a very good question :-)

ideed. copied from iw.c :)
That's just a way to ensure that larger messages can happily fit the 
socket buffer and not fail.

> 
>> +static void
>> +ovpn_dco_uninit_netlink(dco_context_t *dco)
>> +{
>> +    nl_socket_free(dco->nl_sock);
>> +    dco->nl_sock = NULL;
>> +
>> +    /* Decrease reference count */
>> +    nl_cb_put(dco->nl_cb);
>> +
>> +    memset(dco, 0, sizeof(*dco));
> 
> CLEAR(dco);

fixed

> 
> 
>> +static int
>> +mcast_family_handler(struct nl_msg *msg, void *arg)
>> +{
>> +    dco_context_t *dco = arg;
>> +    struct nlattr *tb[CTRL_ATTR_MAX + 1];
>> +    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
>> +
>> +    nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
>> +              genlmsg_attrlen(gnlh, 0), NULL);
>> +
>> +    if (!tb[CTRL_ATTR_MCAST_GROUPS])
>> +    {
>> +        return NL_SKIP;
>> +    }
> 
> This, again, is a function full of magic, and desperately lacking a
> few comments on the why and how...

This is basically just parsing the reply to CTRL_CMD_GETFAMILY so that 
we can retrieve the multicast id of the DCO module.

To put it in other words: it is basically a callback for operations 
performed in ovpn_get_mcast_id() - there you have the higher level 
comment. But can add some more here if we want.

> 
>> +/**
>> + * Lookup the multicast id for OpenVPN. This method and its help method currently
>> + * hardcode the lookup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS but
>> + * extended in the future if we need to lookup more than one mcast id.
> 
> Missing a "... 'can be' extended ..." here?

yes

> 
> What is that multicast ID being used for?  Why would one want more than
> one?

think of them as if they are multicast groups. You first get their 
addresses (IDs) and then register for messages sent to those groups.

The idea is that the main OVPN_NL_NAME group is for generic messages, 
while the OVPN_NL_MULTICAST_GROUP_PEERS group is for peer events.

We wanted to make this as flexible as possible so that also other 
programs running on the host could register to specific groups and get 
the events they are interested in.

There is no plan at the moment to create more groups.

> 
> 
>> +static int
>> +ovpn_handle_msg(struct nl_msg *msg, void *arg)
>> +{
>> +    dco_context_t *dco = arg;
>> +
>> +    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
>> +    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
>> +    struct nlmsghdr *nlh = nlmsg_hdr(msg);
> 
> This seems to be the most magic of all the undocumented function
> here...?  (Can you spot the pattern of my comments? ;-) )

hehe, because again this functon is just parsing a netlink reply. Can 
add some comments, but it is all mostly about check if attributes are 
there and if so retrieve thewir values.

> 
> 
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> [..]
> 
> 
> I am skipping all the rest from here to init.c, due to "it's 4000 lines
> of patch review" - I want to get to the point about the metric, and
> will continue with forward.c later.
> 
> 
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index 21adc3cf..60c941a2 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
> [..]
>> @@ -1299,15 +1300,23 @@ do_init_timers(struct context *c, bool deferred)
>>       }
>>   
>>       /* initialize pings */
>> -
>> -    if (c->options.ping_send_timeout)
>> +    if (dco_enabled(&c->options))
>>       {
>> -        event_timeout_init(&c->c2.ping_send_interval, c->options.ping_send_timeout, 0);
>> +        /* The DCO kernel module will send the pings instead of user space */
>> +        event_timeout_clear(&c->c2.ping_rec_interval);
>> +        event_timeout_clear(&c->c2.ping_send_interval);
>>       }
> 
> Do we actually need to clear these, as opposed to "just do not call
> event_timeout_init()"?

mumble mumble...we'd need to clear if init() was called before, but I 
don't think we can switch from non-DCO to DCO at runtime, so nobody 
should have ever init'd the timers...so probably you are right.

> 
>>       if (!deferred)
>> @@ -1381,13 +1390,13 @@ do_alloc_route_list(struct context *c)
>>   static void
>>   do_init_route_list(const struct options *options,
>>                      struct route_list *route_list,
>> +                   int metric,
>>                      const struct link_socket_info *link_socket_info,
>>                      struct env_set *es,
>>                      openvpn_net_ctx_t *ctx)
>>   {
>>       const char *gw = NULL;
>>       int dev = dev_type_enum(options->dev, options->dev_type);
>> -    int metric = 0;
> 
> I find the addition of an extra parameter and the accompanying
> extra code in do_init_tun() to be a complicated way to get to the
> desired result.  You have "options" here, so you can just do
> 
>     int metric = 0;
>     if (dco_enabled(options))
>     {
>         metric = DCO_DEFAULT_METRIC;
>     }
> 
> and get to the same result more easily.

true..

> 
> 
>>       if (dev == DEV_TYPE_TUN && (options->topology == TOP_NET30 || options->topology == TOP_P2P))
>>       {
>> @@ -1418,12 +1427,12 @@ do_init_route_list(const struct options *options,
>>   static void
>>   do_init_route_ipv6_list(const struct options *options,
>>                           struct route_ipv6_list *route_ipv6_list,
>> +                        int metric,
>>                           const struct link_socket_info *link_socket_info,
>>                           struct env_set *es,
>>                           openvpn_net_ctx_t *ctx)
>>   {
>>       const char *gw = NULL;
>> -    int metric = -1;            /* no metric set */
> 
> Same here...
> 
>>       gw = options->ifconfig_ipv6_remote;         /* default GW = remote end */
>>       if (options->route_ipv6_default_gateway)
> [..]
> 
>> @@ -1715,12 +1730,24 @@ do_open_tun(struct context *c)
>>       ASSERT(c->c2.link_socket);
>>       if (c->options.routes && c->c1.route_list)
>>       {
>> -        do_init_route_list(&c->options, c->c1.route_list,
>> +        int metric = 0;
>> +        if (dco_enabled(&c->options))
>> +        {
>> +            metric = DCO_DEFAULT_METRIC;
>> +        }
>> +
>> +        do_init_route_list(&c->options, c->c1.route_list, metric,
>>                              &c->c2.link_socket->info, c->c2.es, &c->net_ctx);
>>       }
>>       if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
>>       {
>> -        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
>> +        int metric = -1;
>> +        if (dco_enabled(&c->options))
>> +        {
>> +            metric = DCO_DEFAULT_METRIC;
>> +        }
>> +
>> +        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list, metric,
>>                                   &c->c2.link_socket->info, c->c2.es,
>>                                   &c->net_ctx);
>>       }
> 
> ... and with the suggested change to do_init_route*_list(), this
> change can totally go.

yup, gone!

> 
> 
>> @@ -2014,6 +2046,7 @@ tun_abort(void)
>>    * Handle delayed tun/tap interface bringup due to --up-delay or --pull
>>    */
>>   
>> +
>>   /**
>>    * Helper for do_up().  Take two option hashes and return true if they are not
>>    * equal, or either one is all-zeroes.
> 
> Spurious extra new line.
> 
> 
>> @@ -2034,23 +2067,6 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
>>       {
>>           reset_coarse_timers(c);
>>   
>> -        if (pulled_options)
>> -        {
>> -            if (!do_deferred_options(c, option_types_found))
>> -            {
>> -                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
>> -                return false;
>> -            }
>> -        }
>> -        else if (c->mode == MODE_POINT_TO_POINT)
>> -        {
>> -            if (!do_deferred_p2p_ncp(c))
>> -            {
>> -                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
>> -                return false;
>> -            }
>> -        }
>> -
>>           /* if --up-delay specified, open tun, do ifconfig, and run up script now */
>>           if (c->options.up_delay || PULL_DEFINED(&c->options))
>>           {
>> @@ -2076,6 +2092,23 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
>>               }
>>           }
>>   
>> +        if (pulled_options)
>> +        {
>> +            if (!do_deferred_options(c, option_types_found))
>> +            {
>> +                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
>> +                return false;
>> +            }
>> +        }
>> +        else if (c->mode == MODE_POINT_TO_POINT)
>> +        {
>> +            if (!do_deferred_p2p_ncp(c))
>> +            {
>> +                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
>> +                return false;
>> +            }
>> +        }
>> +
>>           if (c->c2.did_open_tun)
>>           {
>>               c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
> 
> 
> On this, I can't see an obvious reason why the two blocks (what is
> show in the diff, and the "options_hash_changed_or_zero()" block) need to
> change order - can you help me understand?
> 

the reason was that the tun interface must be opened before we start 
parsing any option and start sending messages to the kernel (i.e. add 
peer or add key). So I moved the whole block earlier in do_up().

Note: tis function is still ongoing some restructuring because of the 
issues found by the netgate folks in P2P mode.


> 
>>   /*
>>    * Handle non-tun-related pulled options.
>>    */
>> @@ -2286,15 +2333,54 @@ do_deferred_options(struct context *c, const unsigned int found)
>>           }
>>   #endif
>>   
>> +        if (c->c2.did_open_tun)
>> +        {
>> +            /* If we are in DCO mode we need to set the new peer options now */
>> +            int ret = dco_p2p_add_new_peer(c);
>> +            if (ret < 0)
>> +            {
>> +                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
>> +                return false;
>> +            }
>> +        }
> 
> That comment reads as if we "set the new options for an existing peer",
> but the code reads as if this is creating the peer, with the new options.
> 
> If that interpretation is right, maybe
> 
>    /* if we are in DCO mode, we now have all information needed and
>     * can proceed to create the peer
>     */
> 
> or something?

agreed - this was an older comment that was not changed after altering 
the code. fixing...

> 
> 
> Enough for today.  More modules to come.

Thanks a lot :)


will push everything in a bit.

> 
> gert
> 

-- 
Antonio Quartulli

