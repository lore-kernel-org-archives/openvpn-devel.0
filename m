MIME-Version: 1.0
References: <20200924064452.1001-1-simon@...2293...>
 <20200924064452.1001-2-simon@...2293...>
In-Reply-To: <20200924064452.1001-2-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 24 Sep 2020 11:56:08 +0300
Message-ID: <CAGyAFMVnvSgHrw0cbvdzmeE5Orp7wg26cPcGi8f0x0_Kcz-2MA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] netsh: Clear existing IPv6 DNS
 servers before configuring new ones
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> When there are no IPv6 DNS published, the adapter state is not
> sanitized and might contain IPv6 DNS server from a previous session.

In this case, shouldn't the "set dns" call below overwrite the previous value?

> netsh_ifconfig_options() clears DNS servers for IPv4 already.

Agreed, let's do it for consistency.

>   * The list of dns servers currently set on the interface
>   * are cleared first.

Either existing comment lied or "implicit clear" was assumed because
of the "set dns" call.
But now it is fine, since we have real clearing.

Stared and the code, built and tested on MSVC/Win10.

Acked-by: Lev Stipakov <lstipakov@...277...>

