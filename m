Date: Fri, 24 Jul 2015 13:34:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150724113420.GJ382@...1296...>
References: <70BE12F3EEB84953AEC765E475A7CA70@...1853...>
	<20150724073910.GH382@...1296...>
	<26832672787A4D0DAE606EEEE8E19ABF@...1853...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kxXhfUbap88GlQ0O"
Content-Disposition: inline
In-Reply-To: <26832672787A4D0DAE606EEEE8E19ABF@...1853...>
Subject: Re: [Openvpn-devel] autoreconf: Unescaped left brace in regex is
	deprecated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277...
Cc: openvpn-devel@lists.sourceforge.net

--kxXhfUbap88GlQ0O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 24, 2015 at 11:31:41AM +0100, debbie10t@...277... wrote:
> Unescaped left brace in regex is deprecated, passed through in regex; mar=
ked
> by <-- HERE in m/\${ <-- HERE ([^ \t=3D:+{}]+)}/ at /usr/bin/automake line
> 3936.
[..]
> I have never seen this error before and wanted to ensure the dev
> team were aware that something has been deprecated and may
> impact openvpn build in future.

This is because the code in /usr/bin/automake is old-style perl.=20=20

It has nothing to do whatsoever with OpenVPN.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kxXhfUbap88GlQ0O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVbIivKkuBuNlUUl1AQIeawQAxoV9mbytoiH1lw5mBLzoq1ULrKFAWbsW
5Css4pZSg2FP/by85QIPhkh0DIWmZqC263AnsEBza2CaH0rl0PFozhyYPK8nmzej
8erGjuDBcqVTMw/rF/d0diRX+RyvB/VVucz3X+6AXgTtLogBJiZYQzambEnQIObm
lE7QI6XEtgk=
=0hlr
-----END PGP SIGNATURE-----

--kxXhfUbap88GlQ0O--

