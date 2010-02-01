Message-ID: <4B66C9C4.7090808@...515...>
Date: Mon, 01 Feb 2010 14:32:04 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4B65724F.6080201@...515...>	<9e0cf0bf1001310414i6462b9a9p6909b70978348a49@...278...>	<4B657BC7.5030004@...515...>	<9e0cf0bf1001310459v345ede35mfa4b8233c65bc666@...278...>	<4B65724F.6080201@...515...>
	<20100201002633.4356.qmail@...1287...>
In-Reply-To: <20100201002633.4356.qmail@...1287...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (28th Jan 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> Discussed community site spam prevention in some length:
>>
>> * There is an anti-spam plugin for Trac (see below)
>> * A proper user registration process needs to be chosen - not too
>>   bureaucratical but not too automated, either
>>=20=20=20=20=20
>
> In this context I'd like to suggest accepting OpenID login in Trac.
>
> When I first learned about OpenID I was very sceptical, but now that
> I have implemented it for one Trac I actually really like it.
>
> For those not yet familiar with OpenID, the idea is to let a web site
> (really any web site) provide authentication service for your users.
> OpenID specifies the API used between service (Trac) and
> authenticator (other web site) and this way, users only need to log
> in at one place.
>
> This sounds like a gaping hole, but in combination with email address
> verification before allowing write access in Trac it is pretty
> efficient - and convenient.
>
> Many different web sites are OpenID providers, and there are various
> packages available for setting up your own OpenID provider on a URL
> that you control.
>
> To log in, you give the URL to that OpenID provider (which can be any
> web page, OpenID provider info can be added in meta tags) and then
> you log in over there, and finally Trac checks with $overthere that
> you are logged in.
>
> I think the email address verification part is important.
>
>
> http://bitbucket.org/Dalius/authopenid-plugin/
>
> (I have an ebuild in my overlay at http://stuge.se/overlay.txt)
>=20=20=20
I'm somewhat familiar with OpenID but I need to take another look at it.
SF.net supports it, so the same OpenID could be used for the SF.net
"openvpn" project (should we make use of it) as well as the community
site Trac instance.
> Alon Bar-Lev wrote:
>=20=20=20
>> Trac is promises to provide all but provides none, I really don't
>> know which project you managed with Trac, but without ticket
>> dependencies
>>=20=20=20=20=20
>
> There's a plugin for it:
>
> http://trac-hacks.org/wiki/MasterTicketsPlugin
>=20=20=20
>> and without proper CC lists
>>=20=20=20=20=20
>
> Another plugin:
>
> http://trac-hacks.org/wiki/TracNotification
>=20=20=20
Good finds, Peter!

>> and workflow it is difficult to manage a real project.
>>=20=20=20=20=20
>
> Hm - please expand on what you mean by workflow?
>
>=20=20=20
And could expand on what a real project means... I'm just wondering
whether you mean an in-house/closed source software project or a
community-driven OSS project. Their workflow is very different - as are
their requirements.

In any case, integrating a bunch of separate services together is a
_lot_ of work even if integration is superficial, e.g. theming all
services similarly and using a common authentication backend. This is
where Trac saves us a lot of effort. It may have it's shortcomings, but
it only needs to be "good enough". Also, even if the Trac core
development is slow, there's still a healthy ecosystem around it (plugin
maintainers etc).

Btw. the reason why I have never stumbled upon ticket dependency
problems in Trac is because I've mostly used it as a simple task
management system, where most of the tasks were independent.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


