References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-2-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e6086ea8-f5e2-7ef6-0302-a739cc6a9ad0@...1227...>
Date: Wed, 8 Jun 2016 14:50:34 +0200
MIME-Version: 1.0
In-Reply-To: <1465388443-15484-2-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] Don't limit max incoming message
 size based on c2->frame
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net



Am 08.06.16 um 14:20 schrieb Steffan Karger:
> "Be conservative in what you send, be liberal in what you accept"
>
> When receiving packets, the real limitation of how much data we can accept
> is the size of our internal buffers, not the maximum size we expect
> incoming packets to have.
>
> I ran into this while working on cipher negotiation, which will need
> separate bookkeeping for the required internal buffer size, and the
> link/tun MTU.  Basing this code on the buffer size instead of c2->frame
> makes that easier.  A nice side-effect of this change is that it
> simplifies the code.
>
> This should also reduce the impact of using asymmetric tun/link MTU's,
> such as in trac ticket #647.
>
>
ACK I think this one should be safe.

Arne

