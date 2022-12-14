MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
 <Y5pEEhAGyKzbNn8u@...1296...>
In-Reply-To: <Y5pEEhAGyKzbNn8u@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 15 Dec 2022 01:09:30 +0200
Message-ID: <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
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
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

Selva has asked about a build which includes this patch.

Here is MSI installer which incorporates required client patches

 - management: add timer to output BYTECOUNT
 - Introduce dco_get_peer_stats API and Windows implementation

and a new driver version (0.8.3) with stats fixes.

https://github.com/lstipakov/openvpn-build/actions/runs/3699097077

-Lev

