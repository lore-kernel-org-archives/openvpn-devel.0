References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
	<8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
	<20161213083314.GS78624@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <5c370709-7aa9-e60c-0f44-5930d941d7d6@...1435...>
Date: Tue, 13 Dec 2016 10:46:19 +0100
MIME-Version: 1.0
In-Reply-To: <20161213083314.GS78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wTBpKsBH0m59fRRk8r6EQjVhs7N21IUNA"
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
 --enable-plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--wTBpKsBH0m59fRRk8r6EQjVhs7N21IUNA
Content-Type: multipart/mixed; boundary="fxAKUPeW4cr8khR0XdM2MBmAiEBeVC05t";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5c370709-7aa9-e60c-0f44-5930d941d7d6@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Make --enable-async-push depend on
	--enable-plugins
References: <1481543265-21474-1-git-send-email-lstipakov@...277...>
	<8e68219b-d4d1-ae36-6c35-b8f44d8e1acc@...2080...>
	<20161213083314.GS78624@...1296...>
In-Reply-To: <20161213083314.GS78624@...1296...>

--fxAKUPeW4cr8khR0XdM2MBmAiEBeVC05t
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13-12-16 09:33, Gert Doering wrote:
> On Tue, Dec 13, 2016 at 01:15:03AM +0100, David Sommerseth wrote:
>> My point is that there's no real point of screaming about missing
>> --enable-plugins if you have added --enable-auth-push.=20=20
>=20
> Someone added --enable-async-push to the configure command line, and they
> expect this to have a different effect than "not putting it there".

Exactly this.  This combination makes no sense, so it's likely a
mistake.  The best thing to do is to make that clear to the user.
(Especially in a configure script, which is somewhat advanced usage.
Assuming we know what the user wants is probably a mistake.)

-Steffan



--fxAKUPeW4cr8khR0XdM2MBmAiEBeVC05t--

--wTBpKsBH0m59fRRk8r6EQjVhs7N21IUNA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYT8NvAAoJEEEwndWOY1w5DtQH/2cY8sbVQHoOtJh+w1CTUpnZ
SpHh8ootPffY+ff/XPrgEDvmadlmbBeslaF1YCbF0Q9p7YUYgFN7XngwYD6sBuUU
c+bRGGxB0vsmufotgqhU3NB9os578CljhpvTdFe0hGnARVyLyhTTDHNhXsIUXo1W
zHnWYouMipeOYGBVoG+t6hLXoD187wuwqJ0aNOIbKh+tSQyOvKxbF+9pDIClM4lW
K0aVUE26C0c06aNKapxP7BlR0vevaTpF4K/+XysqGuCTWa5AvSzKnDXZg56b7/TI
BdZroPSaEPLsEP/gis5Rii66PVgfL31qLTYN3k5+pkuvLLgUbKiovBfHzdWRju8=
=/3tY
-----END PGP SIGNATURE-----

--wTBpKsBH0m59fRRk8r6EQjVhs7N21IUNA--

