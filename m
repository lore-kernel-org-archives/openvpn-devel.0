Message-ID: <4D7A7455.4070805@...1114...>
Date: Fri, 11 Mar 2011 20:13:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20110308185252.301d0a1d@...1451...>	<20110309084745.GN9835@...1296...>	<20110309085656.18e0e796@...1451...>
	<20110311122309.1292c1dd@...1451...>
In-Reply-To: <20110311122309.1292c1dd@...1451...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Federico Heinz <fheinz@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/11 16:23, Federico Heinz wrote:
> I'm sorry, folks, I'd like to ask for some clarification.
> 
> My patch was NAK'd on implementation issues. I offered alternatives
> to them. I got no answer to them.
> 
> Should I bother implementing one of the alternatives, or will the
> patch be disregarded nonetheless? If the patch does stand a chance to
> be accepted with a better implemantation, should I go with
> getiffadrs() or the current approach to get the interface's IP
> address?

Sorry that you haven't received any response quickly.  Most of us here are
having full time jobs which is not directly related to OpenVPN.

But I have been thinking about this a lot.  And I decided to have a peek at
what other open source products does.  I checked against openssh-5.8,
vsftpd-2.3.4, nginx-0.9.5, lighthttpd-1.4.28 and varnish (git HEAD =
7058d471b586151e).  I also checked against the documentation for
ISC BIND 9.8,

None of these products supports network device name for setting up listen
addresses.  I chose these products as they are all aimed at being accessed
from the "wild Internet", accepting connections from whoever who are not
necessarily known to the server.  Which makes their use cases closer to
OpenVPN.

After some pondering, I begin to wonder if this feature really is as clever
as we believe it is.  I do stand corrected in regards to dynamically
changing the listening IP address, and in hindsight supporting such a
feature probably makes things even worse.

But to summarise it somehow, based on my pondering ... a quick pro/cons list:

   + makes config easier for sys-admins

   - OpenVPN will only listen to the first identified IP address,
     which will need to be both IPv4 and IPv6 aware.  This will become a
     support issue pretty quickly.

   - 6 different open source products which has a similar usage profile
     (open access from the Internet) do not have this support.

   - Can cause some surprises, if people re-plug a network cable between
     two network devices.  Suddenly OpenVPN is available on a network
     segment it should not be available on, due to not being restricted
     to particular a IP address.  Of course it should be a firewall
     stopping it in front, but that might have been disabled as well - for
     unknown reasons.  Surely this is a PEBKAC issue, but they do happen
     more often than we like to admit.

So, is this really such a good idea?  I'm not withdrawing my feature NACK
now, but I'm suddenly not so convinced this is clever.  Unless someone
comes with convincing arguments.

But please share your opinions - every one who got an opinion about this.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk16dFIACgkQDC186MBRfrpyPQCfVP2m20ZhWfYN1yPeic4FgSqy
QPAAnRqym4IK77PSF7WIfzm4jd8ton3l
=QE4V
-----END PGP SIGNATURE-----

