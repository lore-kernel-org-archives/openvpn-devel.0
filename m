Message-ID: <51711DD4.5080803@...1737...>
Date: Fri, 19 Apr 2013 11:35:00 +0100
From: Ed W <lists@...1737...>
MIME-Version: 1.0
References: <5170496A.6000000@...1737...>
	<20130418204455.GW29506@...1296...>
	<1CED409804E2164C8104F9E623B08B9013BC630BF0@...1436...>
	<51711363.4070802@...1737...>
	<1CED409804E2164C8104F9E623B08B9013BC630D62@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013BC630D62@...1436...>
Subject: Re: [Openvpn-devel] Support for libsodium?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 19/04/2013 11:13, Adriaan de Jong wrote:

> I misunderstood your wish to completely get rid of TLS. That would require a major overhaul in the way the control channel in OpenVPN is handled. OpenVPN is completely centered around the idea of a TLS control channel across which data channel keys are negotiated. Although I'd love to see that kind of flexibility in OpenVPN, the code base is nowhere near ready for that. It's a nice challenge though :).
>
> Another, more philosophical, question is whether the product is still OpenVPN after such a change. It's certainly not line-compatible with OpenVPN.

Hmm, can you give me a pointer to relevant code so that I can get my 
hands dirty?

I'm still a bit unsure what you mean by "TLS" though?  To my mind it's a 
protocol for negotiating parameters and implementing crypto. However, I 
*think* that what you might mean is that it's "an API which handles 
client session state, timeouts and creating packets to put on the network"?

Perhaps I need to get my hands dirty here... Sounds like we would need 
to introduce an abstraction for the TLS session handling so that this 
feels clean?

Note, I have a longer term interest here in multi-homing.

Cheers

Ed W

