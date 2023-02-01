MIME-Version: 1.0
References: <20230201041831.2259419-1-selva.nair@...277...>
 <CAGyAFMVw=QzQDaBo6RE9Juh5+SObuCmAptT+yh1X44DL2g7bBQ@...278...>
 <CAKuzo_jAfKrpRpi2YHRwwXSGVz_NSy8gYwybLajFt4ZJyJ=MVg@...278...>
In-Reply-To: <CAKuzo_jAfKrpRpi2YHRwwXSGVz_NSy8gYwybLajFt4ZJyJ=MVg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 1 Feb 2023 18:16:58 +0200
Message-ID: <CAGyAFMU74M8k7EaVoWQ4H1w9XStFBWmqFKucebQ9wid-hmLgYg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] block-dns using iservice: fix a
 potential double free
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> Good point.  I have a version that splits "add" and "delete" actions into separate functions and does something like this.
>
> Please take a look here: https://github.com/selvanair/openvpn/tree/block-dns-fix
> The add and delete functions are in that order (with a forward declaration) only to make review easier (less changes with ignore-all-spaces), will move the latter up if it looks okay.

Looks good to me, especially without whitespaces
https://github.com/OpenVPN/openvpn/pull/235/files?diff=unified&w=1

> That said, if you have a better fix, I'm ready to review it in lieu of this.

My change is more intrusive, idea is to bail out if
get_interface_metrics fails and update undo_list only if both filters
and metrics are applied,

https://github.com/lstipakov/openvpn/commit/8c2d0de178e0771295764ea773596c13ff5f2aa6

It is a bit sloppy on metrics cleanup, though - for example if
get_interface_metric for ipv6 fails but ipv4 is not - it won't restore
ipv4 metrics. On the other hand this is unlikely to happen.

Also I replaced 0x%x with %u in win_block_dns_service() for
consistency. You may want to do it in your patch too :)


-- 
-Lev

