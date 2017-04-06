Date: Thu, 6 Apr 2017 15:05:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170406130520.GR93896@...1296...>
References: <11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
	<CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
	<3092a563-61dd-9240-b288-190b6f5fc259@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R5F1ZJCXXYWhzKr1"
Content-Disposition: inline
In-Reply-To: <3092a563-61dd-9240-b288-190b6f5fc259@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--R5F1ZJCXXYWhzKr1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 06, 2017 at 01:49:04PM +0100, debbie10t wrote:
> As you can see, the current proposal does not allow for first random,
> followed by expected/normal/regular renegs. It is either *always* random
> or *never* random .. I believe this is a poor decision.

Your voice has been heard, and nobody else of the core team has been
convinced.  It is not necessary to repeat that more often.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--R5F1ZJCXXYWhzKr1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY5j0PAAoJEB2Cnv7KVigSwtsL/0/oNX+t5BYNLOXvqR1G1yNb
Fz3Ci9f+G6HC51abmgIr2rfqIjbHa1gC6P2xpPYTxsb76+FHZg+d3S9CkresF/Q2
J55zQMsQLecpjOjd+Ttz64LH23OCdXx37Q060NGaJ3gb+Ram10vluGSxktahouxL
xWy3Pmy5cErmjVcIZzkfhUHCCVXc4iM/fPWCuWBImI9unSCZ8yKn/358JgrwtgAn
m7RXNUi9dyl89NxqqXSzjeVXKYek/8wdxCQU0nA232I+LYTO5VTg8GBr83Pv4qQ5
Z23LpADFy04tcqVmsVTPyq42twCrex58VoyFVF+ankq1GU5YAmknocbbETpkuh4N
Rx5JriImGGcrErHBnoIb3HVKeowlCJPZkFVPTTFGN4RQ9OX+/dRGLpnAxFhU77Cf
cyhPUpf++FSjhFnqbPRGlZe3JTvqn/24+DeIDlcvYMM0KM6SFfcM+q0BE4Ce3y19
VNrvXQF8LSlU32YZnYvZvyRijhTTiCwA4KsUfvCrDQ==
=b5an
-----END PGP SIGNATURE-----

--R5F1ZJCXXYWhzKr1--

