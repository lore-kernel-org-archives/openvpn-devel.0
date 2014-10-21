MIME-Version: 1.0
In-Reply-To: <20141021104308.GZ396@...1296...>
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
	<20141021091159.GY396@...1296...>
	<CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>
	<20141021104308.GZ396@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 21 Oct 2014 06:58:37 -0400
Message-ID: <CAEsd45Qa34HsKZ6rwhuF5qnvBBnsFVeaJcRConfLEjXOdu+StQ@...278...>
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
	released
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Tue, Oct 21, 2014 at 6:43 AM, Gert Doering <gert@...1296...> wrote:
> Yes, exactly.  In essence, you have a windows service running with full
> privileges, which is instructed by the GUI to run an openvpn.exe process
> (with user privs, so OpenVPN can't do damage) and OpenVPN communicates
> back to the service what should be ifconfig'ed and what routes should
> be installed.  So the network config is done by the service, and
> undone when OpenVPN exits or crashes.

That's what I am hoping for -- either an extension to the management
interface, or an similar but separate interface.


> Unfortunately, right now, there is nothing at all yet - there is most of
> the code, but it's still living in Heiko's private tree.  We plan to meet
> in person in November ("Munich Hackathon") and hopefully this will unravel
> the knot that's holding up this change.

I look forward to hearing about it.

> How do you handle things in Tunnelblick today?  Run OpenVPN "as root"?

Yes, exactly. I'd love to make that not necessary.

Thanks for the info.

Jon

