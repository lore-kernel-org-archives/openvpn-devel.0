Message-ID: <4CC05427.3080701@...1147...>
Date: Thu, 21 Oct 2010 16:54:31 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <AANLkTik2EpA-JAS=q6bmHrvw1qHRQp5D2rLPpbvy+NTE@...278...>
In-Reply-To: <AANLkTik2EpA-JAS=q6bmHrvw1qHRQp5D2rLPpbvy+NTE@...278...>
Subject: Re: [Openvpn-devel] With route-noexec openvpn still adds
	routes	automatically
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Ansis Atteka <ansisatteka.dev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Ansis Atteka wrote:
> Hello,
>
> I have OpenVPN configuration where I want to add all routes from up.sh 
> and down.sh scripts manually. My setup also has route-noexec option in 
> config file, so according to man pages I would expect that OpenVPN 
> should not add any routes on its own:
>
> /       --route-noexec
>               Don't add or remove routes automatically.  Instead  
> pass  routes
>               to --route-up script using environmental variables.
> /
> But it turns out that with topology P2P it still adds a route when 
> setting up TUN with ifconfig command for pointopoint mode.
>
>
> My questions are:
> 1. Is it by design that OpenVPN still adds routes automatically with 
> topology p2p and route-noexec set? I guess that openvpn has limited 
> visibility over what ifconfig command does, so maybe this is the reason...
> 2. Should one use topology Subnet instead of P2P in such cases, to get 
> pure control over what routes are being added?
>
>
alternatively you could use
  ifconfig-noexec
and write a script which brings up the tun interface for you - in that 
case you're solely responsible for bringing up the interface in the 
right manner and for adding or not adding any routes.

HTH,

JJK


