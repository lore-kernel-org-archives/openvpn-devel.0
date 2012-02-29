Date: Wed, 29 Feb 2012 16:46:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120229154604.GA7024@...1296...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RU5vHP6eAM91MAfE"
Content-Disposition: inline
In-Reply-To: <CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: Carsten =?iso-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--RU5vHP6eAM91MAfE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 29, 2012 at 04:28:31PM +0100, Fabian Knittel wrote:
> To ensure this in classic Linux this would mean that the OpenVPN
> process needs to run as a _different_ user than the GUI user or else
> the GUI user could freely manipulate the program using, e.g. ptrace. I
> know that similar manipulations are possible in Windows, so can you
> protect the service-started OpenVPN-executable from such
> manipulations?=20

The model we follow is "openvpn.exe has the same permissions that you
already have, so there is no benefit in manipulating anything".

For those bits that need additional privileges, there's the named pipe
to the openvpn service - with some very well-defined messages to
add/delete routes, setup interfaces, and such.

Part of the assumption here is "the user controls the openvpn config",
and as such, he can make openvpn.exe run arbitrary scripts anyway - and
to stop this from being a problem, just run openvpn.exe with your uid.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RU5vHP6eAM91MAfE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT05IPKkuBuNlUUl1AQJwCwP/UaCGA7y6puPiA3jxBiDOX/MizWnU60xM
ziBWVIbq11fX7lVQWpJwfUNKsd18wTY7JKmEtYkETV44Um78/Ln7WSZot5iL3hzc
QC3FSqu3wjtU2P235zVLdd9Bvh/L+dhcwBD90vIFbDNo9UJLElGqkBsAEd7wK/qZ
u7mwxFItP7o=
=OakU
-----END PGP SIGNATURE-----

--RU5vHP6eAM91MAfE--

