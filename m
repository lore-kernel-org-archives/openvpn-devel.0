References: <56D8A6C4.5080803@...2070...> <56D97EFA.9010207@...1147...>
From: ValdikSS <iam@...2070...>
Message-ID: <56D98171.7040103@...2070...>
Date: Fri, 4 Mar 2016 15:37:05 +0300
MIME-Version: 1.0
In-Reply-To: <56D97EFA.9010207@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kcus3u2GvEjdsa04u8FLN5vbheosb5JIw"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kcus3u2GvEjdsa04u8FLN5vbheosb5JIw
Content-Type: multipart/mixed; boundary="qHpw8mksEBeHMrKQ9q6Dr9goCtfar230r"
From: ValdikSS <iam@...2070...>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
Message-ID: <56D98171.7040103@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...> <56D97EFA.9010207@...1147...>
In-Reply-To: <56D97EFA.9010207@...1147...>

--qHpw8mksEBeHMrKQ9q6Dr9goCtfar230r
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Thanks for the information. It definitely doesn't work for any certificate,=
 probably only for chained certificates.
That's a good news that there's no protocol limitation for this. I'll check=
 the code to see what's going on.

On 03/04/2016 03:26 PM, Jan Just Keijser wrote:
> Hi,
>
> On 03/03/16 22:04, ValdikSS wrote:
>
> it's possible to send a stacked CA certificate (i.e. server certificate a=
nd intermediate CA cert) from server to the client. We use this in producti=
on, and it
> is done by simply stacking (cat'ing) the server cert and intermediary CA =
cert file into a single pem file. The intermediary CA is verified using the
> client-side ca.crt file and the server cert is signed by the intermediary=
 CA.
> I'm not sure what would happen if you stick two CA certs into the file, h=
owever.
> If this does not work: when looking thru the openssl s_server code I see =
a -dcert option which does something similar - looks like it would be trivi=
al to add
> to OpenVPN.
>
> JM2CW,
>
> JJK
>



--qHpw8mksEBeHMrKQ9q6Dr9goCtfar230r--

--Kcus3u2GvEjdsa04u8FLN5vbheosb5JIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2YFyAAoJEFzXIC7viPdyth4P/RTHunfrK2BNBdb1PZc9bP1I
VsO+/4G9HzoahxJ/jrfszoLbRlJyXFr67K83iK0IFZcljgP1P2hPX0v+FZy1iZMP
i/cVwOZp8+SK3+BN10xtjPkYG0wD5o+gW8DeF1uwd+e9JeVVqfKx7aGqjK8EkyRK
KJ7fFVmXpJKYBK72I96DLrPv8W/ojVnf8JKlR4xVOBR6W1T/2VkH+FD1t7Fr2c8I
XGhJfVtm+ypawPcfwHcmpf4DvcyRW7233d0rm971EzqOhoakLGF/OCHPiBl4REHF
/sFZD+FHHgVV5o16X5sFlfTBEGC6jZOCMrs/lP+DCqWtGmvBpTQfPNsftOwxrfFA
Ajvmmw+j0I0n3jKWIATT9HZmCPdr2AqwsoqHWtHcR3OMxFQZZMu1kLuqtDnmEqmz
iUfEKBEEYLf6VaPXI/YY99u3D9qU/jdINMYTG6074jvR31T2LUzwPaB3oHw0vwMl
EprJKA+QjCRcdrO4U/SW1Irsggo983QyThsKbesn3+4LQGjFLYH/3jCxy9pUkDjG
QF7QZHe8sam6APB7oc/DK0KnzK7d/ZCPlT5eIsq00ksUt8gaJjDSscgeDKj9Y7a6
BSiivfQKEdJXZlhi+j6usMX2+nd6m+hUOQt9NaKD2G7A4dLbe4nvnLM6tpd9q1F6
J/IxLi3dEJB9CGwsrnPY
=AuED
-----END PGP SIGNATURE-----

--Kcus3u2GvEjdsa04u8FLN5vbheosb5JIw--

