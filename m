Message-Id: <200210281224.g9SCOUe10646@...41...>
Subject: Re: [Openvpn-devel] QoS
From: "James Yonan" <jim@...41...>
In-Reply-To: <E1867SL-0005ML-00@...50...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 28 04:26:01 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Craig Knox <crg@...49...>, openvpn-devel@lists.sourceforge.net

Craig,

No, right now OpenVPN (and I believe the Linux TUN driver as well) has no special handling for QoS such as TOS pass through between different encapsulation layers (though it's an interesting idea).

You could, of course, apply QoS rules to OpenVPN's UDP connection or make use of OpenVPN's traffic shaping option (--shaper) for basic control over output speed.

By using multiple tunnels between the same hosts, each with different QoS rules, you could accomplish some of the same effect.

James

Craig Knox <crg@...49...> said:

> Hi there,
>    I use QoS routing and it works great except over openvpn/tun device. 
> 
>    Correct me if I am wrong but I think this is because the packets are
> encapsulated within a UDP packet with no regard to what the original
> packets TOS field was, so once it reaches a "real" device it is just
> treated as bulk even it was suppose to be for example minimum-delay.
> 
>    Is there anyway the TOS of the UDP packet could be set the match its
> payload's TOS? 
> 
> Cheers
> Craig
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




