References: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
 <56ed6984-aba1-ffeb-8cd7-7591b75dbae4@...2080...>
 <20201102182243.GT976@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4dff8380-89c5-0e54-469b-02f27f2c3978@...2080...>
Date: Tue, 3 Nov 2020 17:09:12 +0100
MIME-Version: 1.0
In-Reply-To: <20201102182243.GT976@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9e1TOhCKqK2eqma5RMHqe0J3A6A7evYZA"
Subject: Re: [Openvpn-devel] OpenVPN 3 Linux client - v11 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9e1TOhCKqK2eqma5RMHqe0J3A6A7evYZA
Content-Type: multipart/mixed; boundary="a0bdQz2qlBR2RiG629Xh2h2KGDQLKyEEv";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <4dff8380-89c5-0e54-469b-02f27f2c3978@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN 3 Linux client - v11 beta released
References: <ed56b8ea-00b7-eac2-7ab7-9bf9f21c838a@...2080...>
 <56ed6984-aba1-ffeb-8cd7-7591b75dbae4@...2080...>
 <20201102182243.GT976@...1296...>
In-Reply-To: <20201102182243.GT976@...1296...>

--a0bdQz2qlBR2RiG629Xh2h2KGDQLKyEEv
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 02/11/2020 19:22, Gert Doering wrote:
> Hi,
>=20
> On Mon, Nov 02, 2020 at 03:00:58PM +0100, David Sommerseth wrote:
>>>   Then the imported configuration profile must get the DCO feature
>>>   enabled:
>>>
>>>       $ openvpn3 config-manage --show --name CFGNAME --dco true
>>
>> So I managed to introduce a typo here, this config-manage operation
>> should use --config instead of --name:
>>
>>         $ openvpn3 config-manage --show --name CFGNAME --dco true
>=20
> Yeah, right.  The difference is quite obvious :-)

Gah!  If this fails, I'm giving completely up! :)

         $ openvpn3 config-manage --show --config CFGNAME --dco true

Hopefully, I didn't mess up again :-D


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--a0bdQz2qlBR2RiG629Xh2h2KGDQLKyEEv--

--9e1TOhCKqK2eqma5RMHqe0J3A6A7evYZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfoYCwAAoJEIbPlEyWcf3yq9cQAJ0ovQn4E7U/LrBjie7eybGq
aN8LmR++d0ijAneqDjCNAzqnaZo9Jmvh+QQ4n3jJlVepkWNkGnbH/ncQzJecxCds
xNDcO3shcauHAjUFTITURijW1zWfD1h6lH7xOjM1McMSv2E4QAzKx88qoKYrwDAn
bFYz/3d4P5B4hBHcKEJHQWXEGd9g6jsowMFjAqt+9Vkack/VPa6bBG1aL/jKgR74
VWShniao7sN1G0XWPo4MubkbnkjZIBujnQLxncCS7jZTnPnWAAsv1hiX8lyQPz7T
ZvD+EsTY5CfEgttOqtR8QrQ54wVUM5lcGVltFB/YdQMt+aP7tjx7+KxpeF/bllLk
6f8gGc7CkVf5fN+QgZEf8ulRfsH4hoUCb/jinCxW1jNTHTruZ0Cw6svWXBopRuyK
euAELJkX+TWEnXkWlNogl98vmdkwkptfMATNxbrKbGYtjfdgtFX6gR3Pl3ErLAed
uFFmeJxjapY4v/24Qem/lyQURerR0HvOsK4EflmzbkhEkCjRYFFsAp/QoESwY7SN
C79+wumr1Um23G+A4G4quC+X8PZwgiL0wcxB+XkfEqUp1L+jMedAlewYNtuc6D37
zjvTPKJU8Swurwlu7H/nvv+OScc1rlmFAhrkFHcDDH690P6MyJFzrBa2e3O8bneW
lKQRiQOPqBRY8kRHHqzt
=SpoU
-----END PGP SIGNATURE-----

--9e1TOhCKqK2eqma5RMHqe0J3A6A7evYZA--

