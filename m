Date: Thu, 2 Feb 2017 13:53:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170202125342.GD940@...1296...>
References: <7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
	<6256c846-ca60-be4f-7122-60465374a322@...515...>
	<7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
	<b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
	<CAFHpkQHF7Wxw_WMBsnyzz5qgDr+ghYnoiWkDJp+rbfK2qr1mQA@...278...>
	<20170202120708.GW12187@...2182...>
	<f79c809b-1804-acda-c46b-17a97bf279f2@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yYeq/WQYi/kuVVbm"
Content-Disposition: inline
In-Reply-To: <f79c809b-1804-acda-c46b-17a97bf279f2@...515...>
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

--yYeq/WQYi/kuVVbm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 02, 2017 at 02:15:06PM +0200, Samuli Sepp=E4nen wrote:
> It was not a typo. I actually did not know about "git send-email" until=20
> now. I've used "git-send-email" which on Debian/Ubuntu resides in=20
> /usr/lib/git-core. Are these the same thing?

Sort of.  When you run "git foo", git will (if it's not a built-in) go
out and look for a program "git-foo" in your PATH, or it seems in its
libdir.

The "ACK and mail" script David and I use is called "git-ack-am", I
put it in $HOME/bin/git-ack-am, and then I can do "git ack-am ..."
on patches...

> Anyways, let's use "git send-email" in the PR template if that one is=20
> readily available on all Git installations.

That's the official one.  The other one is what you call under the hood,
and the fact that it's not in "bin/" tells stories :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yYeq/WQYi/kuVVbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYkyvWAAoJEB2Cnv7KVigSlpYL/1Fg9ortVQ5U9Elg/f5m704x
YQZhkemL7RLbvfp72zrCZ1sRprbUat/FjRP3Gb94opM3AMRUTOqDWqEQsQQ1XeGb
2MQYQbdpJJlytLjhxbxavk7z6zc0+pVwO9eB6Ee0mPVTH0KjWqQWzwrA5H5tsTN/
s2eFgRDwL1MYLRCPACUsNg3CQ0YEQRzxrb1AQ7zL3lEGMZJ5AApHTMRcOcgwDpqB
tvuF/S0sxr+MBo6ZK8Nks8nOxjsrLdsPaCsga1gfWt403L+bl+UG6j6T2x3jp3i+
ZqiVMbbhcpAJfDzbp0DIXdJTiTStofyMp+Ke9oFc58ZhOxqKO36AfXvgEihGMv6E
87VqAiV8WS1XKyZG061Ux6/Qbtz0mDbbXN9F/bGQaT6hEUN1lsxJRVKCTVxfKRuO
7Bxv1BVL18Vng/YMOGAfOnN6g9LLkg0RSE5Jm6xXg8BUFBV5/xM8NUMDooaMq6mU
X+F0mejklBrHJfntZTVshrJzhE5erHMenYdXklT0mQ==
=mrlm
-----END PGP SIGNATURE-----

--yYeq/WQYi/kuVVbm--

