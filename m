Date: Sat, 7 Jul 2018 21:25:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180707192528.GQ989@...1296...>
References: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
 <06da91cb-ef1e-69db-e131-5d27fcfeee5f@...1227...>
 <BN6PR04MB09324E370F6540239CDD610FDD460@...2439...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aSRrXo8NJAoPLte9"
Content-Disposition: inline
In-Reply-To: <BN6PR04MB09324E370F6540239CDD610FDD460@...2439...>
Subject: Re: [Openvpn-devel] OpenVPN Connect App on IOS // Support for
 IPv6-only networks with DNS64/NAT64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristian McColm <kristianmccolm@...160...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--aSRrXo8NJAoPLte9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 07, 2018 at 06:55:44PM +0000, Kristian McColm wrote:
> I tried setting "mtu-disc yes" in the VPN server but it didn???t appear t=
o have any affect. Do you have any advice on how to handle this scenario?

mssfix 1300

(won't do anything for large UDP packets inside the tunnel, but will=20
fix TCP.  If you really need large UDP, try --fragment 1400 - but this
needs to be turned on on both sides, OpenVPN server and client, and will
cause some overhead)

The "I have no IPv4 default route so my local 464 component messes up
IPv4 connections through the tunnel" is annoying, but not truly surprising.

(And the real culprit here is "Apps using IPv4 literals" - those are=20
the ones to blaim that apple had to add that local "DNS64-like" component
for IPv4 literals - which is now breaking the same apps in a VPN context)

But if "push default route" works as a workaround, this can be documented
and things will be fine...

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aSRrXo8NJAoPLte9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbQROoAAoJEB2Cnv7KVigSrmML/2ulSPyoRDr71jcYarnEhfK6
e6XjUej3raxUzeZoq0F7PIuHTo7kc/lWen1P4l7VvbufLKR+0ejg9XfN8egtsdki
FBoEDnf2gc2cTqN0RprKRdoXQ7UNebwfNbPbajDbRM3+wxmhUbFhG9mVtoGDb+et
qbDwdSMGrNFKIq9tD5JMvmBwLz3eDDTMB/hWJJPCK8z0tqJiZoyO5A+i5lfEuYCF
tfjOIBQ6u9GYPX+Xg75D+lEjCu7X6cUQPxnkG8dyNqvih2FCUeeGhCdad7z1GHy5
M/8vfHmGjucTcGp0DTbL0xM/8Y5L5EtH246pFIHtZsQWhBZJzLpsEM/I6gdjYequ
53TyIKhSQYN1OWxga2v4Ql06e3lteJyW1s+HTUVreYGkJdQKTl4TVQaScoR2ta16
UOMULX3k6+9bXSoR1fIXW9NB9gJfQwQCKMAyKudHpyRlqz39SHfHj1mLVBaYoeDD
4ARyaNet/ejbjiQh4u6b5qHOEcvIU0Kk0n4n4eHdbA==
=gORP
-----END PGP SIGNATURE-----

--aSRrXo8NJAoPLte9--

