Message-ID: <01d701c1dbba$1db49b20$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <1017760165.9891.85.camel@...2...><008901c1da97$e4ce0b70$1000000a@...4...> <1017818817.1524.56.camel@...2...> <01ba01c1dbb5$2a3367a0$1000000a@...4...> <1017910625.1562.14.camel@...2...>
Subject: Re: [Openvpn-devel] More BSD TUN info.
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Apr  4 01:22:04 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Janne Johansson <jan.johansson@...1...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 2002-04-04 at 10:46, James Yonan wrote:
> >I don't know the openvpn data format, but if 45000054 is some sort of
> openvtun identifier, you/we/I could add some code that checked for
> 00000002 followed by 45000054 and then strip the first u_int_32 from
> the packet and go on. Perhaps a --remote-is-bsd or something similar?
>
> Openvpn doesn't look at the tunnel data... it just encrypts, decrypts,
> forwards etc.  The 45000054 is the beginning of the IP header of the
packets
> going over the tunnel.

Dang. =)
(Sorry for mistyping it as openvtun)
Still, it's just as well, since that data would look different when
encrypted anyway.

> Yeah, an option might be right thing.  So --remote-is-bsd would remove the
> AF_INET from incoming packets and add them to outgoing packets.  A bit of
a
> kludge.

>Yes, but since BSD wont let you choose if you want it or not, and the
chance of changing Linux-TUN-drivers now is slim, I guess it has to be
the application that takes care of this. I'll try to make a patch and
test it, and send you the diff later.

Some thoughts:

* probably the best place to add/remove the AF_INET is by calling some
routine in the main event loop in openvpn.c, conditional on --remote-is-bsd.

* add and remove u_int_32 by manipulating struct buffer (see buf_prepend and
buf_advance in particular).

* remember that when you add a new buffer prepend item, you must modify the
appropriate struct frame which will contain the MTU parms, so that
everything gets sized right.  For an example, see
crypto_adjust_frame_parameters().

>I'll also try to make a diff to let BSD tun devices ioctl away that
particurlar u_int_32.

Good idea.

>BTW, is it just me or is the sourceforge lists slow?
The turnaround time seems like hours to me.

Doesn't seem too bad to me.

James




