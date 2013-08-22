From: Josh Cepek <josh.cepek@...1085...>
Date: Thu, 22 Aug 2013 18:08:43 -0500
Message-ID: <kv65m0$qbs$1@...1062...>
References: <CANfRfr0zuKi5mf0vAFXPvnRtrsyyFx3EtpGpbzNJsCLBnqZxLA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="f4abEO4U69SnlKi7x4qDgdxMuWRIRN2VC"
In-Reply-To: <CANfRfr0zuKi5mf0vAFXPvnRtrsyyFx3EtpGpbzNJsCLBnqZxLA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When using UDP over SOCKS5,
 send the actual remote hostname (FQDN) to the proxy server in the
 first packet.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f4abEO4U69SnlKi7x4qDgdxMuWRIRN2VC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We discussed this patch briefly in today's IRC developer meeting, and
wanted some clarification on the intent/goal here. Comments inline (code
removed since we're trying to wrap our heads around the feature in the
general sense first.) Once we have a better idea of the intent, it will
be easier to look at the code itself more in-depth.

As Arne noted in this thread, detailed code review & a merge strategy
may well wait until the dual-stack support is in as to not complicate
his work on that.

On 08/08/13 12:59, Jesse Glick wrote:
> Also as: https://github.com/OpenVPN/openvpn/pull/6
>=20
> I was exploring the possibility of using a SOCKS5 server to multiplex
> OpenVPN connections based on hostname (in the remote option), akin to
> how HTTP reverse proxies commonly delegate to a physical server
> according to the HTTP 1.1 Host header=E2=80=94so that many hostnames can =
map
> to the same IP of the reverse proxy.

There was some issue figuring out what this all means. Do you have an
example use-case where this is helpful?

I don't understand the bit about multiplexing, since the idea of a SOCKS
transport is a one-to-one relationship. Since OpenVPN uses a single UDP
(or TCP) socket to establish remote connections, I'm not sure what there
is to multiplex.

> I found that the SOCKS5 protocol does support DOMAINNAME rather than
> IP V4 when using the UDP relay server. However, OpenVPN was never
> using this option; it always sent a preresolved IP (v4) address,
> giving the proxy server no way of inferring what hostname was
> originally requested.
>=20
> This patch amends the socks_process_outgoing_udp method to send
> DOMAINNAME for the first datagram of the connection, when an FQDN was
> specified. Thereafter it sends IP V4since this is more compact=E2=80=94and
> experimentation with the Dante server revealed that it
> calledcgethostbyname on many, if not all, such datagrams it received,
> which could be quite expensive. Since in the case of OpenVPN the
> =E2=80=9Cdesired destination address=E2=80=9D is constant for the life of=
 the tunnel,
> it should suffice to send the hostname just once.

This confused us too; what's the advantage of doing the DNS lookup
remotely? Presumably this is in case the remote end comes up with a
different IP than the local one, but what's to then stop the local side
from using the then-miss-matched IPv4 address the _local_ end resolved
and sending all future datagrams to a different IP than the first?

> socks_adjust_frame_parameters also needed to be changed to allow for
> the worst-case buffer size, a 255-character hostname (Linux generally
> only allows 64) plus fixed-length fields (7 bytes). It would be nicer
> to set this according to the actual hostname length, but I could not
> see how to obtain that hostname during this early stage of
> initialization.
>=20
> Filing this for the purpose of getting feedback. Probably there needs
> to be a user option to configure this behavior:
>=20
> =C2=B7 disable (restoring original behavior; perhaps the default)
> =C2=B7 enable for first packet only (as in the current patch)
> =C2=B7 enable for all packets, which could be useful in case the reverse
> proxy is using a single UDP relay server for many clients (since
> SOCKS5 offers no apparent connection identifier other than the
> BND.PORT)
>=20
> Note that the original code probably does not work with IPv6, but I
> did not attempt to address that in this patch.

Since >=3D2.3.0 officially supports IPv6, new features should probably do
so as well. The code as I see will simply "not offer" this feature when
info.proto =3D=3D PROTO_UDPv6, but then we need to document the distinction.

This is probably less important to address now; let's first see if the
rest of us can figure out what this feature's use-case is.

Thanks,

--
Josh Cepek


--f4abEO4U69SnlKi7x4qDgdxMuWRIRN2VC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSFpoIAAoJENcx2Xpgb9RjYaoMAJm1QM8wJ5v06ArYqwDllsbZ
Bc70B4znU1U5LT3Wl7GNVt/fXefHhgfTEnnLFvGXjmDE6r/u1juncYmcjWtF0AK+
i9ymTH6vTJyGbIcMIFIjAz7pYUcrgpZGpBMzE5YzpEJY8n35adPTDfXOcesrWOB+
cfqFhEYlzJ+k5hh+4qlpJa8BdsPPzHvUjKOwZsw5RyqG1al4qinviRKvbUdZHRCr
dC9+D4jte87REeGjIrW21XE5tYyu6yYumuoufp04s3CHU9QXUIbpe5zLpqH9qQ2T
1n5HhVgZ7jxtFBuRVUTwnIogZkOVeENzHmu524chEpxy6gCMRTWqHaY4rw9vy4RN
RhqBbl7QPAh+sOzEH/FqAIKraDeqhmUMAQiWby+l++KZREFPMf7ATHU5ELLV8KUh
Uuz3FRI83YAIlGrplHlR782czj1v6X28AHDYXHfR6Uztj7aLSfVMugLFsG0qfyj9
S8NVtDnsyf9UusA3YA22skeKq1dNwOT/DOeTP+paPg==
=yado
-----END PGP SIGNATURE-----

--f4abEO4U69SnlKi7x4qDgdxMuWRIRN2VC--


