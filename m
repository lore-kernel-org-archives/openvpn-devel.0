MIME-Version: 1.0
In-Reply-To: <4F4EAA97.6020600@...1490...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
	<20120229154604.GA7024@...1296...>
	<1056463883.20120229194318@...449...>
	<20120229212832.GC7024@...1296...>
	<CAOazyz3t+=2SsDA0+_sqByekvbE7R5Y+qHN2ysGDLw2hsiK8wg@...278...>
	<4F4EAA97.6020600@...1490...>
Date: Thu, 1 Mar 2012 09:44:25 +0200
Message-ID: <CAOazyz3r6JguXjk8UEv5xkJFb5HmAfJOFHuA8jRa7NCi7e+wUQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jason Haar <Jason_Haar@...1490...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Mar 1, 2012 at 12:45 AM, Jason Haar <Jason_Haar@...1490...> wrote:
> A comment on your [1] reference. The issue of remote-user vs enterprise
> is an old one - that affects many software applications - not just
> openvpn. I personally think the proper solution is to implement NAC:
> make "the network/enterprise" audit the remote host and only allow it if
> it meets expectations. As such I don't think openvpn has to solve this
> problem itself, as "the enterprise" cares a lot more about the remote
> machine than whether or not the remote user has injected a couple of
> routes into the local routing table. eg Windows AV status.
>
> I think openvpn is quite entitled to act as a "mere" vpn solution, "the
> enterprise" should invoke a more over-arching solution (such as NAC with
> NAC agents) to ensure policy compliance.
>

Yes, and I guess you read to the end to the technical solution, right?
Do you have a comment about that?

Alon.

