Date: Tue, 8 Mar 2011 21:05:25 -0300
From: Federico Heinz <fheinz@...277...>
Message-ID: <20110308210525.7d75f081@...1451...>
In-Reply-To: <AANLkTi=FFxhdD5avAov9F8giPr-a_A=9Hzf3+Prm4p0V@...278...>
References: <20110308185252.301d0a1d@...1451...>
	<AANLkTi=FFxhdD5avAov9F8giPr-a_A=9Hzf3+Prm4p0V@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/03/2011, Alon Bar-Lev wrote:
> I don't understand why it is needed.
> You can always start openvpn and override configuration via
> command-line.
> So add --local "$(/sbin/ip addr show dev wlan0 | grep inet | sed
> 's#.*inet \(.*\)/.*#\1#')" parameter while starting it.

Sure: there's a huge number of workarounds one could use. Only I
think this is a useful feature in its own right, and much easier for
people to find.

Fumbling with the command line also works fairly well when you are
running only one instance of OpenVPN (say, in Debian you could get
away with clever code in /etc/defaults/openvpn). When you run more
than one (say, for multiple interfaces), however, the doctoring that
has to be done in the startup scripts is more arcane.

Workarounds like to one you propose, are much more complicated and
cryptic than the solution I propose.

I'd like to point out that OpenVPN is rather an odd case among
internet daemons in not providing an easy way to say "bind to
interface so-and-so", most other daemons have such a configuration
option.

So, while I agree that there are ways of achieving this by fiddling
with the command line and startup scripts, I rather strongly feel
that this feature is worthwhile.

	Fede

