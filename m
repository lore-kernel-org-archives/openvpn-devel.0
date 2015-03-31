Message-ID: <551A5735.8040900@...1227...>
Date: Tue, 31 Mar 2015 10:13:41 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <551A5509.702@...277...>
In-Reply-To: <551A5509.702@...277...>
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
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
To: openvpn-devel@lists.sourceforge.net



Am 31.03.15 um 10:04 schrieb Jiri Horky:
> Hi all,
>
> continuing yesterday's IRC discussion. I would like to ask whether you
> can think of a reason why TUN_MTU_MIN is set to only 100 bytes, and
> maybe more importantly, why this value is effectively enforced in function
>
> static void
> tls_init_control_channel_frame_parameters(const struct frame
> *data_channel_frame,
>                  struct frame *frame)
> ....
>   /* set dynamic link MTU to minimum value */
>   frame_set_mtu_dynamic (frame, 0, SET_MTU_TUN);
>
> We were debugging slow connection establishment on links with higher RTT
> (>200ms), which takes about 7seconds. We tracked the problem down to
> certificate handshake on a control channel, where client and server need
> to exchange certificates which are about 3KiB each, and because the
> enforced low MTU during tls init, and the fact that there are at maximum
> 4 unacknowledged packets on wire (CONTROL_SEND_ACK_MAX), it takes quite
> a lot of round trips to transfer it (it is clearly visible in wireshark,
> that the openvpn fragments are exactly of 100Bytes).
>
> I tried to increase the TUN_MTU_MIN to 1000 (which should be safe on
> nowadays Internet), which immediately helped.
>
> Before I make the change on our servers, I would like to understand
> whether I may not break something by doing so.
>
At least for IPv6 the minimum mtu of 1000 should be more than fine (IPv6
MTU MUST be at 1280).

When 56k modems were still common, they often used a MTU of 576, so for
a 56k this would break.

But setting to 576 should be fine, from RFC 791:

All hosts must be prepared
    to accept datagrams of up to 576 octets (whether they arrive whole
    or in fragments).  It is recommended that hosts only send datagrams
    larger than 576 octets if they have assurance that the destination
    is prepared to accept the larger datagrams.

Arne

