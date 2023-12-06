Message-ID: <b9228700-d383-46b0-9f19-c0270025fb5c@...1227...>
Date: Wed, 6 Dec 2023 15:28:13 +0100
MIME-Version: 1.0
References: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
Subject: Re: [Openvpn-devel] [PATCH] fix(ssl): init peer_id when init
 tls_multi
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
To: yatta <ytzhang01@...2752...>, openvpn-devel@lists.sourceforge.net
Cc: pushan <62173185+pushan01@...2243...>

Am 19.10.23 um 19:12 schrieb yatta:
> From: pushan <62173185+pushan01@...2243...>
> 
> When openvpn run in UDP server mode, if ssl connections reach the max clients, the next connection would be failed in `multi_create_instance` and the half connection will be close in `multi_close_instance`, which may lead array `m->instances[0]`  covered unexpectedly and make the first connection  interrupt, this patch fix this problem by init `peer_id` with `MAX_PEER_ID` in `tils_multi_init`.

A bit more explanaition on this:

When we create an instance in multi_create_instance we call

inherit_context_child(&mi->context, &m->top);

which in turn calls the tls_multi_init that is patched here.

When I encounter an error during the creation in multi_create_instance 
we call multi_close_instance in the goto err branch. That 
multi_close_instance clears the instance from the dict if the peer_id is 
not MAX_PEER_ID.

We probably should refactor this to be a bit cleaner in the future.

Acked-By: Arne Schwabe <arne@...1227...>

