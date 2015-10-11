References: <1444571266-6598-1-git-send-email-arne@...1227...>
	<CAA1AbxJ+GvoaeAz4qhyzAN=MNr4wfm2cN_0TRweGzer8cnhCjw@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <561A8F8C.7000306@...2070...>
Date: Sun, 11 Oct 2015 19:34:20 +0300
MIME-Version: 1.0
In-Reply-To: <CAA1AbxJ+GvoaeAz4qhyzAN=MNr4wfm2cN_0TRweGzer8cnhCjw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1rvuu1u9eEH24wibMvtQ0SFX4f5jplWJ5"
Subject: Re: [Openvpn-devel] [PATCH] Do not set the buffer size by default
 but rely on the operation system default.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1rvuu1u9eEH24wibMvtQ0SFX4f5jplWJ5
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 11.10.2015 17:25, Steffan Karger wrote:
> On Sun, Oct 11, 2015 at 3:47 PM, Arne Schwabe <arne@...1227...> wrote:
> Nice, changelog entries!  But, 65k should be 64k.
>
> Am I right that it was tested that this indeed results in using
> operating system defaults?

Yes.

>
> -Steffan
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--1rvuu1u9eEH24wibMvtQ0SFX4f5jplWJ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWGo+OAAoJEFzXIC7viPdyF5cP/AhRFztoc0FKBgwRXN/nxwXW
Qsw4UTdYI77nX3J/CkpAqeYFQznBaW4AVxbtZwSi3mH8QieXTWM/wfyxVFT3p225
8ggB4XrFVXNoFWOTd9b1oYSyYct/GK6x7Zt0Y1c4DT4ep0S4F3v9vS5qpXSYBt4Q
U8lT3Ev+A6wbF8rFpRycll7zgFZcLZDiExHRAk2zHrz3e6MGZTQhcDmxOhkXHYyR
Ujpc9IMtNdYR7rB1jUhi6sSY1O+hI92JHqMvKrGEMzwZGz+LJRCupkGx601mc8Y3
blYpe2ouAd605qXPAqfw4nZGqfpVqONOER3Im/kSZvdj5JMD7kTRJNRknW2ekThH
pmpSSc1Gs9a/vCRlQA5dDC6iqGtg+aDzkhTWduEtdKIyboJYpsFCg9AK3Sfuix1Y
Fk9/GwAfMmV4fhpAhKDkiDBZrCr9aZR3trCszas0X4rg+5ssJgSZrNbD+5sZ4eFM
tJuFg0Vl1oolpp22VpQJ7eE1iyybUlANln6vJGtdcwSecMQjTcJ4QQT3HV6WPAX6
JpgttobaeM0/MlzWgsY7b4I+Ljh7NR9FT/aB6VTOjIfHjUnkRgcgpSGDUI4GjKcR
2tRgXIDyrQBHnOCrub3Ru+NEOvp6deMY3utsfRgiH+rVkRLL4HBNGlUKxt+sPLVN
SYc0d6b7E9QMEJmtZDbj
=EZYf
-----END PGP SIGNATURE-----

--1rvuu1u9eEH24wibMvtQ0SFX4f5jplWJ5--

