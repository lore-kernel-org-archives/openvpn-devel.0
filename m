Date: Tue, 19 Jul 2011 13:42:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110719114246.GA8496@...1296...>
References: <4E1F227F.7060308@...515...> <4E1F672E.1010305@...515...>
	<1935589941.20110715004918@...449...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lec7CLJ9cqIyQUfJ"
Content-Disposition: inline
In-Reply-To: <1935589941.20110715004918@...449...>
Subject: Re: [Openvpn-devel] First Windows installer snapshot now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Carsten =?iso-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--lec7CLJ9cqIyQUfJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 15, 2011 at 12:49:18AM +0200, Carsten Kr=FCger wrote:
> Does establishing a VPN connection now works without administrator
> privileges (or to be more precise Network Configuration Operators
> membership)?

Not yet.  Currently, the openvpn.exe binary is started by the GUI process,
and runs with the privileges of the user that started the GUI.

There are plans to change that architecture to enable unprivileged GUI,
but you've seen Heiko's response "not done yet"...  (I do hope that we
can get that into 2.3 :-) ).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lec7CLJ9cqIyQUfJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTiVttqkuBuNlUUl1AQKyYQQAuHp0qDoYlJH5RotLX2EIldRP7K4H7UA0
ogN412TKCVODNJxlmL7Rb9412cxsxnafnZPvfP3YNRoZ4p0hFBXULT8XRQNr/itp
wgcp8D4CsDhKEkgBhoeGFa4syQJR/6SHSci5QT5Iza3ROG3HcZQdByPAfSE5U6a0
J9xgsSnBvKA=
=X1UC
-----END PGP SIGNATURE-----

--lec7CLJ9cqIyQUfJ--

