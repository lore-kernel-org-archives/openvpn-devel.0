Sender: Vasiliy Kulikov <segooon@...277...>
Date: Mon, 5 Jan 2015 13:22:07 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150105102207.GA9055@...2009...>
References: <20141208115202.GA4807@...2009...> <20141212165220.GA4575@...2009...>
	<548B32D4.1060607@...1227...>
MIME-Version: 1.0
In-Reply-To: <548B32D4.1060607@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add Mac OS X keychain support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Anton Karpov <tokza@...2010...>

Hi,

On Fri, Dec 12, 2014 at 19:24 +0100, Arne Schwabe wrote:
> > On Mon, Dec 08, 2014 at 14:52 +0300, Vasily Kulikov wrote:
> >> This patch adds support for using certificates stored in the Mac OSX
> >> Keychain to authenticate with the OpenVPN server.  This works with
> >> certificates stored on the computer as well as certificates on hardware
> >> tokens that support Apple's tokend interface.  The patch is very similar
> >> to, and also based on, the Windows Crypto API certificate functionality
> >> that currently exists in OpenVPN.
...
> >> Signed-off-by: Vasily Kulikov <segoon@...2008...>
> >> --
> > Any comments?

Some ideas about keychain implementation out of OpenVPN core.

I see 4 possible alternatives here:
1) implement keychain rsa offloading in Tunnelblick
2) make my patch use plugin interface
3) implement external daemon that communicated with openvpn process via
management interface
4) the same as 3) but make openvpn able to handle more than 1
management client

There are problems with all these alternatives:
(1) is limited to Tunnelblick users and doesn't work for users who start
openvpn from the terminal or use any other GUI
(2) implies plugin interface is expanded to handle two new actions: 'user
certificate request' and 'rsa-sign request'
(3) implies management interface is expanded to handle 'user certificate
request'; also it doesn't work with Tunnelblick or any other tool that
communicates with openvpn via management interface as MI currently
supports only a single client
(4) needs 'user certificate request' addition and expanding management
interface to support more than a single client

So, (1) is a no-go as it works only with Tunnelblick; (3) is a no-go as
it breaks Tunnelblick and probably someone else.  We stay with only two
interface expantions: plugin interface or management interface.  Either
(a) add 'user certificate request' to plugin interface or (b) add 'user
certificate request' to management interface and support more than a
single client.

I'm not sure which way is better.  Do you have any plans/objections on
these interfaces expantion?  Maybe I missed some critical limitations of
the interfaces and they must not be used this way?  If no strict
objections I'd prefer to implement it via plugin interface as my patch
would need to change only several hooks registration and handling
functions in this case.

Thanks,

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

