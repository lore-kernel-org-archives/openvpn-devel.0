Date: Fri, 3 Dec 2021 17:18:59 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2116536034.296245.1638548339523@...2642...>
In-Reply-To: <20211202125455.2593763-1-arne@...1227...>
References: <20211202125455.2593763-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Make --nobind default for --pull
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

> Arne Schwabe <arne@...1227...> hat am 02.12.2021 13:54 geschrieben:
>  
> -    if (ce->proto == PROTO_TCP_CLIENT && !ce->local
> -        && !ce->local_port_defined && !ce->bind_defined)
> -    {
> -        ce->bind_local = false;
> -    }
>  
> -    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local
> -        && !ce->local_port_defined && !ce->bind_defined)
> +    bool need_bind = ce->local || ce->local_port_defined || ce->bind_defined;
> +    bool uses_socks = ce->proto == PROTO_UDP && ce->socks_proxy_server;
> +
> +    if (!need_bind && (ce->proto == PROTO_TCP_CLIENT || uses_socks || o->pull))
>      {
>          ce->bind_local = false;
>      }

The refactoring makes it very hard to see what the actual change is. Maybe it would be better to split this in two commits?

The only actual change in behavior is the "|| o->pull", right?

Regards,
  Frank

--
Frank Lichtenheld

