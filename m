Message-ID: <20100201002633.4356.qmail@...1287...>
Date: Mon, 1 Feb 2010 01:26:33 +0100
From: Peter Stuge <peter@...1287...>
References: <4B65724F.6080201@...515...>
	<9e0cf0bf1001310414i6462b9a9p6909b70978348a49@...278...>
	<4B657BC7.5030004@...515...>
	<9e0cf0bf1001310459v345ede35mfa4b8233c65bc666@...278...>
	<4B65724F.6080201@...515...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf1001310459v345ede35mfa4b8233c65bc666@...278...>
	<4B65724F.6080201@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (28th Jan 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Samuli Seppänen wrote:
> Decided to start with a single Trac-based site for the whole
> community rather than have separate user/developer sites.

I think this is a good way to get some content going, even if it
turns out that the solution is inadequate sometime in the future.


> Discussed community site spam prevention in some length:
> 
> * There is an anti-spam plugin for Trac (see below)
> * A proper user registration process needs to be chosen - not too
>   bureaucratical but not too automated, either

In this context I'd like to suggest accepting OpenID login in Trac.

When I first learned about OpenID I was very sceptical, but now that
I have implemented it for one Trac I actually really like it.

For those not yet familiar with OpenID, the idea is to let a web site
(really any web site) provide authentication service for your users.
OpenID specifies the API used between service (Trac) and
authenticator (other web site) and this way, users only need to log
in at one place.

This sounds like a gaping hole, but in combination with email address
verification before allowing write access in Trac it is pretty
efficient - and convenient.

Many different web sites are OpenID providers, and there are various
packages available for setting up your own OpenID provider on a URL
that you control.

To log in, you give the URL to that OpenID provider (which can be any
web page, OpenID provider info can be added in meta tags) and then
you log in over there, and finally Trac checks with $overthere that
you are logged in.

I think the email address verification part is important.


http://bitbucket.org/Dalius/authopenid-plugin/

(I have an ebuild in my overlay at http://stuge.se/overlay.txt)


Alon Bar-Lev wrote:
> Trac is promises to provide all but provides none, I really don't
> know which project you managed with Trac, but without ticket
> dependencies

There's a plugin for it:

http://trac-hacks.org/wiki/MasterTicketsPlugin


> and without proper CC lists

Another plugin:

http://trac-hacks.org/wiki/TracNotification


> and workflow it is difficult to manage a real project.

Hm - please expand on what you mean by workflow?


> 2. ViewVC/ViewGIT/Whatever - Browse code.

I agree that e.g. git-web is much nicer than Trac's source viewer but
again it's nice to have something integrated.


//Peter

