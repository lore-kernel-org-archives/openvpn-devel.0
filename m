Date: Wed, 25 Apr 2018 14:57:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180425125731.GZ69387@...1296...>
References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...>
 <20180424120337.0fab107d@...1799...>
 <20180424130817.GA20143@...2161...>
 <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UJZgE5sa6ExqK3JD"
Content-Disposition: inline
In-Reply-To: <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Simon Ruderich <simon@...2161...>, Christian Hesse <list@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--UJZgE5sa6ExqK3JD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 24, 2018 at 11:08:22PM +0800, Antonio Quartulli wrote:
> Generally speaking I believe that openvpn, as a VPN and partly routing
> daemon, should be allowed to run with CAP_NET_ADMIN set as it enables
> more features (tunnel reconfiguration to start with).

If we go there, we might consider dropping all non-default capabilities
before running external programs (--up, --client-connect, ...)


This patch is a bit "gallopping ahead", though - it needs a somewhat
more solid agreement on our privilege model before modifying systemd
unit files...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UJZgE5sa6ExqK3JD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa4Hs6AAoJEB2Cnv7KVigSOU4L/3C50U0VcPpr5PRvplRUmWWI
kjTfaxTzL1yqez4fIaSxD0mwSu5Rk4q1OP4KlY/QapGZs9rZGdD+GUAIajrzdWir
ClSP2RtLqUAes3VESbX28apV7x5szXaLQf3Dg9wffSByJe2/2SsmwtbkZ/5/XZTd
oqeHLHkEQABN3JCOIrhtuF/wLX0VhrjA/20k4wW60E+8EBNt9/rxK6DhTmUBJCPr
E7NMoWnAOov9XvVoymqBfX9k5157Eo6NcqT8Qigcmtv4JK+h0o3d6xKVLidYi7AQ
2xi+D/3V8EkK4ssu6G7BBqZmnwwYQvD1+UP98iz78SPq0kg+eNPymcm1O1CV0bAs
im9pIVHBruT+fvUa8phZjUvUmQgflruE4mGIgBp3N/kzjbbGaUnPnoNZWRgfKNDd
iQ3Tc7De8kpik4UJOKje9MOMP58laB79YkbQCABa81D2dkICT6z7AP1VNl24+yh7
EBuZIaToh+65RLhBer532kVtsoAb+y5Yi2HMC4SbCQ==
=BHzG
-----END PGP SIGNATURE-----

--UJZgE5sa6ExqK3JD--

