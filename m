Message-ID: <20110315031318.21678.qmail@...1287...>
Date: Tue, 15 Mar 2011 04:13:18 +0100
From: Peter Stuge <peter@...1287...>
References: <20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
	<20110313142200.GJ9835@...1296...>
	<20110313160421.3004.qmail@...1287...>
	<20110313173833.GK9835@...1296...>
	<20110313231620.12432.qmail@...1287...>
	<20110314083845.GL9835@...1296...>
	<20110314200626.450b6853@...1451...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20110314200626.450b6853@...1451...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Federico Heinz wrote:
>   * some other people agree that there is a use case, but propose
>     different ways of approaching the problem through various
>     mechanisms to resolve the interface name to an IP address before
>     passing it on to OpenVPN. The disagreement here seems to be in
>     how such a use case should be handled. Sure, those approaches
>     work, and I tried them myself before diving into the source
>     code. The problem is I don't think that a supported use case
>     should need such involved procedures,

This is exactly the point for me. Until OpenVPN can listen on all IP
addresses on the given interface, it must not try to use interface
terms at all. So IMO the feature depends on multilisten, without
which listening on an interface is not yet supported.

What *is* supported is to listen to a specific IP. It's a rudimentary
feature for all IP daemons. Better solutions are possible, but for
now this is what is there. This is still useful when taking advantage
of hooks in the configuration event source.

When multilisten is in place and listen-on-interface is proposed
again, I think we must discuss whether OpenVPN should automatically
detect reconfiguration of an interface. I tend to think that yes it
should do that. But on the other hand that code will be a bit
involved since no two systems work the same way. The alternative is
to have external helpers which hook into reconfiguration event
sources, but that's not so elegant.


> and while these may be
>     more or less complicated, none of them is as simple as being
>     able to specify "if:pppo" in the 'local' directive. As a matter
>     of fact, the last suggestion from Peter has more code in it than
>     the code portion of my suggested patches.

On the other hand it has the significant benefit of connecting the
*actual* configuration event source directly with OpenVPN. When
dealing with dynamic configurations it's critical not to create a
race condition, so anything that does not connect and sync with
actual event source should be out of the question.


> As to the second group of people, I guess it's a matter of drawing
> a line:
> at one end of the spectrum, we could do away with OpenVPN altogether
> and implement it in shell code,

Sorry, but this makes no sense. Feel free to rewrite the (re)config
event handler in C if you prefer. That can certainly have benefits
over the shell script. I showed you something that works that I use.

See above for my feature-nak rationale. It can certainly change to
ack in the future when OpenVPN has better infrastructure to support
the feature.


> we could turn OpenVPN into an HTTP server just touching config files.

Yes please! :)


> I think the proposed change would be a useful addition to the
> project, but I respect your judgement if you disagree.

I disagree at the moment, because of lack of multilisten and
reconfiguration tracking.

The only other programs I can think of that deal in terms of
interfaces are low level network monitoring tools. tcpdump, ethtool
etc, specifically because they operate below IP level. What you
propose is simply not thorough enough for me to like it, if OpenVPN
is to climb one step down in the layers and also deal in interfaces.
I'm not saying I never want it to, but that it needs to be better
prepared if it is going to try.


//Peter

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFNftlOhR3Q0dhIfEgRAjL6AKCy1lYgxuhKASccftypnexdmWKfugCbBjs4
sSKxuqzft6nOJbBUTZqUEFk=
=Phn0
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--

