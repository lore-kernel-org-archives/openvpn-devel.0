References: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
	<51ef426c-c8ee-6019-c4c0-124558888fbc@...2080...>
	<86da1d4c-d798-da76-9079-6037f0c1cd9a@...515...>
	<CAEsd45Q1goosYtGHD4iZUU3ZfT+Vng8sp6F6Oo2ZuNKMVtMgpw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <717aba44-6a5b-5bfc-793d-89a015636367@...2080...>
Date: Sat, 20 May 2017 00:41:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45Q1goosYtGHD4iZUU3ZfT+Vng8sp6F6Oo2ZuNKMVtMgpw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="geffDjuIvLXr801ro6LiNUVTOrclmWFv9"
Subject: Re: [Openvpn-devel] Problem with sig for 2.3.16?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--geffDjuIvLXr801ro6LiNUVTOrclmWFv9
Content-Type: multipart/mixed; boundary="OJEk7POGUQk6AreBpXkarKf2G573AkVj9";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "Jonathan K. Bullard" <jkbullard@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <717aba44-6a5b-5bfc-793d-89a015636367@...2080...>
Subject: Re: [Openvpn-devel] Problem with sig for 2.3.16?
References: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
	<51ef426c-c8ee-6019-c4c0-124558888fbc@...2080...>
	<86da1d4c-d798-da76-9079-6037f0c1cd9a@...515...>
	<CAEsd45Q1goosYtGHD4iZUU3ZfT+Vng8sp6F6Oo2ZuNKMVtMgpw@...278...>
In-Reply-To: <CAEsd45Q1goosYtGHD4iZUU3ZfT+Vng8sp6F6Oo2ZuNKMVtMgpw@...278...>

--OJEk7POGUQk6AreBpXkarKf2G573AkVj9
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/05/17 21:23, Jonathan K. Bullard wrote:
[...snip...]
>> Right now the signature situation is a bit confusing, as 2.4.2 is still
>> signed with my new key, and 2.3.16 is using the security@...515...
>> key. That is all documented here, though:
>>
>> <https://openvpn.net/index.php/open-source/documentation/sig.html>
>=20
> OK, I get that, but the key file from the link David provided (and
> which was also in his reply to the email announcing 2.3.16):
>=20
>  <http://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x12F5F7B42F2B01E7>
>=20
> is not identical to the "Security mailing list GPG key" I just
> downloaded from the "sig" page.
>=20
> Is that a problem?

What is the difference you see?  To mem both looks identical when
importing them into GPG.  But I haven't dug too deep into the details.

One detail though, the "real" key ID is always the finger print.  Then
there is two types of key IDs, one short and one long.  But those are
just from the last bytes from the fingerprint.

Key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
Key ID - long:                                  12F5 F7B4 2F2B 01E7
Key ID - short:                                           2F2B 01E7


When I import both keys into the different brand new GPG key rings, I do
get the same result when listing these keys.  But I haven't dug too deep
into the context.  Plus the pgp.mit.edu site might have done some
non-critical, minor changes in how the key looks like - compared to
Samuli's version.

That said, this security key is based upon the recommended sub-key
approach [0].  That means that those of us among the developers can only
use that key for signing and decryption data and with a fairly short
lifetime (1 year).  They are not capable to sign other keys, updating
the lifetime of the keys or any operation requiring the master key.  So
I highly doubt Samuli have done anything special with that key.  Only I
have the master key, which is well stored on a protected medium which is
offline the very most of the time.


[0] <https://alexcabal.com/creating-the-perfect-gpg-keypair/>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--OJEk7POGUQk6AreBpXkarKf2G573AkVj9--

--geffDjuIvLXr801ro6LiNUVTOrclmWFv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZH3SWAAoJEIbPlEyWcf3yNOIP/3iI2DApWQmWYZ0RZ+aAbU2m
ZiuVUKJf0fxiyxspCTHWMF6NwLWXxeim+G1vIZoWotvg7YN7ldjXxuFMcFyj+Trl
ORU1DQcjShx/ZjerT7U4OuJMeNocOKekrJw/Pgk1uJEbMc4waAR6PaqDvBl9BEf7
C+ttgDb1mVdE52qBdVykN1w/BToXKPg9IBsHK4U6tozEbb8t9/dh7AjC5mE0Vod1
XfVpEuA4lj/jiaGvmEYVH5X1u3MTcifSW4wBMkhToXs+cCl4KlKQdYNgVrBYZ2Uf
HO/PUkVh641AlxBs2pYEa+U6gYe1NbkSD+GHPj0bCAHG0QUXv40U/vjbMpnIYjnl
qRBA3SvavnxOyAkNGf+JCe97MSDUQcrswZhK1RsKQFPRjnePRO9/Am3q5vvLLxvv
8vSkwVf7yV1ElW5UywA5O0l0+FR6fWpQwhErlsgq5xT0j/VR2FFXNx6eIdbJuw8x
Rz9n7VUM9XbkLz/taLj+pUaekFHwvtMGdcsFFfAf+Tt3a3hEvaYF3L2fJX9TNANo
4coXda6q5m9wpIuQ6jjN7kZCQ/7oNED3SoAUV98TjaqN+sviwsy1z+srr6mhTofx
DFJyqYvC1I/9lWhb3IxWvjW4jEgbhnr5nfDXrvCqlTWqUzjw3oqBPVGA9jUhtW/a
confU+HPsyNcMc+0/BG7
=V4O3
-----END PGP SIGNATURE-----

--geffDjuIvLXr801ro6LiNUVTOrclmWFv9--

