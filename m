Subject: Re: [Openvpn-devel] First post and an alternative idea for OpenVPN
	startup on Linux
From: Paul Iadonisi <pri.openvpn@...317...>
In-Reply-To: <Pine.LNX.4.61.0411180705550.7280@...210...>
References: <1100737211.8135.32.camel@...318...>
	 <Pine.LNX.4.61.0411180705550.7280@...210...>
Message-Id: <1100764891.19571.15.camel@...318...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Nov 18 00:02:07 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Thu, 2004-11-18 at 07:20 +0100, Mathias Sundman wrote:

[snip]

> I think it's a good idea to have simple "redhat look-alike" scripts to 
> start / stop individual openvpn tunnels, to make life easier for users.
> 
> But, I hounestly dislike the idea of introducing a new config file format 
> like this. I don't really see the purpose. Why not just refer to an 
> OpenVPN config file instead?

  While I can understand that assessment, and even hesitated at
implementing this myself, I'll note that Red Hat does in fact do this
both with the built-in IPsec and with dhcp configuration.
  I've actually seen this kind of thing as a common tension between the
application developers' desire to make an application appear the same,
or largely same, no matter what platform you are on, and the platform
developers' desire to make things fit nicely into their own platform.  I
guess I fit into the later category.
  Perhaps its something to be bundled with initscripts instead of
openvpn?  It's probably the more appropriate place, anyhow, since I
don't think any other packages include their own ifup-*/ifdown-*
scripts.
  Unfortunately, I may have a *harder* time convincing Red Hat to
include it, along with a patch to /etc/sysconfig/network-scripts/ifup
because Red Hat doesn't include OpenVPN at all and may not see any
justification for customized initscripts to support it.  It is, however,
in Fedora Extras (I think only 1.6, though, at the moment), so maybe
there is a chance that it will one day be included.
  *sigh*  Oh, well, if James doesn't want to include this, I'll
understand.  But might I suggest just dropping them in the contrib dir?
And if you're really ambitious, you could introduce a --with option to
optionally build an rpm with them in the spec file ;-) (or...I could do
that, if there's interest).  If not, then, oh well ... I guess I'll just
maintain them for my own use.

-- 
-Paul Iadonisi
 Senior System Administrator
 Red Hat Certified Engineer / Local Linux Lobbyist
 Ever see a penguin fly?  --  Try Linux.
 GPL all the way: Sell services, don't lease secrets


