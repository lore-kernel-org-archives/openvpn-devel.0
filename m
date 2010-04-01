Message-ID: <4BB484F5.9030804@...1338...>
Date: Thu, 01 Apr 2010 13:35:17 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>	<20100331231158.2782.qmail@...1287...>	<4BB45497.8040707@...1338...>	<4BB46059.9080208@...1147...>
	<20100401091414.24106.qmail@...1287...> <4BB47EFF.5020005@...1147...>
In-Reply-To: <4BB47EFF.5020005@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3FD46DEF3CE113D6F2437C1"
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and
 remove	VLAN	identifiers on outgoing and incoming frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3FD46DEF3CE113D6F2437C1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Jan Just Keijser schrieb:
> Peter Stuge wrote:
>> Look at the spec, Table 9-2 on page 86. (100 in PDF)
>>
>> VID Use
>>   0 "no VLAN identifier is present in the frame"
>>   1 "The default PVID value used for classifying frames on ingress ..
>>      The PVID value of a Port can be changed by management."
>> FFF "Reserved for implementation use."
>
> be careful here (from table 9.2; I actually have an older copy of the=20
> 802.1Q spec):
>=20
> The null VLAN ID. Indicates that the tag header contains only priority
> information; no VLAN identifier is present in the frame. This VID value=20
> shall not
> be configured as a PVID or a member of a VID Set, or configured in any=20
> Filtering
> Database entry, or used in any Management operation.
>=20
> so it *does* have priority info in it and it is *not* the same as no=20
> VLAN identifier ...

I'm not sure whether you're actually disagreeing with each other... :)

"No VLAN identifier" does not mean "there is no 802.1Q header".  It just
means, that it doesn't represent a VLAN.  A frame without a VLAN
identifier (i.e. where VID =3D=3D 0) represents a priority packet.

Cheers
Fabian


--------------enigD3FD46DEF3CE113D6F2437C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAku0hPwACgkQARH1aMTipzPmaACbBOjVZoNnSHEEBGdA5XAPJqNr
6PIAoNY5SzcT46hc0vQVHh4SrDptl6s1
=Khwb
-----END PGP SIGNATURE-----

--------------enigD3FD46DEF3CE113D6F2437C1--

