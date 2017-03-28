References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
	<131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
	<20170328124704.GW93896@...1296...>
	<296b8d47-a05d-c4e5-1d87-1ffcff2166ca@...277...>
	<ac9bbf70-f1a3-78b5-5d88-62df26cd12b9@...1435...>
	<9e659389-963d-d071-00bc-a2ee3a3849d6@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <4f959c35-afbc-9f10-21cf-20da31aac35b@...1435...>
Date: Tue, 28 Mar 2017 15:41:29 +0200
MIME-Version: 1.0
In-Reply-To: <9e659389-963d-d071-00bc-a2ee3a3849d6@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EgX4lXfMI6pcUTJEEBGC7UdH3PrS8fKj0"
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

--EgX4lXfMI6pcUTJEEBGC7UdH3PrS8fKj0
Content-Type: multipart/mixed; boundary="fBbRAqF503V16N5xTB7qNAWCEGREgflI5";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <4f959c35-afbc-9f10-21cf-20da31aac35b@...1435...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
	"crypto.c:823:32: error: invalid application of ???sizeof??? to
	incomplete type ???cipher_ctx_t"
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
	<131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
	<20170328124704.GW93896@...1296...>
	<296b8d47-a05d-c4e5-1d87-1ffcff2166ca@...277...>
	<ac9bbf70-f1a3-78b5-5d88-62df26cd12b9@...1435...>
	<9e659389-963d-d071-00bc-a2ee3a3849d6@...515...>
In-Reply-To: <9e659389-963d-d071-00bc-a2ee3a3849d6@...515...>

--fBbRAqF503V16N5xTB7qNAWCEGREgflI5
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28-03-17 15:31, Samuli Sepp=E4nen wrote:
> On 28/03/2017 16:08, Steffan Karger wrote:
>> On 28-03-17 15:02, debbie10t wrote:
>>> On 28/03/17 13:47, Gert Doering wrote:
>>>> We need to communicate better what might affect users in new versions,=
 so
>>>> they can test and complain/adjust in time (like, the stricter CRL hand=
ling
>>>> in 2.4, and - obviously - the --tls-remote bit)
>>>
>>> Suggestion: A Wiki Page detailing deprecation plans with dated targets.
>>
>> We have Changes.rst for that:
>> https://github.com/OpenVPN/openvpn/blob/master/Changes.rst
>>
>> Let's please keep this list on one location only, and I think
>> Changes.rst is the right place.
>=20
> Ah, Changes.rst had "Deprecated features" section, good. I think that is
> sufficient. The question then becomes: do we need to link to Changes.rst
> from somewhere so that people find it?
>=20

Yeah, linking to the changes.rst on github (which gets nicely rendered)
from the wiki sounds like a good plan.

-Steffan


--fBbRAqF503V16N5xTB7qNAWCEGREgflI5--

--EgX4lXfMI6pcUTJEEBGC7UdH3PrS8fKj0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY2mgNAAoJEEEwndWOY1w5/zUH+gJtyfNG1qD+hw/aGw5Zrakl
DHS66DfBM9DWNKlrBzIrUNA3ltmd6OjRTdtUFJuPS+p5JUN/9e5DATGhAfAi/86F
qhNJXKowYxPEJyhkQrf4L7WIiptt2mS4MAUAS/zjlnogZSZYu9ju+q4clggvQLqz
bbpLG6mc+oV8s22hXQw8lEOexdUmQ1xRcQUMc4fjcYAutRMjMsR0+gmBL/FH8TOb
4voDHl9ixCa+8QfbL423PEtnD3KXbe5vaRKAwH76qa9jSvpq473kuaD4tkwEtII1
vrk0XIsNYt4OgS1Cod+MPRoNgtxvKrWjw1Nkxvw3LOOBaOYBe93LDdw62FnnYhU=
=OXwL
-----END PGP SIGNATURE-----

--EgX4lXfMI6pcUTJEEBGC7UdH3PrS8fKj0--

