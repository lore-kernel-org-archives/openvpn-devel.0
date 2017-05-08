References: <15905c0a-8735-f447-f81a-750c834e46d7@...193...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0327e6eb-5648-d404-1f0f-ca88d7794b95@...2080...>
Date: Mon, 8 May 2017 17:57:32 +0200
MIME-Version: 1.0
In-Reply-To: <15905c0a-8735-f447-f81a-750c834e46d7@...193...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c36FaL80op0B1L2JRaXbG0ldk4XL9ur0u"
Subject: Re: [Openvpn-devel] regressions in openvpn 2.4.1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Farkas Levente <lfarkas@...193...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c36FaL80op0B1L2JRaXbG0ldk4XL9ur0u
Content-Type: multipart/mixed; boundary="79eqV3oXe75EaNO7VAgrmfeSeEXaG3i9v";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Farkas Levente <lfarkas@...193...>, openvpn-devel@lists.sourceforge.net
Message-ID: <0327e6eb-5648-d404-1f0f-ca88d7794b95@...2080...>
Subject: Re: [Openvpn-devel] regressions in openvpn 2.4.1
References: <15905c0a-8735-f447-f81a-750c834e46d7@...193...>
In-Reply-To: <15905c0a-8735-f447-f81a-750c834e46d7@...193...>

--79eqV3oXe75EaNO7VAgrmfeSeEXaG3i9v
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 08/05/17 17:26, Farkas Levente wrote:
> hi,
> after we upgrade our servers and client to 2.4.1 we detect many
> regressions.
>

Please, can we have these issues handled *ONE* place?

You already opened this trac ticket:
<https://community.openvpn.net/openvpn/ticket/886>

And that's where we've started to respond.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

> - first was that with this the server no longer works and the server
> restart fail after upgrade. imho it's not a safe behavior. but it was
> easy to fix at least.
> script-security 2 system
>
> - then the new systemd unit files (ie openvpn-server and openvpn-client)
> not working. ie if i move all th config file from /etc/openvpn to
> /etc/openvpn/server then the server fail to start. and still not found
> any other solution then move back the config files. i open a bugzilla:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1446795
>=20
> - but the most annoying on is that if the server runs and a client
> already connected but reboot the client then in most case it's not able
> to reconnect. on the server log we see this error message:
>=20
> Sun May  7 23:46:57 2017 .. PUSH: client wants to negotiate cipher
> (NCP), but server has already generated data channel keys, ignoring
> client request
> Sun May  7 23:46:57 2017 ... AEAD Decrypt error: cipher final failed
> Sun May  7 23:47:02 2017 ... AEAD Decrypt error: cipher final failed
>=20
> but if i restart the server then everything working perfectly and a the
> clients can reconnect.
> relevant part of the server config:
>=20
> proto udp
> dev-type tun
> dev vpn-udp
>=20
> remote-cert-tls client
> cipher		AES-256-CBC
> auth		SHA256
> tls-cipher
> TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256:TLS-ECDHE-ECDSA-WITH-AES-256-GCM-=
SHA384:TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256:TLS-ECDHE-RSA-WITH-AES-256-GCM=
-SHA384:TLS-DHE-RSA-WITH-AES-256-CBC-SHA256:TLS-DHE-RSA-WITH-AES-256-CBC-SHA
>=20
> topology subnet
> client-to-client
> comp-lzo no
> persist-tun
> persist-key
> persist-local-ip
> keepalive 10 120
> push "comp-lzo no"
> push "persist-tun"
> push "persist-key"
>=20
> nobody has the same problems?
> thanks
>=20





--79eqV3oXe75EaNO7VAgrmfeSeEXaG3i9v--

--c36FaL80op0B1L2JRaXbG0ldk4XL9ur0u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEJVsAAoJEIbPlEyWcf3ypD8P/jfn96a2JzdwV2k/mElvC6mO
EfSkLWEsYL4IFomkwz/qCSBl+WfoQAMSeRp4KASTUmaSFcp6GnOFzv/elCqTxTXC
J28y3KCDVa6FGGCHRzJvNNaE4Xwd6vMP7Ij6BvIurSFNkprFlVVGegZ9e1itKbq3
8fI9ed8XondxZl12t4WhmWo9NABGyklcoqIGsZqcO9qis33RZGdGqN6p7bfz2KgC
afUzOcDKooL31NLrHYSCnSu74WtNt4FbRzvfaUU/Wd8C9w4L+ORkiSoNdQqWtyDD
QFP58x0SOl9979hSdFlPjvOM7PkMrApw9hLn+kK256dq+64gqLJzMK8fR67zaJ/s
tov+7cZZfWCP5jGi+Dn8QG+ogwdZjVwa6mSRb7UMuaC1rRz3zUXVPAXY6CAqQdDN
zGGvzGpmJ+fs1nyvYeCO/zZ/xw+GjOHBDkQfZq5HjtrhgjuJogfEBOjZZc9tbXvH
yvJxuno6eUlRFFFMQyw0suU++ceObbGDtJO+O+j5twzqt0e7sdCsIm+1t8ML869z
r05vr6y9asgdSrQlqgE6YO2IcuINHxSKsCIli0/NPWhJCODJzu2U0iAtTGhBBDSg
2jJKvexYApWyr6zpi6nMD5xQBrUjqwWwCBjZ9lnVofvtJRJ2YQIaW+SKToHMJ0B5
XD41OMsCdE01iZd7XcAd
=VPT/
-----END PGP SIGNATURE-----

--c36FaL80op0B1L2JRaXbG0ldk4XL9ur0u--

