Message-ID: <4D774565.7080507@...1114...>
Date: Wed, 09 Mar 2011 10:16:21 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20110308185252.301d0a1d@...1451...>	<AANLkTi=FFxhdD5avAov9F8giPr-a_A=9Hzf3+Prm4p0V@...278...>
	<20110308210525.7d75f081@...1451...>
In-Reply-To: <20110308210525.7d75f081@...1451...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
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
To: Federico Heinz <fheinz@...277...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/11 01:05, Federico Heinz wrote:
| On 09/03/2011, Alon Bar-Lev wrote:
|> I don't understand why it is needed.
|> You can always start openvpn and override configuration via
|> command-line.
|> So add --local "$(/sbin/ip addr show dev wlan0 | grep inet | sed
|> 's#.*inet \(.*\)/.*#\1#')" parameter while starting it.

I see this patch as an indication of a feature which really is missing.
However, I am sceptical to the approach of this patch, so I'm actually siding
with Alon here.

So, feature-wise - I give this an ACK.  Implementation-wise it's a NACK,
unfortunately.

Even though that shell trick isn't so obvious, I would say it solves exactly
the same thing.  It's not as pretty, but your patch does not give any extra
advantages either.

| I'd like to point out that OpenVPN is rather an odd case among
| internet daemons in not providing an easy way to say "bind to
| interface so-and-so", most other daemons have such a configuration
| option.

Yes, agreed!  This is a feature people to ask for.  We just need to find the
proper implementation for it.  There are a couple things which I don't like
about this patch, though.

One is that you do resolve the IP address based on the device name.  What if
the IP address changes on that device?  It would be anticipated by most users
that it would then listen to the new IP address.  When being done via the
command line, it is much more obvious OpenVPN needs to be restarted on an IP
address change.

Then there are is this issue with IPv6.  It's not available in the coming 2.2
or earlier releases (unless you've added support patches for it).  But we're
soon (4-12 weeks) starting on the 2.3 beta cycle which will include full IPv6
support.  And with IPv6 an interface can also multiple IP addresses, even
without using aliasing in Linux.  In fact, I wonder if it is even possible to
assign multiple IPv4 addresses using iproute2 to a device without aliases.  It
might be something similar in *BSD as well.  Your patch does not cover this
scenario at all.

The third thing is that you do socket() operations in options.c.  The code is
messy enough as it is, and I would like to contain everything which does
socket operations in socket.c.  Unfortunately, socket.c is pretty messy.  So
we do need to clean that code up.

And to really top it.  OpenVPN does not support listening to multiple IP
addresses currently.  So socket.c needs a major overhaul and this feature must
be implemented.  When we manage this, we can bind to devices instead of IP
addresses, as then OpenVPN would behave as expected by most users.

I doubt such a change will make it for 2.3, due to the work related to it.
But if it is ready in time, we can add it to 2.3.  If not, there's always the
next 2.4 release in the horizon as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk13RWUACgkQDC186MBRfro6EgCfSSa5ZT+v90ZasciYa9RhM/Wa
qOsAn0w5CJ/wJqwI3wgrHsrB5m9aag1o
=hvl5
-----END PGP SIGNATURE-----

