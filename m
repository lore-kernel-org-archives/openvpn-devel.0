From: "James Yonan" <jim@...41...>
Message-ID: <twig.1090918723.37830@...41...>
In-Reply-To: <16645.49196.829476.656946@...253...>
Subject: [Openvpn-devel] Re: [PATCH - 4 of 4]  support new option "net-type"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Jul 27 01:59:35 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Neil Brown <neilb@...253...>, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Neil,

Comments Inline below...

Neil Brown <neilb@...253...> said:

> 
> 
> As was hinted at with the previous patch, this patch introduces a new
> config option "net-type".  It can be either "ptp" or "subnet".
> 
> If net-type is not explicitly given then:
>   if "dev" is "tun", "net-type" will be "ptp"
>   if "dev" is "tap", "net-type" will be "subnet"
> 
> If it is given, then it overrides that default.
> 
> Probably the most useful usage is to set "net-type subnet" when
> using  "dev tap".

I'm not sure I understand this.  Doesn't current OpenVPN usage associate dev
tap interfaces with subnet-based networks?

> This allows you to have a simple subnet of all openvpn clients talking
> to a given server, and provides some guarantees that only the client
> allocated a particular IP address will be able to use it.

Can you post any config file examples showing how you would use this?

> I'm am not sure how this will work with OPENBSD, NETBSD, or DARWIN as
> tun.c doesn't seem to be able to ifconfig these with subnets.  It
> definitely works for Linux and should work for WIN32 and FREEBSD.

For portability with tun interfaces across various OSes, OpenVPN tries to
treat them all as being point-to-point interfaces, rather than allowing (as
some OSes do) a subnet mask to be assigned to a tun endpoint.

James

> This patch doesn't include any updates to documentation.  If you are
> happy to accept it, I will update the relevant documentation and send
> you that patch.

> 
> ==========================================
> ### Diffstat output
>  ./init.c    |    3 ++-
>  ./multi.c   |    2 +-
>  ./options.c |   25 ++++++++++++++++++++++++-
>  ./options.h |    2 +-
>  ./tun.c     |   12 ++++++++++++
>  ./tun.h     |   12 +++---------
>  6 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff ./init.c~current~ ./init.c
> --- ./init.c~current~	2004-07-27 11:44:22.000000000 +1000
> +++ ./init.c	2004-07-27 11:44:45.000000000 +1000
> @@ -492,7 +492,7 @@ do_init_route_list (const struct options
>  		    bool fatal)
>  {
>    const char *gw = NULL;
> -  int net = dev_to_net (dev_type_enum (options->dev, options->dev_type));
> +  int net = net_type_enum (options->net_type);
>  
>    if (net == NET_TYPE_PTP)
>      gw = options->ifconfig_remote_netmask;
> @@ -539,6 +539,7 @@ do_init_tun (struct context *c)
>  			   c->options.dev_type,
>  			   c->options.ifconfig_local,
>  			   c->options.ifconfig_remote_netmask,
> +			   c->options.net_type,
>  			   addr_host (&c->c1.link_socket_addr.local),
>  			   addr_host (&c->c1.link_socket_addr.remote));
>  
> 
> diff ./multi.c~current~ ./multi.c
> --- ./multi.c~current~	2004-07-27 11:44:22.000000000 +1000
> +++ ./multi.c	2004-07-27 11:44:45.000000000 +1000
> @@ -204,7 +204,7 @@ multi_init (struct multi_context *m, str
>    /*
>     * Get tun/tap/null device type
>     */
> -  net = dev_to_net (dev_type_enum (t->options.dev, t->options.dev_type));
> +  net = net_type_enum (t->options.net_type);
>  
>    /*
>     * Init our multi_context object.
> 
> diff ./options.c~current~ ./options.c
> --- ./options.c~current~	2004-07-27 11:44:45.000000000 +1000
> +++ ./options.c	2004-07-27 11:44:45.000000000 +1000
> @@ -114,6 +114,7 @@ static const char usage_message[] =
>    "                  does not begin with \"tun\" or \"tap\".\n"
>    "--dev-node node : Explicitly set the device node rather than using\n"
>    "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
> +  "--net-type ptp|subnet : Override default network type\n"
>    "--tun-ipv6      : Build tun link capable of forwarding IPv6 traffic.\n"
>    "--ifconfig l rn : TUN: configure device to use IP address l as a local\n"
>    "                  endpoint and rn as a remote endpoint.  l & rn should be\n"
> @@ -727,6 +728,7 @@ show_settings (const struct options *o)
>    SHOW_STR (dev);
>    SHOW_STR (dev_type);
>    SHOW_STR (dev_node);
> +  SHOW_STR (net_type);
>    SHOW_BOOL (tun_ipv6);
>    SHOW_STR (ifconfig_local);
>    SHOW_STR (ifconfig_remote_netmask);
> @@ -901,6 +903,16 @@ options_postprocess (struct options *opt
>     */
>    dev = dev_type_enum (options->dev, options->dev_type);
>  
> +  if (options->net_type == NULL)
> +    switch(dev) 
> +      {
> +        case DEV_TYPE_TUN: options->net_type = "ptp"; break;
> +        case DEV_TYPE_TAP: options->net_type = "subnet"; break;
> +        default: options->net_type = "ptp"; break;
> +      }
> +  if (strcmp(options->net_type, "ptp") &&
> +      strcmp(options->net_type, "subnet")) 
> +        msg (M_USAGE, "Options error: --net-type must be 'ptp' or 'subnet'");
>    /*
>     * Fill in default port number for --remote list
>     */
> @@ -1304,6 +1316,7 @@ options_string (const struct options *o,
>  {
>    struct buffer out = alloc_buf (256);
>    bool tt_local = false;
> +  const char *s;
>  
>    buf_printf (&out, "V4");
>  
> @@ -1311,7 +1324,10 @@ options_string (const struct options *o,
>     * Tunnel Options
>     */
>  
> -  buf_printf (&out, ",dev-type %s", dev_type_string (o->dev, o->dev_type));
> +  buf_printf (&out, ",dev-type %s", (s = dev_type_string (o->dev,
o->dev_type)));
> +  if ((strcmp(s,"tun")==0 && strcmp(o->net_type, "ptp") != 0) ||
> +      (strcmp(s,"tap")==0 && strcmp(o->net_type, "subnet") != 0))
> +	  buf_printf (&out, ",net-type %s", o->net_type);
>    buf_printf (&out, ",link-mtu %d", EXPANDED_SIZE (frame));
>    buf_printf (&out, ",tun-mtu %d", PAYLOAD_SIZE (frame));
>    buf_printf (&out, ",proto %s", proto2ascii (proto_remote (o->proto,
remote), true));
> @@ -1328,6 +1344,7 @@ options_string (const struct options *o,
>  		     o->dev_type,
>  		     o->ifconfig_local,
>  		     o->ifconfig_remote_netmask,
> +		     o->net_type,
>  		     (in_addr_t)0,
>  		     (in_addr_t)0);
>        if (tt)
> @@ -1945,6 +1962,12 @@ add_option (struct options *options,
>        VERIFY_PERMISSION (OPT_P_GENERAL);
>        options->dev_node = p[1];
>      }
> +  else if (streq (p[0], "net-type") && p[1])
> +    {
> +      ++i;
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      options->net_type = p[1];
> +    }
>    else if (streq (p[0], "tun-ipv6"))
>      {
>        VERIFY_PERMISSION (OPT_P_UP);
> 
> diff ./options.h~current~ ./options.h
> --- ./options.h~current~	2004-07-27 11:44:12.000000000 +1000
> +++ ./options.h	2004-07-27 11:44:45.000000000 +1000
> @@ -109,6 +109,7 @@ struct options
>    const char *dev;
>    const char *dev_type;
>    const char *dev_node;
> +  const char *net_type;
>    const char *ifconfig_local;
>    const char *ifconfig_remote_netmask;
>    bool ifconfig_noexec;
> @@ -311,7 +312,6 @@ struct options
>    bool exit_event_initial_state;
>  #endif
>  };
> -
>  #define streq(x, y) (!strcmp((x), (y)))
>  
>  /*
> 
> diff ./tun.c~current~ ./tun.c
> --- ./tun.c~current~	2004-07-27 11:44:22.000000000 +1000
> +++ ./tun.c	2004-07-27 11:44:45.000000000 +1000
> @@ -88,6 +88,16 @@ dev_type_string (const char *dev, const 
>      }
>  }
>  
> +int
> +net_type_enum (const char *net)
> +{
> +   if (strcmp(net, "ptp") == 0)
> +     return NET_TYPE_PTP;
> +   else if (strcmp(net, "subnet") == 0)
> +     return NET_TYPE_SUBNET;
> +   return NET_TYPE_UNDEF;
> +}
> +
>  const char *
>  dev_component_in_dev_node (const char *dev_node)
>  {
> @@ -345,6 +355,7 @@ init_tun (const char *dev,       /* --de
>  	  const char *dev_type,  /* --dev-type option */
>  	  const char *ifconfig_local_parm,          /* --ifconfig parm 1 */
>  	  const char *ifconfig_remote_netmask_parm, /* --ifconfig parm 2 */
> +	  const char *net_type,  /* --net-type option */
>  	  in_addr_t local_public,
>  	  in_addr_t remote_public)
>  {
> @@ -355,6 +366,7 @@ init_tun (const char *dev,       /* --de
>    clear_tuntap (tt);
>  
>    tt->type = dev_type_enum (dev, dev_type);
> +  tt->nettype = net_type_enum (net_type);
>  
>    if (ifconfig_local_parm && ifconfig_remote_netmask_parm)
>      {
> 
> diff ./tun.h~current~ ./tun.h
> --- ./tun.h~current~	2004-07-27 11:44:22.000000000 +1000
> +++ ./tun.h	2004-07-27 11:44:45.000000000 +1000
> @@ -112,19 +112,12 @@ struct tuntap_options {
>  #define	NET_TYPE_PTP	2	/* two IP addresses */
>  #define	NET_TYPE_SUBNET 3	/* an IP address and a subnet mask */
>  
> -static inline dev_to_net(int dev)
> -{
> -	/* values for NET_TYPE cunning chosen to match
> -	 * DEV_TYPE for which they match 
> -	 */
> -	return dev;
> -}
> -
>  struct tuntap
>  {
>  # define TUNNEL_TYPE(tt) ((tt) ? ((tt)->type) : DEV_TYPE_UNDEF)
> -# define NET_TYPE(tt) (dev_to_net(TUNNEL_TYPE(tt)))
> +# define NET_TYPE(tt) ((tt) ? (tt)->nettype :NET_TYPE_UNDEF)
>    int type; /* DEV_TYPE_x as defined in proto.h */
> +  int nettype; /* NET_TYPE_x */
>  
>    bool did_ifconfig_setup;
>    bool did_ifconfig;
> @@ -208,6 +201,7 @@ struct tuntap *init_tun (const char *dev
>  			 const char *dev_type,  /* --dev-type option */
>  			 const char *ifconfig_local_parm,          /* --ifconfig parm 1 */
>  			 const char *ifconfig_remote_netmask_parm, /* --ifconfig parm 2 */
> +			 const char *net_type,  /* --net-type option */
>  			 in_addr_t local_public,
>  			 in_addr_t remote_public);
>  
> 



-- 




