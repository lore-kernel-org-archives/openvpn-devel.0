References: <562DF8BA.1090406@...515...>
	<071C5EF6-E94A-422D-9456-0E6015C10F8D@...277...>
	<CAKuzo_if_4L81xNZKDPJhek_FicxM-c2ZvWkYcZq1tMjGpXXvw@...278...>
	<E8664D21-2E83-4E50-AB23-B0B36533F7E0@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5630AE4D.8040401@...2080...>
Date: Wed, 28 Oct 2015 12:15:25 +0100
MIME-Version: 1.0
In-Reply-To: <E8664D21-2E83-4E50-AB23-B0B36533F7E0@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OjOQgCffCoXfNx14L2p04xfDx0N1mLDcI"
Subject: Re: [Openvpn-devel] Topics for today's (Monday,
 26th Oct 2015) community meeting
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gmail <volleynbike@...277...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OjOQgCffCoXfNx14L2p04xfDx0N1mLDcI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 27/10/15 07:07, Gmail wrote:
> On Oct 26, 2015, at 8:41 AM, Selva Nair <selva.nair@...277...
> <mailto:selva.nair@...277...>> wrote:
>=20
>>
>> On Mon, Oct 26, 2015 at 11:17 AM, Gmail <volleynbike@...277...
>> <mailto:volleynbike@...277...>> wrote:
>>
>>     Regarding the instability of connection in the windows version:  I
>>     overcame this long ago (and works well to this date) by building a
>>     tiny script that periodically pings the the ovpn gateway (server).
>>     If no ping reply then restart the service. Very simple. Perhaps
>>     this could be built into the code as an option?
>>
>>
>> Oh, please, no... If the TAP driver has stability woes it needs to be
>> fixed. True loss of network connectivity is already handled by
>> internal pings and ping-restarts. It would be a grave mistake to add
>> such options to hide any stability issues.=20
>>
>> Cheers,
>>
>> Selva
>>
> Your concern is understood and acknowledged. Perhaps the ping-restart
> idea is useful in the interim until the cause is located?

This will work in regards to ensure that openvpn client and server will
have a working connection.  Configuring OpenVPN with
--ping/--ping-restart (or the --keepalive "macro", which does it even
better), is generally recommended and is the best way to provide a more
"stable" VPN experience.

If anything happens with the TAP driver, OpenVPN will not re-initialize
the TAP adapter - thus OpenVPN should stop running.  When the TAP driver
have an issue, it is just like your Ethernet or WIFI driver have an
issue.  If the TAP adapter "disappears", it's just like unplugging your
network adapter in your computer, in these situations OpenVPN should
really stop.

So I do agree with Selva, if there are stability issues with the TAP
driver, those issues should be fixed in the driver.  If there are things
outside of OpenVPN or the TAP driver which does funky stuff, that should
as far as possible be fixed there.


--=20
kind regards,

David Sommerseth


--OjOQgCffCoXfNx14L2p04xfDx0N1mLDcI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYwrlAACgkQDC186MBRfrqz2QCfU6LpwygfaYNhjWGptl8pfw0I
iZYAnjBiSC+mIXowWNZRr4kyyfY2vEkl
=pS75
-----END PGP SIGNATURE-----

--OjOQgCffCoXfNx14L2p04xfDx0N1mLDcI--

