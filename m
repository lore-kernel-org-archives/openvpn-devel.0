Date: Sat, 9 Apr 2022 10:19:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YlFBo/UOAxeNlBPf@...1296...>
References: <CAAYFXLmLN3mJ1hqJrhhhqBeXwWaFHOMCMUx91BujJpnm0KM-Kg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WhnC7cu/pKG9rfTv"
Content-Disposition: inline
In-Reply-To: <CAAYFXLmLN3mJ1hqJrhhhqBeXwWaFHOMCMUx91BujJpnm0KM-Kg@...278...>
Subject: Re: [Openvpn-devel] Tips for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pete Nelson <petiepooo@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WhnC7cu/pKG9rfTv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 08, 2022 at 06:24:07PM +0000, Pete Nelson wrote:
> I'm looking for tips on testing a dev branch of openvpn.  I see I can fork
> the github repo and enable actions to test that it builds on various OSs,
> but what do you guys do for functional testing?  Do you run a bunch of VMs
> or docker containers and have them connect to each other?  Any tips,
> scripts, or setups you can share would be appreciated.

This is... complicated.

The openvpn tree itself brings a test script, "t_client.sh", which runs
a number of OpenVPN instances, verifies that they come up, interface IPs
are "as expected", and then runs pings to see if the tunnel works.  There
are no pre-defined tests, as you need a server side to run the test against
(but see tests/t_client.rc-sample).  If a t_client.rc file exists, this
is run as part of "make check".

I run a number of server side instances (2.2, 2.3, 2.4, master, tun, tap,
udp, tcp, ...) that the official buildbot army connects to, so we know
that all "normal" things should work.

In addition to that, I run "server side tests" where 1x/day a "master"
checkout is installed on a dedicated server test VM, and then the
driver script ssh's out to a dedicated client and runs 2.2, 2.3, 2.4,
2.5 and master clients against this newly built server.  This setup
also includes lots of plugin tests (plugin_auth_pam, succeeding and
failing, client-connect plugin, sync/deferred, ...) - but unfortunately=20
this is not in a state easily shared.  The client side for this runs a
modified t_client.sh which can handle "expect fail".  Need to clean this
up and include in the main repo...


My tests focus on network/transport though.  Steffan runs a test rig
(... that he wanted to share, but had no time yet) which focuses more=20
on TLS behaviour - valid cert, invalid cert, expired cert, CRL, ... -=20
this can not be done properly with t_client.sh "as is" has no "this=20
test is expected to fail" logic yet.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WhnC7cu/pKG9rfTv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiUUGjAAoJEB2Cnv7KVigSEyYL/1u9/4ZTKn0cSBgUl7nEbUEA
XIx/OUV9e4zaLm2YA/c7hBc05FHmNpMw4yVL3luEnEKbFidaP8iR9N7ccN3wfa6A
O5FhrJVOm3YtKEZIUTCiL1oOKl8ngDCVTPB8OCinrLYZFdjDEs7s6+RUS0Lg7TK2
0R/cBRmBR66ICicN9gv7uRYfyzf0mPyaI18lRlePWG/MY2uwzqJfeuDDs0eeMV09
2Wntpy6DzPv0ra5vVUNhi/gbdaRLI15nh7QIceP4f7UDpz/bzJi3eys/yI5FukP4
pXkraar56lzNU5Nn2q264O2nb0uXR1rP3KEvSUFsT7dG1+bzZ4Ze0b8kABf8gcdG
0FpHKQeps9ZXIZoFQ2+6b61GsONSrRl4N//NbCDJtmgo2LDXaKfaC1BIEiP+iqSU
IXnnhbC5FvxFbUwfbpPBQPbVSV7KJ6M/Uo3tUzZTegJHftPyKnSAJW0l3sSxBpN7
gr0fbHUe/l6WOtfmXKw14jtbmUAOV60cKwfjOTmMnQ==
=xfPL
-----END PGP SIGNATURE-----

--WhnC7cu/pKG9rfTv--

