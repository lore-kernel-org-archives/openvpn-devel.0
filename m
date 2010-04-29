Message-ID: <4BD8E485.9060701@...1299...>
Date: Thu, 29 Apr 2010 13:44:37 +1200
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <4BD83FC0.5090607@...515...>
	<1272463949884053500@...1315...>	<n2n9e0cf0bf1004280724s6c4280c6xb58950c706123e4c@...278...>
	<201004281638.57498.hhund@...194...>
In-Reply-To: <201004281638.57498.hhund@...194...>
Subject: Re: [Openvpn-devel] Any volunteer Windows devs to change OpenVPN
 proxying code to use "new" InternetQueryOption API?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 04/29/2010 02:38 AM, Heiko Hund wrote:
> If the service is started by the GUI it still makes sense to use user specific 
> proxy settings, doesn't it? One could consider auto-proxy for auto-started 
> VPNs a misconfiguration, as well. Or am I mislead?
>   
I think it's critical. Most enterprise networks have egress filtering
(ie default to blocking outbound with business-exceptions) and web
access via proxies. They will use WPAD (via HTTP or DHCP) or perhaps
they are a Windows shop and use Active Directory policies to "tell" MSIE
how to operate on a particular network. Don't forget enterprise networks
tend to span continents and so static entries are not appropriate -
different proxies for different sites within the same company are common.

Anyway, all this means it's too hard for users to remember
what-to-use-where and so things like WPAD were born. They also fail
open, so when you take your laptop home, it does a WPAD lookup, doesn't
get an answer and so assumes it's open Internet. i.e. automatic proxy
detection is all good and no bad (I'm ignoring the fundamental issue
that plugging into random networks and using the proxy "the network"
told you to use is safe - but https and openvpn over untrusted networks
should still be safe)

If openvpn had good automagic proxy detection, and a single config could
contain a mixture of udp and tcp and tcp-over-proxy [connection]
profiles, then openvpn would work on every network in the world - with
only some high-security exceptions. I think that's a goal worth reaching
for :-)

BTW, from what I've read, Microsoft's DirectAccess does exactly this
(ipv6Direct-else-udpToredo-else-ipv6overTCP-else-ipv6overTCPoverProxy)...

Jason

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


