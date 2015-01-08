Sender: Vasiliy Kulikov <segooon@...277...>
Date: Thu, 8 Jan 2015 22:04:25 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150108190425.GA6242@...2009...>
References: <20141208115202.GA4807@...2009...> <20141212165220.GA4575@...2009...>
	<548B32D4.1060607@...1227...> <20150105102207.GA9055@...2009...>
	<1420561439.29022.195.camel@...1866...>
MIME-Version: 1.0
In-Reply-To: <1420561439.29022.195.camel@...1866...>
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
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net, Anton Karpov <tokza@...2010...>

On Tue, Jan 06, 2015 at 16:23 +0000, David Woodhouse wrote:
> On Mon, 2015-01-05 at 13:22 +0300, Vasily Kulikov wrote:
> > 
> > I see 4 possible alternatives here:
> > 1) implement keychain rsa offloading in Tunnelblick
> > 2) make my patch use plugin interface
> > 3) implement external daemon that communicated with openvpn process via
> > management interface
> > 4) the same as 3) but make openvpn able to handle more than 1
> > management client
> > 
> > There are problems with all these alternatives:
> > (1) is limited to Tunnelblick users and doesn't work for users who start
> > openvpn from the terminal or use any other GUI
> > (2) implies plugin interface is expanded to handle two new actions: 'user
> > certificate request' and 'rsa-sign request'
> > (3) implies management interface is expanded to handle 'user certificate
> > request'; also it doesn't work with Tunnelblick or any other tool that
> > communicates with openvpn via management interface as MI currently
> > supports only a single client
> > (4) needs 'user certificate request' addition and expanding management
> > interface to support more than a single client
> 
> It is perhaps worth noting that OpenVPN already *has* a plugin API which
> supports the "user certificate request" and "rsa-sign request" methods.
> 
> That is, after all, fairly much what PKCS#11 was *designed* to provide.
> 
> There are also existing implementations of PKCS#11 RPC such that the
> actual manipulation of the token can occur in a user-owned process
> separately from the caller.

Right, PKCS#11 is a yet-another-interface to extend OpenVPN :)
I'm not familiar with PKCS#11 and its interface looks too complex for my
relatively simple task, at least from the first glance it is an
overkill.

> Perhaps the way forward is to implement the keychain support in the form
> of a PKCS#11 provider module, which can either be loaded directly in
> OpenVPN or proxied to run in a user's context.
> 
> In fact, doesn't such an implementation already exist at
> https://github.com/slushpupie/KeychainToken ?

Looks like so, but it uses a deprecated CSSM API.  Also the last commit
was done 4 years ago, probably the code has more issues.

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

