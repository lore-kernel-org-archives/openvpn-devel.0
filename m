Message-ID: <4FA92976.6090000@...1114...>
Date: Tue, 08 May 2012 16:11:02 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
	<4FA8F1E2.6080604@...1114...>
	<CAArKS8hNQ+xE-o90wKNLO9LPk3kQbz8EGhrVJATeY7HjpO9s=w@...278...>
In-Reply-To: <CAArKS8hNQ+xE-o90wKNLO9LPk3kQbz8EGhrVJATeY7HjpO9s=w@...278...>
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Tom Kent <lists@...1718...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/05/12 15:50, Tom Kent wrote:
>> But... I don't think that OpenVPN is the right approach as it is
> not peer-to-peer solution.
> 
> I agree that this is not the optimal solution, especially for
> large/high bandwith setups. I was just looking for something that I
> could get going with what I have today. My ideal setup would be a
> central arbiter that hands out routing and encryption info each for
> each p2p connection that is desired, but I don't know of anything
> that does this currently.
> 
>> If your hypervisor uses a tap interface, you can just have
>> openvpn use
> that tap interface "right away".
> 
> I guess I need to read up a bit more on how tap interfaces work. I
> guess I assumed that the hypervisor was controlling that, so there
> wouldn't be room for openvpn to jump on it. But assuming it is as
> you say, that seems very promising, and much easier to get going
> than I though.

Think of tap devices as a software based NIC, where a physical NIC
would have the Ethernet cable a TAP device have a socket where you can
read/write data from/to in an application instead.  TAP devices are
layer 2 capable, so it transports Ethernet frames between the TAP
device and the application socket.

TUN devices are almost the same, except they function on the IP layer,
not the Ethernet layer.  So instead of Ethernet frames, you get IP
packets instead in the application.

To use virtual devices in a bridge you need TAP devices, as bridges
depends on Ethernet frames.

> I think I'm going to try this out here in the next few days, and
> see how easily I can get something setup. If I have luck I'll put
> up a blog post about it.

Cool!  Thanks a lot!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+pKXIACgkQDC186MBRfro5ZQCcDzKzbq84/f4zrI/UeJyLQcdR
kAcAoK1agIgeyPrVinpQgXITa2fNYiVb
=odIc
-----END PGP SIGNATURE-----

