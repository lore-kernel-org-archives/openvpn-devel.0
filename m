From: Heiko Hund <heiko@...2662...>
Date: Mon, 27 Jun 2022 23:52:14 +0200
Message-ID: <9068765.LyCO4XW96P@...2664...>
In-Reply-To: <20180523192802.31611-1-a@...2181...>
References: <20180523192802.31611-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] do not push route-ipv6 entries that are also in
 the iroute-ipv6 list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Mittwoch, 23. Mai 2018 21:28:02 CEST Antonio Quartulli wrote: 
> -    if (o && o->push_list.head && o->iroutes)
> +    if (o && o->push_list.head && (o->iroutes || o->iroutes_ipv6))
[...]
> +                else if (p[0] && !strcmp(p[0], "route-ipv6") && !p[2])

I think it would make sense to check for o->iroutes_ipv6 here again, so that 
the address string parsing only happens if there's v6 iroute(s). And then also 
add a check for o->iroutes to the "route" if statement above. That might save 
a few cycles, but no big issue.

Besides that: ACK

Heiko



