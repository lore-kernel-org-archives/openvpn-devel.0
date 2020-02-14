References: <e70826e2-7ad7-e64b-76b5-14588ef98b04@...2385...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <547dfa19-3f2c-bc0e-ae9e-465566786627@...1227...>
Date: Fri, 14 Feb 2020 16:18:02 +0100
MIME-Version: 1.0
In-Reply-To: <e70826e2-7ad7-e64b-76b5-14588ef98b04@...2385...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OLNforLRryKmzywBEBhPkNy6RLO8UCf9g"
Subject: Re: [Openvpn-devel] multihome broken in the presence of asymmetric
 routing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Teodor Milkov <tm@...2385...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OLNforLRryKmzywBEBhPkNy6RLO8UCf9g
Content-Type: multipart/mixed; boundary="P9RRySU0ing88xVEX2eDoBdZfn5i7SdPU"

--P9RRySU0ing88xVEX2eDoBdZfn5i7SdPU
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 12.03.18 um 11:37 schrieb Teodor Milkov:
> Hello,
>=20
> I have the following multihomed setup:
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BGP1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BGP2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> +-----------+-----------+=C2=A0=C2=A0=C2=A0 +----------+-----------+
> | IP1.1=C2=A0=C2=A0 IP1.2=C2=A0=C2=A0 IP1.3 |=C2=A0=C2=A0=C2=A0 | IP2.1=
=C2=A0 IP2.2=C2=A0=C2=A0 IP3.1 |
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTR1=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTR2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vIP=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vIP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |
> +-----------+-----------+=C2=A0=C2=A0=C2=A0 +----------+-----------+
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VRRP=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-----=
----------------------+
>=20
>=20
> I.e. two routers with BGP to multiple ISPs. VRRP running at inner side
> keeping one virtual IP (vIP) up at the master router.
>=20
> Someday I hope I'll be able to use the vIP only for openvpn server bind
> IP ("local" config option). Untill then, for legacy reasons, I have to
> use the "multihome" config option, so that clients could connect to each
> of the 7 IPs (IP1.1, IP1.2, IP1.3, IP2.1, IP2.2, IP2.3, vIP).
>=20
> Unfortunately, Linux would not respond to /some/ clients over UDP. It
> seems like this is due to the way "multihome" forces the output
> interface using IP_PKTINFO when we have asymetric path to/from vpn client=
s.
>=20
> To provide single-socket UDP multihoming, openvpn uses the IP_PKTINFO
> data from recvmsg() and passes it as-is to sendmsg(). Apparently
> ipi_ifindex behaves in an interesting way under Linux. man 7 ip states:
>=20
>     If  IP_PKTINFO  is  passed  to  sendmsg(2)  and ipi_spec_dst  is  not
>     zero, then it is used as the local source address for the routing tab=
le
>     lookup and for setting up IP source route options.  When ipi_ifindex =
is
>     not zero, the primary local address of the interface  specified  by
>     the  index overwrites ipi_spec_dst for the routing table lookup.
>=20
>=20
> In my tests it's like /ipi_ifindex/ will override any routing table
> decision. But then if there is no routing table entry for the
> destination via
> that interface, the destination will be assumed to be on-link and will
> not be routed via a gateway. No error is returned to
> userspace, but if the destination does not respond to an ARP request on
> that link, the packet will be silently dropped. That's what I see with
> tcpdump on the openvpn server: arp requests for the dst address of the
> openvpn client. For example if a.b.c.100 is an openvpn client and
> x.y.z.1 is the virtual IP on the openvpn server to which the client
> tries to connect:
>=20
> 11:52:40.695830 ARP, Request who-has a.b.c.100 tell x.y.z.1, length 28
>=20
> I got it working by patching socket.c in the following manner:

Sorry for replying so late. I am just going through all open patches.
but with this i am not sure that it does not break the other multihomed
use cases where this behaviour is actually intended and you also only
tested it for your specific use case, so I am a bit cautious to just
include it.

Arne


--P9RRySU0ing88xVEX2eDoBdZfn5i7SdPU--

--OLNforLRryKmzywBEBhPkNy6RLO8UCf9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5GuioACgkQFRhsZwKx
RFSd1g/+KoCb9HYgzmK4OanvvarNlB30HArQcFdaCjZB7KKvnxOeYZWB29VK926b
ZFZaeYuEkdmjmFH1VE/oFnpDnjKnFAnb5+XsLnHUOMHUaXbQAmU15oA4oGframR4
/cphces/9V1BIUtuLB11MZzSvkqOYYR6n+iRTRN0GO+N7YmNmI1j0y+F9ZrgTTZV
vDEp8sYyMS8ZX6RqFyOrMjBziXWkto7pUVtoY3hWzgsJgto7VWkAOxVos+7M9Jiq
6UzMss9u1mgiYINzu+VTbzUcIqc4UmCULW3bpqre3rmKrZn0NR7YcpIUsu27Lf67
DOvvPmRx76S6x/hobARuHouot1ETYEB8sKP+5mZWScLwDHOO0jMLwMzgG5MnkARa
3yvsr2tXLEOTiiezdcExMiAw3AFPHI9FwR6uHfYiv2kUm2mScoQAf8fexFdxvpwM
nUR1BTCLBp1d3thU53/KuRmRz5MmH67+sBhWztsR4itlyy+iTyWyEB2Nqwtd1HOm
DcRhxQ8DlR2hsYccciqnWF44qzSZ5teT2sTwKVSkHpZRTO+uAY/O171dfk3Hrd/g
pvExMGxSAhhgVaEKBC/L5jokJichqDi8BDy6sOxxUofu332pJ1QWBgOlajd2cG8z
GHKMyzIq3XeIjaBErVfUuuPtWk82fuGQMQ+JijRwPWDRmfwiQsM=
=cOq5
-----END PGP SIGNATURE-----

--OLNforLRryKmzywBEBhPkNy6RLO8UCf9g--

