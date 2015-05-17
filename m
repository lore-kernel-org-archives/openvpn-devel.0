Message-ID: <5557E966.5070901@...1490...>
Date: Sun, 17 May 2015 13:05:42 +1200
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <55529792.8020708@...2030...>	<5553C59B.5070905@...2030...>
	<10206993.113359.1431677067033.JavaMail.root@...1893...>
In-Reply-To: <10206993.113359.1431677067033.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] OpenVPN and XOR patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 15/05/15 20:04, Lisa Minogue wrote:
> One thing to keep in mind with the Tor/obfsproxy and stunnel, is that once you get into lossy networks, you're going to find ovpn can become unusable.
> What's your definition of lossy networks?
>
>

I think the lossy comment is not a tunnelling issue - lossy networks
leads to majorly lossy VPNs in general. e.g. we've run Cisco IPSec VPN
tunnels over the Internet for 15 years and I can tell you the "rule of
thumb" is 1% packet loss on the Internet == 10% packet loss in IPSec
tunnels (and 10% is "agh!!! the network is down!!!"). So if you are
tunnelling openvpn through another layer, I can imagine it making things
even worse - but it's not the extra layer that's really to blame - it's
simply lossy network == unhappiness

Another anecdote: two weeks ago I was in a hotel where the dodgy WiFi
network had my laptop roaming between a working AP and a non-working AP
(which I could only diagnose because I vaguely know what I'm doing).
Every time I roamed to the non-working AP, my openvpn would time out and
then my laptop would roam back to the working AP and openvpn would
successfully re-initialize. This lead to a nearly unusable VPN
connection. However, I barely noticed this "flapping" within my web
browser which was accessing the Internet directly (stateless web pages -
without youtube of course ;-) - which made me think that if I was a
"normal" user, I'd be saying " the Internet is fine - it's the vpn
that's broken". I really doubt any vpn software could better compensate
for that corner case - and I think that fits the description of "lossy
network" well.

-- 
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


