References: <56D8A6C4.5080803@...2070...> <56D989C7.5040403@...1227...>
From: ValdikSS <iam@...2070...>
Message-ID: <56D98B2E.20903@...2070...>
Date: Fri, 4 Mar 2016 16:18:38 +0300
MIME-Version: 1.0
In-Reply-To: <56D989C7.5040403@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QbFsp2jAVgEq85KgXiMC1nLRaoS1AeSXc"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbFsp2jAVgEq85KgXiMC1nLRaoS1AeSXc
Content-Type: multipart/mixed; boundary="SqltodpcPwmjm7Pci2aOuQX5hL8m205wM"
From: ValdikSS <iam@...2070...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <56D98B2E.20903@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...> <56D989C7.5040403@...1227...>
In-Reply-To: <56D989C7.5040403@...1227...>

--SqltodpcPwmjm7Pci2aOuQX5hL8m205wM
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/04/2016 04:12 PM, Arne Schwabe wrote:
>
> Am 03.03.16 um 22:04 schrieb ValdikSS:
> Shouldn't sending the new CA chain only be enough? Since it is
> (cross)signed by the old CA, the client will accept it. For the old
> clients the new CA will look like an intermediate certificate.

Please clarify what do you mean. I'm trying to send new CA (signed by old C=
A) and a server certificate.

>
> Arne



--SqltodpcPwmjm7Pci2aOuQX5hL8m205wM--

--QbFsp2jAVgEq85KgXiMC1nLRaoS1AeSXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2YsvAAoJEFzXIC7viPdyMOsP/RniHWYZTqZIR7iWps+Wd8n7
SE5N6GGlNzURuBmNASU2WWwWl0jSdgt7TuAb2DIgnswwYwNyUF804QIoHXrIvaAy
n93mBnTK93zBkhE+zzQ9+LSjLatz6rX9OhlsUzlw0KxsuufDLbG/yKs3fJQ6WZRY
jh+xEYOJ4MH3wG821YfbVQnwY84OlVrA1pBzb472HS5LGP2otuTKxOQCnn8wCDfU
uwJw7SQf8DZVtsV/6mhMa//Fz8NlRHUVegN50q4BCSuvG7IEqmrTgHXmLtDtu/++
X0ia5ao9SwucuSwbpavyElXHqltoeeTm5GXix+f+92WUIE51LiKwFHad5mjRuZal
EcKzhIHjZSVE5xSRoaIqLR9kRQC7JaJj7E+LCdP6gawskwz5fxJmN19a1KaRnut/
2ZW0q9QvqOLUqt8nM1JHBTvEQ+kuiAcXHOZ8Lmwoy+qmbHywXSMkotqnAxObIVeh
58DajEojmnv1FMQxSfi0+FTlgRqoIuNGU1MhIL1rhmMFK5ysjZ/4tIn4WPPAStnH
E4GcF2HIjeqPg7ZBsw8lmh/MQS81YXE26w1Ooc7lo21MCjubXlbOKq7L8W11yu/I
907MFop76G6pV5584YRkvniOoKzYXI9hJk2nEjvGkkybigCglrpGk+lUqCxnd8dU
Y48QKOdNloJp2OhAbzou
=xYNG
-----END PGP SIGNATURE-----

--QbFsp2jAVgEq85KgXiMC1nLRaoS1AeSXc--

