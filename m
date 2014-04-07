Message-ID: <53430F50.4040709@...1227...>
Date: Mon, 07 Apr 2014 22:49:20 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20140406083549.GG16637@...1296...>	<20140406085311.GH16637@...1296...>
	<20140407201711.GN16637@...1296...>
In-Reply-To: <20140407201711.GN16637@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="eNXrnUFXw4cw9oe6kaa3Kh33fjUKwPdit"
Subject: Re: [Openvpn-devel] getaddrinfo() confusion / way forward?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eNXrnUFXw4cw9oe6kaa3Kh33fjUKwPdit
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 07.04.14 22:17, schrieb Gert Doering:
> Hi,
>
> On Sun, Apr 06, 2014 at 10:53:11AM +0200, Gert Doering wrote:
>> A slightly simpler version of this could go to the beginning of
>> create_socket() (--> no ai_next chain walking needed, etc.).
> Arne suggested an even more simple version of this - which is convincing,
> because it takes away lines of code, instead of adding more :-)
>
> Patch attached.  (Tested, works!)
>
ACK from me to basically my own patch.

Arne


--eNXrnUFXw4cw9oe6kaa3Kh33fjUKwPdit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNDD1AACgkQe8+cMNS4zReDZwCeOxIN/Qh98BM4FF29I4A28Mf3
MHEAn35PVH4JdNcuVQAqtyn00YRbS9gj
=1xYi
-----END PGP SIGNATURE-----

--eNXrnUFXw4cw9oe6kaa3Kh33fjUKwPdit--

