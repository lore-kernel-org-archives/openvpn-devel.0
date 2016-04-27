References: <CAAWBBYMWbgCy74zU6OWT+T9eopRNbBF-K7HeD27KRGwGXOkAeg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5720822C.20407@...1227...>
Date: Wed, 27 Apr 2016 12:11:08 +0300
MIME-Version: 1.0
In-Reply-To: <CAAWBBYMWbgCy74zU6OWT+T9eopRNbBF-K7HeD27KRGwGXOkAeg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Added client-ip option to NAT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Rafael Gava <gava100@...277...>, openvpn-devel@lists.sourceforge.net


>  
> +  if (network && !strcmp(network, "client-ip"))
> +    {
> +      msg (M_INFO, "*** client-nat client-ip detected...");
> +      e.network = 0xFFFFFFFF;
> +    } else {

I am not sure that this message is useful. It does not provide any
additional information to the user. Also please add a comment that you
are using network 0xFFFFFFFF as special marker for client-ip.

>    e.network = getaddr(0, network, 0, &ok, NULL);
>    if (!ok)
>      {
>        msg(msglevel, "client-nat: bad network: %s", network);
>        return;
>      }
> +    }
> +    

Whitespace change.
>    e.netmask = getaddr(0, netmask, 0, &ok, NULL);
>    if (!ok)
>      {
> @@ -263,3 +270,34 @@ client_nat_transform (const struct
> client_nat_option_list *list,
>  }
>      }
>  }
> +
> +/*
> +* Replaces the client_ip token with the IP received from OpenVPN
> +*/
> +bool 
> +update_client_ip_nat(struct client_nat_option_list *dest, in_addr_t
> local_ip)
> +{
> +  int i;
> +  bool ret = false;
> +
> +  if (!dest)
> +    return ret;
> +
> +  for (i=0; i <= dest->n; i++) 
> +    {
> +      struct client_nat_entry *nat_entry = &dest->entries[i];
> +      if (nat_entry && nat_entry->network == 0xFFFFFFFF) 
> +        {
> +          struct in_addr addr;
> +          
> +          nat_entry->network = ntohl(local_ip);
> +          addr.s_addr = nat_entry->network;
> +          char *dot_ip = inet_ntoa(addr);
> +
> +          msg (M_INFO, "CNAT - Updating NAT table from client-ip to:
> %s", dot_ip); 
> +          ret = true;
> +        }
> +    }
> +
> +  return ret;
> +}
> diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
> old mode 100644
> new mode 100755
> index a5779e1..156e84c
> --- a/src/openvpn/clinat.h
> +++ b/src/openvpn/clinat.h
> @@ -62,4 +62,6 @@ void client_nat_transform (const struct
> client_nat_option_list *list,
>    struct buffer *ipbuf,
>    const int direction);
>  
> +bool update_client_ip_nat(struct client_nat_option_list *dest,
> in_addr_t local_ip);
> +
>  #endif
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> old mode 100644
> new mode 100755
> index c5c0ab6..f54bc14
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1481,6 +1481,8 @@ do_open_tun (struct context *c)
>        c->c1.tuntap->post_open_mtu,
>        SET_MTU_TUN | SET_MTU_UPPER_BOUND);
>  
> +update_client_ip_nat(c->options.client_nat, c->c1.tuntap->local);
> +
>        ret = true;
>        static_context = c;
>  #ifndef TARGET_ANDROID
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> old mode 100644
> new mode 100755
> index 2f8915d..c08e775
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -223,6 +223,7 @@ static const char usage_message[] =
>    "--redirect-private [flags]: Like --redirect-gateway, but omit
> actually changing\n"
>    "                  the default gateway.  Useful when pushing private
> subnets.\n"
>    "--client-nat snat|dnat network netmask alias : on client add 1-to-1
> NAT rule.\n"
> +  "                  Set the network parameter to 'client-ip' to use
> the received ip from OpenVPN Server.\n"
>  #ifdef ENABLE_PUSH_PEER_INFO
>    "--push-peer-info : (client only) push client info to server.\n"
>  #endif
> -- 
> 1.7.9.5
> 
> 
> 
> ------------------------------------------------------------------------------
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


