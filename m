Message-ID: <4AFAD781.900@...1277...>
Date: Wed, 11 Nov 2009 15:25:53 +0000
From: Dunc <dunc@...1277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Questions related to the SSL renegotiation
	vulnerability
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
To: openvpn-devel@lists.sourceforge.net

Hi all,

Apologies in advance if I'm just not understanding something here.

Following on from the recent SSL renegotiation problem, we're assessing
what we should do with all our SSL services, and as we use OpenVPN in
several places, this is on the list.

I thought that OpenVPN does renegotiations when re-keying, so at first I
thought I'd try and turn it off at the server end. From reading the docs
and testing I now know that it's not good enough as by default clients
will want to re-key after 1 hour unless it is turned off in the client
config too.

It might be hard to ensure that all our customers adjust their config
properly, so I'd rather deal with this at the server end only, so my
next thought was to install openssl-0.9.8l which bans renegotiation. I
figured this would make the VPN drop once an hour, but figured that's
not so bad in the grand scheme of things, and if it's really a problem
for anyone we can fix it by having them adjust the client config. This
was round seems more favourable as I can be sure renegotiations are
disabled, and work around the fallout.

So, I installed the latest openssl on a test box, and compiled openvpn.
I set the reneg-sec option to 40s on my client and fired up the VPN,
fully expecting it to bounce after 40s. Instead, what I see is this
message in the logs:-

Nov 11 14:13:51 2009 us=763149 TLS: soft reset sec=0 bytes=314/0 pkts=6/0

and then both ends seem to agree on some new crypto, and everything
carries on.


At first I thought maybe what OpenVPN does isn't the same as SSL
renegotiation and I had no need to worry anyway, but then I found this
thread...

http://article.gmane.org/gmane.network.openvpn.user/28105

where there is discussion about adding an option to openvpn to disable
it, so I now think I should indeed be concerned, but I must be missing
something obvious, and wondered if anybody here can help me.

I've checked with openssl s_server and s_client that my new openssl does
indeed ban renegotiation, so I wonder exactly what OpenVPN is doing
during rekeying.

Thanks in advance if anyone can shed light on this for me, and once
again sorry if I'm just misunderstanding, which is quite possible :-)

Cheers,

Dunc

