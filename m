Message-ID: <d4f91ecd-8d26-ee73-9fda-25823bdbeedb@...1227...>
Date: Sat, 29 Jan 2022 16:07:59 +0100
MIME-Version: 1.0
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-7-arne@...1227...>
In-Reply-To: <20220101162532.2251835-7-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 06/14] Update fragment and mssfix
 related warnings
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
To: openvpn-devel@lists.sourceforge.net

c->options.ce.fragment, c->options.ce.mssfix);
> +    }
> +    if (c->options.ce.fragment > 0 && c->options.ce.mssfix > 0
> +        && c->options.ce.fragment_encap != c->options.ce.mssfix_encap)

Note that fragment_encap is added in

[Openvpn-devel] [PATCH v3 09/14] Add mtu paramter to --fragment and 
change fragment calculation

and this patch needs to added after that patch to avoid an compile error.

Arne

