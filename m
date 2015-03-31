Message-ID: <551A6EAA.8010109@...1114...>
Date: Tue, 31 Mar 2015 11:53:46 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <551A5509.702@...277...>
In-Reply-To: <551A5509.702@...277...>
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Jiri Horky <jiri.horky@...277...>, openvpn-devel@lists.sourceforge.net
Cc: FF Systems <ff-system@...2025...>

On 31/03/15 10:04, Jiri Horky wrote:
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

Just to summarize what was said on the IRC chat as well.

The frame_set_mtu_dynamic() sets the *dynamic* MTU on the *control
channel*.  That should never go below TUN_MTU_MIN.

It's good that you've found a potential bug, which is improved by
increasing the TUN_MTU_MIN.  However, I believe it is wrong to just
increase that value and be happy.  We need to understand better why the
dynamic MTU on the control channel isn't set to a higher value in the
TLS handshake process.

You mentioned you saw in your logs:

    Control Channel MTU parms [ L:1558 D:138 EF:38 EB:0 ET:0 EL:0 ]

The D: field says here the dynamic MTU is starting at 138, while the L:
is the link MTU.  Could you please enable debug logging and set
verbosity level to 7 and see if you find any "MTU DYNAMIC mtu=" messages
in your log file?  That should give an indication if the dynamic MTU is
changing at all.


-- 
kind regards,

David Sommerseth

