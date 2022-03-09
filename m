Message-ID: <a3f031c2-d845-72c4-9ce8-6edb84b5d914@...1227...>
Date: Wed, 9 Mar 2022 13:40:32 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220308230621.1532809-1-heiko@...2662...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220308230621.1532809-1-heiko@...2662...>
Subject: Re: [Openvpn-devel] [PATCH] add support for --dns option
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
To: Heiko Hund <heiko@...2662...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 09.03.22 um 00:06 schrieb Heiko Hund:
> +
> +bool dns_server_priority_parse(long *priority, const char *str, bool pulled);
> +struct dns_server* dns_server_get(struct dns_server **entry, long priority, struct gc_arena *gc);
> +void dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_arena *gc);
> +bool dns_server_addr_parse(struct dns_server *server, const char *addr);
> +bool dns_options_verify(int msglevel, const struct dns_options *o);
> +struct dns_options clone_dns_options(const struct dns_options o, struct gc_arena *gc);
> +void dns_options_preprocess_pull(struct dns_options *o);
> +void dns_options_postprocess_pull(struct dns_options *o);
> +void setenv_dns_options(const struct dns_options *o, struct env_set *es);
> +void show_dns_options(const struct dns_options *o);

These new functions are missing doxygen comments. We generally have the 
doxygen comments in the header files rather than in the c files.

> +--dns args
> +  Client DNS configuration to be used with the connection.

This man page section sounds like all options are supported on all 
platforms while currently that is not the case. An explicit warning etc 
that says that some options like port, dnssec, doh etc are not supported 
on certain platforms should be included and also what happens if they 
are not.

>  The ``--dns`` option will eventually obsolete the ``--dhcp-option`` directive.
> +  Until then it will add configuration at the places ``--dhcp-option`` puts it
> +  and will override it if both are given.

Is dhcp-option ignored when dns is present by newer client or are they 
mixed? This is a bit vague.


> +  long priority;

why a type that is 32 bit on some platforms and 64 bit on others? Either 
go with just int if 32 bit is enough or use long long or int64_t if we 
need 64 but long is a weird type.

> +            name_ok &= openvpn_snprintf(env_name, sizeof(env_name), "dns_server_%d_address4", i);

bitwise and with a bool feels wrong. We should use && instead of & for 
boolean logic.

> +  enum dns_security dnssec;
> +  enum dns_server_transport transport;
> +  char *sni;
> +};

That should be probably be a const char* instead of a modifable char*

>          gc_free(&o->gc);
> +        gc_free(&o->dns_options.gc);

having an extra gc in this way feels a bit strange. Since this is the 
only time it is initialised you can just as well just use o->gc instead.


> +        struct gc_arena dns_gc = gc_new();;

extra ;
> +        /* Free DNS options and reset them to pre-pull state */
> +        gc_free(&o->dns_options.gc);

There is an additional free for the gc here that has no matching 
gc_init. If your goal is to have a gc for the life time of prepull etc, 
then it is better to put it there as that is easier to see its lifetime 
than to have it only for DNS where the lifetime/ownership is not so clear.


I see also that this code makes no attempt to remove/refactor the old 
DHCP code. The only thing I see is the tuntap_options_copy_dns code. 
What the supposed way forward here? That also raises the question about 
platform specific code. Does that code now need two implementations? One 
for installing options from the dhcp structs and one from the DNS struct?

Some idea how this is going to go forward would be good.

Arne

