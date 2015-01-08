Sender: Vasiliy Kulikov <segooon@...277...>
Date: Thu, 8 Jan 2015 22:16:39 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150108191639.GA6636@...2009...>
References: <20141208115202.GA4807@...2009...> <20141212165220.GA4575@...2009...>
	<548B32D4.1060607@...1227...> <20150105102207.GA9055@...2009...>
	<54ABDC74.4000407@...1227...>
MIME-Version: 1.0
In-Reply-To: <54ABDC74.4000407@...1227...>
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, Anton Karpov <tokza@...2010...>

On Tue, Jan 06, 2015 at 14:00 +0100, Arne Schwabe wrote:
> >>> Any comments?
> > Some ideas about keychain implementation out of OpenVPN core.
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
> >
> > So, (1) is a no-go as it works only with Tunnelblick (3) is a no-go as
> > it breaks Tunnelblick and probably someone else.  We stay with only two
> > interface expantions: plugin interface or management interface.  Either
> > (a) add 'user certificate request' to plugin interface or (b) add 'user
> > certificate request' to management interface and support more than a
> > single client.
> But if you encapsulate that stuff in a library or something similar you
> could use that library from TunnelBlick and from a small standalone
> tool/OpenVPN plugin.
> 
> For (4) Implementing a request for managament ca/cert is relatively
> easy. At the moment this has not been implemented because nobody needed
> it so far. All current users managment-query-key (or what the option is
> called) generate the configuration with the right <ca>, <cert> options
> instead of querying for these values at startup.

I'm thinking about using existing 'needstr' command.  Looking at the
'#ifdef TARGET_ANDROID' code, it should be a very small patch to openvpn
which adds a command line option like '--management-external-cert' and
using management_query_user_pass() for certificate request (e.g. BASE64
encoded).

> I disagress that (3) is inheritly incompatible with Tunnelblick.
> Tunnelblick could spawn an openvpn process and the external daemon. On
> the rsa-sign request, Tunnelblick would just connect to the external
> daemon ask that daemon to process the rsa-sign request.

Right.  I was talking more about breaking current state of affairs
rather than completely incompatible changes that cannot be fixed on the
Tunnelblick side.

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

