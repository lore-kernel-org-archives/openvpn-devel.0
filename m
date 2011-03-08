MIME-Version: 1.0
In-Reply-To: <20110308185252.301d0a1d@...1451...>
References: <20110308185252.301d0a1d@...1451...>
Date: Wed, 9 Mar 2011 00:38:20 +0200
Message-ID: <AANLkTi=FFxhdD5avAov9F8giPr-a_A=9Hzf3+Prm4p0V@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
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
To: Federico Heinz <fheinz@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

I don't understand why it is needed.
You can always start openvpn and override configuration via command-line.

So add --local "$(/sbin/ip addr show dev wlan0 | grep inet | sed
's#.*inet \(.*\)/.*#\1#')" parameter while starting it.

A more generic approach can be adding $() support into openvpn options
handling, so you can execute any command and put its output as a value
of substring option.

Alon.

On Tue, Mar 8, 2011 at 11:52 PM, Federico Heinz <fheinz@...277...> wrote:
>
> Author: Federico Heinz <fheinz@...277...>
>
> Accept "local if:<ifname>" option.
>
> The current 'local' configuration directive allows for two types of
> values: IP addresses and DNS hostnames. This is not enough for users
> of dynamic DNS services who must restart OpenVPN when their IP
> address changes, because their new IP address may not have progagated
> yet through DNS when OpenVPN starts, and so they may end up binding
> to a bogus address.
>
> This patch introduces a parameter notation that helps solve the
> problem: if the option parameter is of the form "if:<ifname>", it
> will determine the IP address of the interface and use that as the IP
> address to bind to.
>
> The patch is small, and meant to be mininally intrusive: instead of
> adding a new option and/or new code paths to handle the new case, it
> simply replaces the value supplied by the user by a string
> representing the IP address, as if the user had entered it.
>
> I'm not entirely sure I'm using gc_malloc() correctly, and I'd
> appreciate feedback on that.
>
> Signed-off-by: Federico Heinz <fheinz@...277...>
>
> ------------------------------------------------------------------------------
> What You Don't Know About Data Connectivity CAN Hurt You
> This paper provides an overview of data connectivity, details
> its effect on application quality, and explores various alternative
> solutions. http://p.sf.net/sfu/progress-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

