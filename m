Date: Mon, 15 Nov 2010 10:02:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20101115090236.GK258@...1296...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
	<1289808348-17463-3-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RacQGezy2Y99S6cT"
Content-Disposition: inline
In-Reply-To: <1289808348-17463-3-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Use stricter snprintf() formatting
	in socks_username_password_auth()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--RacQGezy2Y99S6cT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 15, 2010 at 09:05:43AM +0100, David Sommerseth wrote:
> -  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", strlen(creds.user=
name),
> -            creds.username, strlen(creds.password), creds.password);
> +  snprintf (to_send, sizeof (to_send), "\x01%c%s%c%s", (int) strlen(cred=
s.username) & 0xff,
> +            creds.username, (int) strlen(creds.password) & 0xff, creds.p=
assword);

I tend to NAK this.

I'm fine with the "(int)" thingie, but not with the "0xff" part - if
the creds.username/creds.password string is indeed longer than 255 bytes,
the whole message will be unparsable by the receiver, and silent truncation
of the length field is not helping to make the code more readable, nor
does it improve code quality.

So if you want to make sure that the length is <=3D 255, add a check + error
above the snprintf() block.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RacQGezy2Y99S6cT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTOD3LKkuBuNlUUl1AQLihAQAsTWQiM1z+VDme5atEmhul62uZ5OgiZPU
2aSPIPMSEPFXlAFJ3JxYfMyPZcZ7+nFOGKFJUzRrd1KbV4MqJg/2lSj2g8glFv7/
pVc8nldM/Nl37gwbk4wtH8AAf1ag/UVGzgLGcq19BGbdZ2tim1BwJr+BB2Sg/29e
EzsqMn4rreg=
=5D8H
-----END PGP SIGNATURE-----

--RacQGezy2Y99S6cT--

