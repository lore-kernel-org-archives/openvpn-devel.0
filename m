Message-ID: <53B03B43.2040009@...1227...>
Date: Sun, 29 Jun 2014 18:13:55 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAGyAFMXhPTamN5tZYr92=re8Bhxky=priWS8UhCU3E_p2D8-mQ@...278...>
	<CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>
In-Reply-To: <CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="nCWojv8DLplM3cUxxO4RhtqlQGhwhrglu"
Subject: Re: [Openvpn-devel] session-id implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nCWojv8DLplM3cUxxO4RhtqlQGhwhrglu
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 27.03.14 09:57, schrieb Lev Stipakov:
> Hi,
>
> Same patch with added NULL check in push.c:308. Turns out that
> peer_info might be NULL.
>
I looked at the patched, a few minor nitpicks:

- The test should be if the IV_PROTO is at least 2 and not if exactly 2
- use_session_id should be bool instead of int
- If I understand the code in ssl.c tls_pre_decrypt corrrectly the

          ASSERT (buf_advance (buf, op =3D=3D P_DATA_V1 ? 1 : 4));

will give an asserton if the other side just send a packet with only
P_DATA_V2 as op code and no opcode.

I have not checked if the addition three bytes cause any mtu related
issues. Other than then that the patch looks good.

Arne


--nCWojv8DLplM3cUxxO4RhtqlQGhwhrglu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOwO0MACgkQe8+cMNS4zReOvgCg82JB4pB7GURPTG1z6L0ms+eu
NSsAmwT9qq1E6IVnCQPAKE35aF7s98AO
=kdzt
-----END PGP SIGNATURE-----

--nCWojv8DLplM3cUxxO4RhtqlQGhwhrglu--

