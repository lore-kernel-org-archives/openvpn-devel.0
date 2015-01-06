Message-ID: <54ABA622.7020607@...515...>
Date: Tue, 06 Jan 2015 11:08:50 +0200
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20141208115202.GA4807@...2009...>
	<20141212165220.GA4575@...2009...>	<548B32D4.1060607@...1227...>
	<20150105102207.GA9055@...2009...>
In-Reply-To: <20150105102207.GA9055@...2009...>
Subject: Re: [Openvpn-devel] [PATCH] Add Mac OS X keychain support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Vasily Kulikov <segoon@...2008...>, openvpn-devel@lists.sourceforge.net
Cc: Anton Karpov <tokza@...2010...>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi,
>
> On Fri, Dec 12, 2014 at 19:24 +0100, Arne Schwabe wrote:
>>> On Mon, Dec 08, 2014 at 14:52 +0300, Vasily Kulikov wrote:
>>>> This patch adds support for using certificates stored in the Mac OSX
>>>> Keychain to authenticate with the OpenVPN server.  This works with
>>>> certificates stored on the computer as well as certificates on hardware
>>>> tokens that support Apple's tokend interface.  The patch is very
similar
>>>> to, and also based on, the Windows Crypto API certificate functionality
>>>> that currently exists in OpenVPN.
> ...
>>>> Signed-off-by: Vasily Kulikov <segoon@...2008...>
>>>> --
>>> Any comments?
>
> Some ideas about keychain implementation out of OpenVPN core.
>
> I see 4 possible alternatives here:
> 1) implement keychain rsa offloading in Tunnelblick
> 2) make my patch use plugin interface
> 3) implement external daemon that communicated with openvpn process via
> management interface
> 4) the same as 3) but make openvpn able to handle more than 1
> management client
>
> There are problems with all these alternatives:
> (1) is limited to Tunnelblick users and doesn't work for users who start
> openvpn from the terminal or use any other GUI
> (2) implies plugin interface is expanded to handle two new actions: 'user
> certificate request' and 'rsa-sign request'
> (3) implies management interface is expanded to handle 'user certificate
> request'; also it doesn't work with Tunnelblick or any other tool that
> communicates with openvpn via management interface as MI currently
> supports only a single client
> (4) needs 'user certificate request' addition and expanding management
> interface to support more than a single client
>
> So, (1) is a no-go as it works only with Tunnelblick; (3) is a no-go as
> it breaks Tunnelblick and probably someone else.  We stay with only two
> interface expantions: plugin interface or management interface.  Either
> (a) add 'user certificate request' to plugin interface or (b) add 'user
> certificate request' to management interface and support more than a
> single client.
>
> I'm not sure which way is better.  Do you have any plans/objections on
> these interfaces expantion?  Maybe I missed some critical limitations of
> the interfaces and they must not be used this way?  If no strict
> objections I'd prefer to implement it via plugin interface as my patch
> would need to change only several hooks registration and handling
> functions in this case.
>
> Thanks,
>
Hi,

I've discussed this topic with James Bekkema, a Viscosity developer who
was unfortunately unable to attend the previous IRC meeting. He
suggested the following:

"I also noticed some confusion as to how OpenVPN was able to access the
local user=92s Keychain in the IRC chat log: while I haven=92t looked in
detail at the patch, I suspect this is due to how Tunnelblick is
launching OpenVPN with elevated permissions. Tunnelblick uses a SUID
helper to have effective root permissions, and so OpenVPN in inheriting
the user=92s environment. For clients using a more secure (i.e. launchd)
elevation approach (such as OpenVPN Connect, Viscosity, etc.) this
approach won=92t work (assuming it is indeed what is going on) which may
make it a bit useless."

"My recommendation would be to expand upon the support already in place
for getting identity details over the management interface for Android
devices. That way the actual accessing of the Keychain can be performed
by a process running as the end user, without any signing issues etc.
coming into play. It looks like this was pretty much the conclusion
drawn from the meeting ."

Best regards,

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlSrpiIACgkQwp2X7RmNIqOioACgx+xqO+Z7cVJZtGClgWdK0nDh
eCMAn2Emks41PQCbKsaA9pt5U19DGhSS
=3D63NW
-----END PGP SIGNATURE-----



