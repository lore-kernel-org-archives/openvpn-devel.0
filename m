Sender: Vasiliy Kulikov <segooon@...277...>
Date: Fri, 12 Dec 2014 19:52:20 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20141212165220.GA4575@...2009...>
References: <20141208115202.GA4807@...2009...>
MIME-Version: 1.0
In-Reply-To: <20141208115202.GA4807@...2009...>
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

On Mon, Dec 08, 2014 at 14:52 +0300, Vasily Kulikov wrote:
> This patch adds support for using certificates stored in the Mac OSX
> Keychain to authenticate with the OpenVPN server.  This works with
> certificates stored on the computer as well as certificates on hardware
> tokens that support Apple's tokend interface.  The patch is very similar
> to, and also based on, the Windows Crypto API certificate functionality
> that currently exists in OpenVPN.
> 
> The previous version of the patch was sent by Brian Raderman
> (http://thread.gmane.org/gmane.network.openvpn.devel/3631).  The current
> version uses autoconf, doesn't use printf, fixes several small bugs like
> ignoring errors, and it now works with Tunnelblick.  The previous version
> has been tested with an Aladdin eToken on Mac OSX Leopard and with
> software only certificates on Mac OSX Leopard and Snow Leopard, as
> reported by Brian Raderman in his email.  The current version of the
> patch was tested in Yandex company on ~3000 hosts using several Mac OS X
> versions (10.7, 10.8. 10.9. 10.10) using Tunnelblick.
> 
> It was tested both on OpenVPN started from the terminal and using
> Tunnelblick.  Renegotiation was tested too.
> 
> There are several warnings on Mac OS X related to functions deprecation
> like RSA_new() and similar.  However, they are used in other OpenVPN
> code, so I decided not to touch it.
> 
> The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.
> 
> Signed-off-by: Vasily Kulikov <segoon@...2008...>
> --

Any comments?

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

