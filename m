Message-ID: <9e0cf0bf0812120728w15717291p8ed848a7ec924938@...278...>
Date: Fri, 12 Dec 2008 17:28:10 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <200812121615.19957.opensource@...519...>
MIME-Version: 1.0
References: <20081212084127.GA31936@...1165...>
	<200812121615.19957.opensource@...519...>
Subject: Re: [Openvpn-devel] Porting OpenVPN to Symbian
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
Content-Disposition: inline
To: Till Maas <opensource@...519...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/12/08, Till Maas <opensource@...519...> wrote:
> On Fri December 12 2008, Emrah wrote:
>
>  >       What's up with the possibility to port OpenVPN to Symbian?
>  > If anybody is interested to face this challenge, I'd be ready to fully
>  > sponsor a bounty. In this case, how much $$$ would you expect?
>
>
> I would like to have this done, too. But this seems not that easy. Once I
>  googled around a little and did not find any hint on how to create e.g. a tap
>  device on symbian or even any other floss vpn client or some other software
>  that can e.g. manipulate the routing table of symbian devices. But I
>  appreciate any pointers for such software or other obstacles that may make
>  this difficult.

It would be easier to use a simple TCP/UDP redirection, configure
local application to use local port and forward it using TLS with
client authentication to a host. It is not transparent VPN but will
provide decent solution.

Alon.

