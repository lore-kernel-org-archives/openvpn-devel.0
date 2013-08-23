From: Josh Cepek <josh.cepek@...1085...>
Date: Fri, 23 Aug 2013 02:41:26 -0500
Message-ID: <kv73mv$skk$1@...1062...>
References: <51C77F12.1090802@...515...> <5210B1EB.7000409@...1227...>
	<20130821072739.GG16543@...1296...>
	<52147A34.7050406@...1227...> <521684EA.2030202@...1114...>
	<20130823070132.GV16543@...1296...>
Mime-Version: 1.0
In-Reply-To: <20130823070132.GV16543@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] TLS versioning
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
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/23/13 02:01, Gert Doering wrote:
> This is not about "our source does not compile with 0.96 anymore" - 
> it's about "2.3 with the TLS changes does not *talk* to OpenVPN 
> 2.2-compiled-with-0.96 anymore" (so asking the router vendors to
> use OpenVPN 2.1 or 2.0 instead won't exactly improve things as the
> TLS handshake code would be the same).
> 
> If this hits two users out of the whole Android user base, I tend to
> "well, bad luck, get your router firmware updated" - if it hits more
> "mainstream" users, we'll need to have a better answer.

I've been using a Windows build based on the official 2.3.2 release
sources with the TLS negotiation (v1.0-v1.2) support patched in from the
development codebase. This has been running fine for me, although I
don't connect to a wide variety of servers with it.

I'd be happy to publish a copy of this build for early-adopters
interested in trying out the TLS change in their own environments.
Consider this kind of a "pre-rc release" to try out just this upcoming
feature so we can see if anyone experiences problems with a bit wider
usage. I need to make some changes to my build system to include the
signed tap-windows drivers, but I can probably have a gpg-signed
installer available in a day or two for the interested.

Arne Schwabe wrote:
> Well I am not really sure what is going on on the Tomato firmware. I
> build a OpenSSL 0.9.7e (0.9.7e-3sarge3 to be exact, might already have
> some fixes in it, Tomato has 0.9.8d) on amd64 + OpenVPN 2.2.2 and that
> worked against 2.4-master. Before backing out the change or adding a
> backward fix I would like to understand what the real problem here is.

I suspect the impact of places this will break is limited to _very_ old
server setups where they should really either upgrade their server, or
simply continue using an old client that continues to speak ancient
OpenSSL if that's "not possible."

- --
Josh Cepek
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSFxImAAoJENcx2Xpgb9RjLe8L/1r1KpFscCskKbv+qKGQhLX/
1wO+OMoDmj1uZkMwfBmxRmhD7lWlLf/rIjq1wQeFwm6xF+kiO3Dyv034d2Z+htP5
PahLbWeC2Z7OLSzAn92uKCi8wfv1m16hNic6d6Z39+Yaw4kej+UQb5l8Z3DrxOyg
aCUdmLjpl5qOrgaSCptflhaRgqVGPD/7/ivsh42gUTpvcUHBnm41Ikj3fkYu+pK5
TC90XOWVqZ9mcUBcZDtW5+1PslFkxog+2VloNGMGY6gPHyotSz5E6Xmps6IDuXlp
vFNAQQm06wkHj+Qi1DN6JRAx8aKD+t3/gkR6LxxZbT/G4EAgpjHqWyLhoSq4Dn5P
f9s9lT/KpYxGM5RBetOF+Wm5+Duw7EkVQqvGuNNha8rC6zyvnfVqLn6onQCJ51x3
aPX/8rnZh3wRA7LbkvZbkr1sTiWpyWFNlpePXPKrDphKhFaSmKraRV0oreRlNlDk
AoGoVNNr6rx7HhkAuR58tmbME8hYyw9qP7UhFoQkFw==
=6Swa
-----END PGP SIGNATURE-----


