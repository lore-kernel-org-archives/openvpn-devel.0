References: <20171205121952.13008-1-EngyCZ@...277...>
 <CAKuzo_g6YTkx+-3i=TEFn9b2yPjx9rBweTz=4H7uuOT8VokEdg@...278...>
 <CAHODtZSTyD8NOc8cVNaGaZ9z+HZrKK-+L6h_t0gqhAh3pJMk+w@...278...>
 <CAHODtZQRb48Aa8AsxXoSnUUSLE27u-EjCOWavFJj7nwZqPYd7w@...278...>
 <CAKuzo_g8KXGKN-A-egEonQEFpkro5wb5OigDbycg0j_Ae=5Tow@...278...>
 <CAHODtZThxjAUb-sZ4bA1Y238hPeK=zKGcSbU9d3nib+8rt0YMg@...278...>
 <CAKuzo_gb4Sdqa3WLb=34kdwqvz507mKeyVyfhKvY6RassZz7Mg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <47ebda81-a785-2512-e0f7-2b9179eade2e@...1227...>
Date: Thu, 13 Feb 2020 15:53:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gb4Sdqa3WLb=34kdwqvz507mKeyVyfhKvY6RassZz7Mg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EJwiSRxxSyN8OfTXvHy1m8kXu1MpLcHkA"
Subject: Re: [Openvpn-devel] [PATCH] Add a warning for disabled DHCP media
 sense on Window
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EJwiSRxxSyN8OfTXvHy1m8kXu1MpLcHkA
Content-Type: multipart/mixed; boundary="fta3W8rLHEgRk8wckhREmDrhXeScS8A88"

--fta3W8rLHEgRk8wckhREmDrhXeScS8A88
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.03.18 um 17:17 schrieb Selva Nair:
> Hi,
>=20
> On Wed, Mar 14, 2018 at 3:32 AM, Ji=C5=99=C3=AD Engelthaler <engycz@...1664...=
7...> wrote:
>> Hi.
>>   You right. Disabled dhcp media sense can be set as global for all
>> interfaces or in adapter specific setting if it supports it (TAP supports
>> it).
>> But for must users is the global settings hidden deep in the system and =
for
>> me it took several months to find the cause of my problems. Interface
>> specific settings can be cleared by uninstalling and reinstalling OpenVP=
N.
>=20
> Well, Windows ships with media sense enabled, isn't it? So if its
> disabled, either the user did that or some third party application did
> it for some reason. Without knowing those unknowables, we can't even
> decide whether to suggest the user to enable it back or not.
>=20
> Whereas, using --dhcp-renew (or making it the default) looks much
> simpler and something in our control. Anyone knows why it shouldn't be
> the default?  I don't see how it could hurt except that openvpn needs
> to fork to run --dhcp-renew when the parent process is waiting for the
> the interface to get the address. But that's not a big deal on a
> Windows client.

This on of the old patches that are still pending. It seems that the
original submitter never replied. This is still something we want to
merge or should we just "close" due to timeout? I am not too familiar
with the DHCP problem to have a good opinion on that.

Arne


--fta3W8rLHEgRk8wckhREmDrhXeScS8A88--

--EJwiSRxxSyN8OfTXvHy1m8kXu1MpLcHkA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5FYtAACgkQFRhsZwKx
RFT/9Q//U5UVh6+Qc+lAw5lmuROleG0iiyakNaO5dD44JxQUkKP9uTUbpoXiNVR2
Hmjvj6p/zNQz1XnJ6eH/7SSY6AtdrI0eW7jTr/84XmVQAf9C/RySA+RWBuSOBol1
PpyMu+3ADc8TFEQ0f2RxSnBpG2oDYmQFyqqpu0+QiJ8Y0FwBbAtrVi/7tAOhASTq
n9Qj4HdC15TN16E3TJkEUtj0TzNA5gdauvgKepfTeGqnFD1Ko5ib8ZjdQ47LjOvo
GNYvoIwV2vmW5DhZct/5WQtlwjQTgWWtfC/xQoBJBGpvelvk8X5TUwesh9T0Z2JN
h9yjUi9Kz3iQBtThinHDtmfSUvLHO/crR9BedgULFQX9VgPCrao2R24x6tfXkXOl
q7NHwCyX2EEv8NayssNhlsxABaQukyvJ08dyVmpBtB+XMCSeDWC9+tpZef2V+Th5
KRsOryO73nFDF4MxMVmQlctkii1Vv3PTqq92uK5Bq9PTiFXx1+Xjeax+q61jnv1X
R/Jxuk7jZd4jkPaVxXZ3m5pPPQqS2XrQBKIhxZMPqMlylzczbcJ3yn+O/cESb+Mo
mUxQk/FC7o9tRKhr+g521uM/rKkfpXPFBOuQogZ7Jw+JS5YJLUm+5Rkkv6kal+0I
zjHIjdEqMCwu1E76DZMIqioHOUNM+lixXcaKa9rf70fwZVqWhNk=
=Zp9w
-----END PGP SIGNATURE-----

--EJwiSRxxSyN8OfTXvHy1m8kXu1MpLcHkA--

