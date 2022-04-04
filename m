Date: Mon, 4 Apr 2022 18:04:51 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1380100403.538559.1649088291462@...2642...>
In-Reply-To: <20220402070902.30282-5-a@...2181...>
References: <20220402070902.30282-1-a@...2181...>
 <20220402070902.30282-5-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/7] ovpn-dco: introduce linux
 data-channel offload support
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Documentation review:

> Antonio Quartulli <a@...2181...> hat am 02.04.2022 09:08 geschrieben:
> diff --git a/Changes.rst b/Changes.rst
> index ceb0b268..23f66716 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -69,6 +69,13 @@ Improved ``--mssfix`` and ``--fragment`` calculation
>      account and the resulting size is specified as the total size of the VPN packets
>      including IP and UDP headers.
>  
> +Data channel offloading with ovpn-dco
> +    2.6.0+ implements support for data-channel offloading where the data packets
> +    are directly processed and forwarded in kernel space thanks to the ovpn-dco
> +    kernel module. The userspace openvpn program acts purely as a control plane
> +    application.
> +
> +
>  Deprecated features
>  -------------------
>  ``inetd`` has been removed
> diff --git a/README.dco.md b/README.dco.md
> new file mode 100644
> index 00000000..27c166b9
> --- /dev/null
> +++ b/README.dco.md
> @@ -0,0 +1,129 @@
> +OpenVPN data channel offload
> +============================
> +2.6.0+ implements support for data-channel offloading where the data packets
> +are directly processed and forwarded in kernel space thanks to the ovpn-dco
> +kernel module. The userspace openvpn program acts purely as a control plane
> +application.
> +
> +
> +Overview of current release
> +---------------------------
> +- See the "Limitations by design" and "Current limitations" sections for
> +  features that are not and/or will not be supported by OpenVPN + ovpn-dco
> +
> +
> +Getting started (Linux)
> +-----------------------
> +
> +- Use a recent Linux kernel. Ubuntu 20.04 (Linux 5.4.0) and Ubuntu 20.10
> +  (Linux 5.8.0) are known to work with ovpn-dco.

Remove Ubuntu 20.10 here or replaced by a more current release. It is just
not relevant anymore.

[...]
> +DCO and P2P mode
> +----------------
> +DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
> +The P2P mode is useful for scenarios when the OpenVPN tunnel should not interfere with
> +overall routing and behave more like a "dumb" tunnel like GRE.
> +
> +However, DCO requires DATA_V2 to be enabled this requires P2P with NCP capability, which
> +is only available in OpenVPN 2.6 and later.

However, DCO requires DATA_V2 to be enabled. This requires P2P with NCP capability, which
is only available in OpenVPN 2.6 and later.

[...]
> +Routing with ovpn-dco
> +---------------------
> +The ovpn-dco kernel module implements a more transparent approach to
> +configuring routes to clients (aka 'iroutes') and consults the kernel
> +routing tables for forwarding decisions.
> +
> +- Each client has an IPv4 VPN IP and/or an IPv6 assigned to it.

- Each client has an IPv4 and/or an IPv6 VPN IP assigned to it.

> +- Additional IP ranges can be routed to a client by adding a route with
> +  a client VPN IP as the gateway/nexthop (i.e. ip route add a.b.c.d/24 via $VPNIP).
> +- Due to the point above, there is no real need to add a companion --route for
> +  each --iroute directive, unless you want to blackhole traffic when the specific
> +  client is not connected.
> +- No internal routing is available. If you need truly internal routes, this can be
> +  achieved either with filtering using `iptables` or using `ip rule`.
> +- client-to-client behaviour, as implemented in userspace, does not exist: packets
> +  are always sent up to the tunnel interface and then back in to be routed to the
> +  destination peer.

I have no idea what "back in" means in this sentence? Is this just me or is there
something missing?

> +Limitations by design
> +----------------------
> +- Layer 3 (dev tun only)
> +- only AEAD ciphers are supported and currently only
> +  Chacha20-Poly1305 and AES-GCM-128/192/256
> +- no support for compression or compression framing
> +  - see also `--compress migrate` option to move to a setup with compression

"without compression"

> +- various features not implemented since have better replacements

- various features are not implemented since they have better replacements

> +  - --shaper, use tc instead
> +  - packet manipulation, use nftables/iptables instead
> +- OpenVPN 2.4.0 is the minimum peer version.
> +  - older version are missing support for the AEAD ciphers

"versions"

> +- topology subnet is the only supported `--topology` for servers
> +- iroute directives install routes on the host operating system, see also
> +  routing with ovpn-dco

"Routing with ovpn-dco"

> diff --git a/configure.ac b/configure.ac
> index 9c898718..fa00abb5 100644
> --- a/configure.ac
> +++ b/configure.ac
[...]
> @@ -760,6 +767,26 @@ PKG_CHECK_MODULES(
>  	[]
>  )
>  
> +
> +
> +if test "$enable_dco" = "yes"; then
> +dnl
> +dnl Include generic netlink library used to talk to ovpn-dco
> +dnl
> +
> +	PKG_CHECK_MODULES([LIBNL_GENL],
> +			  [libnl-genl-3.0 >= 3.2.29],
> +			  [have_libnl="yes"],
> +			  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
> +	)

3.2.29 or 3.4.0 ?

[...]
> diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
> index 5157c561..cdec9502 100644
> --- a/doc/man-sections/advanced-options.rst
> +++ b/doc/man-sections/advanced-options.rst
> @@ -91,3 +91,16 @@ used when debugging or testing out special usage scenarios.
>    *(Linux only)* Set the TX queue length on the TUN/TAP interface.
>    Currently defaults to operating system default.
>  
> +--disable-dco
> +  Disables the opportunistic use the data channel offloading if available.

"of the data channel offloading"

> +  Without this option, OpenVPN will opportunistically use DCO mode if
> +  the config options and the running kernel supports using DCO.
> +
> +  Data channel offload currently requires data-ciphers to only contain
> +  AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the
> +  ovpn-dco module.
> +
> +  Note that some options have no effect or not available when
> +  DCO mode is enabled.

"are not available" ? Still not a great sentence but at least better
grammatically.

> +
> +  A platforms that do not support DCO ``disable-dco`` has no effect.

"On platforms" ?

> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
> index 08ee7bd3..40cf9a3c 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -321,6 +321,12 @@ fast hardware. SSL/TLS authentication must be used in this mode.
>    from the kernel to OpenVPN. Once in OpenVPN, the ``--iroute`` directive
>    routes to the specific client.
>  
> +  When using DCO, the extra ``--route`` directive is required only if the
> +  expected behaviour is to route the traffic for a specific network to the VPN
> +  interface also when the responsible client is not connected (traffic
> +  will then be dropped). In the other cases the ``--iroute`` directive is
> +  enough for DCO to fully configure the routing table.

I think this works better if you reorder it:

However, when using DCO, the ``--iroute`` directive is usually enough for DCO
to fully configure the routing table. The extra ``--route`` directive is
required only if the expected behaviour is to route the traffic for a specific
network to the VPN interface also when the responsible client is not connected
(traffic will then be dropped).

This puts the important information first.

> +#if defined(ENABLE_DCO)
> +
> +/**
> + * Check whether the options struct has any option that is not supported by
> + * our current dco implementation. If so it print a warning at warning level

remove "it"

> + * for the first conflicting option found and return true.
> + *
> + * @param msglevel  the msg level to use to print the warnings
> + * @param o         the optiions struct that hold the options

"options"

> + * @return          true if a conflict was detected, false otherwise
> + */
> +bool dco_check_option_conflict(int msglevel, const struct options *o);
[...]
> +
> +/**
> + * Possibly swaps or wipes keys from DCO

"swap or wipe" (to be consistent with all other functions"

> + * @param dco           DCO device context
> + * @param multi         TLS multi instance
> + */
> +void dco_update_keys(dco_context_t *dco, struct tls_multi *multi);
> +
> +/**
> + * Check whether ovpn-dco is available on this platform (i.e. kernel support is
> + * there)
> + *
> + * @param msglevel      level to print messages to
> + * @return              true if ovpn-dco is available, false otherwise
> + */
> +bool dco_available(int msglevel);
> +
> +/**
> + * Installs a DCO in the main event loop

"Install"

[...]

Regards,
--
Frank Lichtenheld

