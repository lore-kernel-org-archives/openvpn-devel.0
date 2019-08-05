References: <20190805092529.9467-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1d0b4b35-1374-fde2-910a-e07db9a60b60@...2181...>
Date: Mon, 5 Aug 2019 13:11:12 +0200
MIME-Version: 1.0
In-Reply-To: <20190805092529.9467-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 0/6] sitnl follow-up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

FYI,

this patchset has undergone buildbot, travis-ci and gitlab-ci testing
and nothing out of the ordinary came out.

Regards,

On 05/08/2019 11:25, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> Hi all, 
> 
> this small patchset aims at tackling most of the concerns raised by Gert
> while merging the sitnl introduction patchset.
> 
> All patches are fairly small, but they are a bit intertwined (they
> change nearby lines), therefore it would be better to merge them in the
> provided order to avoid ugly merge conflicts.
> 
> 
> Cheers,
> 
> 
> Antonio Quartulli (6):
>   sitnl: harden strncpy() by forcing arguments to have the same length
>   networking/best_gw: remove useless prefixlen parameter
>   networking: extend API for better memory management
>   tun.c: undo_ifconfig_ipv4/6 remove useless gc argument
>   networking_sitnl.c: uncrustify file
>   route.c: simplify ifdef logic
> 
>  src/openvpn/networking.h          | 33 +++++++++--
>  src/openvpn/networking_iproute2.c | 78 ++++++++++---------------
>  src/openvpn/networking_iproute2.h |  1 +
>  src/openvpn/networking_sitnl.c    | 96 +++++++++++++++++++++----------
>  src/openvpn/openvpn.c             |  1 +
>  src/openvpn/route.c               | 32 ++++++-----
>  src/openvpn/route.h               |  6 +-
>  src/openvpn/tun.c                 | 28 ++++-----
>  8 files changed, 165 insertions(+), 110 deletions(-)
> 

-- 
Antonio Quartulli

