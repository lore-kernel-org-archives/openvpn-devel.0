From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Foolproof rollout
In-Reply-To: <a6589cd60410221425748baad@...278...>
Message-ID: <Pine.LNX.4.61.0410222327390.9458@...210...>
References: <a6589cd60410221425748baad@...278...>
MIME-Version: 1.0
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
Date: Fri Oct 22 14:42:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Hans Fugal <fugalh@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 22 Oct 2004, Hans Fugal wrote:

> I'm new to openvpn, coming from a PPTP and IPsec background. I like
> what I see. We have been having trouble with connectivity on our IPsec
> (netscreen appliance and netscreen remote (safenet) software on the
> roadwarrior computers), and we're looking at moving to OpenVPN, at
> least for the people that have connectivity issues.
>
> The problem is that some of these people are not computer savvy by any
> definition of the word, and as it stands openvpn requires too much
> configuration - there are too many places they can jump off into the
> deep end.
>
> The ideal situation would be something like this use case: The user
> gets an email from me saying something like: "Run the attached
> installer, reboot, and double click the new VPN icon on your desktop."
>
> I believe this is possible, and this is how I see it working. I create
> and sign the certificate and the config file (which doesn't change
> from user to user). I run a script or make target that creates a
> custom installer that has the certificate, key, and config file and
> will put them in the right place (that part's easy), set up a shortcut
> that will start the vpn (not too hard), and configure the network
> settings (DNS for example - this might not be necessary if we use dhcp
> over tap).
>
> I intend to do this, if there aren't hidden demons that make it
> unfeasible, and if someone else hasn't already done it or isn't
> already doing it. Would this be something that would fit as part of
> openvpn itself, or would it be better to do it as a separate project
> and/or patch? Do you have any pointers on where to start?

That should be pretty straigh-forward to accomplish. If you want to 
include OpenVPN GUI, which I think your users would appreciate, if they 
are not in love with the command-line, you can use the NSIS script I've 
used to build the installation package with OpenVPN and OpenVPN GUI as a 
base.

Then just modify it to include your real config-file instead of 
sample.ovpn.txt + the user key,cert and ca cert (I use a PKCS #12 file 
instead to get it down to only one file containing key+cert+cacert).

With OpenVPN 2.0-betaXX you can push every configuration option you need 
to the client, so the config-file can be the same for every user, and you 
usually don't have todo anything else on the client.

The NSIS script is available here:

http://www.nilings.se/openvpn/files/install_packages/openvpn-gui.nsi

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


