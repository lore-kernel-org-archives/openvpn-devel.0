Message-ID: <b7160a8e-8d4c-606d-1b08-de9f069d3152@...2181...>
Date: Fri, 13 Jan 2023 14:32:47 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230113080745.82783-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230113080745.82783-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix
 OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT breakage on FreeBSD+DCO
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 13/01/2023 09:07, Gert Doering wrote:
> commit 67c4eebdae introduces a new peer disconnect reason (transport
> disconnected, aka "TCP session closed") which breaks compilation on
> FreeBSD - OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT not part of the
> enum in freebsd_dco.h, and no kernel support for TCP anyway.
> 
> This patch is an intermediate bandaid, making the offending code in
> multi.c "linux only" while a better solution is discussed.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Hi,

as we are discussing in a nother thread and on IRC, we need to come up 
with a better solution that is flexible enough to prevent this from 
happening in the future.

There are some floating ideas.
Anyway, the discussion will continue in the other thread.

Regarding this patch:
Acked-by: Antonio Quartulli <a@...2181...>

Maybe we need a fbsd14 buildbot?

Cheers,


-- 
Antonio Quartulli

