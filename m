Message-ID: <54C64B78.1070602@...515...>
Date: Mon, 26 Jan 2015 16:13:12 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1422261503-1412-1-git-send-email-samuli@...515...>
	<1422277453.5382.25.camel@...1866...>
In-Reply-To: <1422277453.5382.25.camel@...1866...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="oMvVqN2k620guaM5iG3nldilAqfGTj4gk"
Subject: Re: [Openvpn-devel] [PATCH] Add more dash escaping to the man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net, Colin Watson <cjwatson@...334...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oMvVqN2k620guaM5iG3nldilAqfGTj4gk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> On Mon, 2015-01-26 at 10:38 +0200, samuli@...515... wrote:
>> From: Alberto Gonzalez Iniesta <agi@...64...>
>>
>> This patch continues the work started in commit 886593ac4ae ("The man pa=
ge needs
>> dash escaping in UTF-8 environments"). This patch is one of the patches =
included
>> in Debian's OpenVPN packages.
> Note that this isn't perfect either. The escaped \- is supposedly
> rendered as a minus sign... but you don't actually *want* a minus sign.
>
>  If you ever render the manual into HTML, that's exactly what you'll
> get: U+2212 MINUS SIGN. I've had users complaining to me because when
> they cut and paste from an HTML-rendered man page, their command lines
> don't work.
>
> What you really want is U+002D HYPHEN-MINUS=C2=B9. I think it could actua=
lly
> be considered a groff bug if you *do* get U+002D HYPHEN-MINUS in the
> UTF-8 terminal output =E2=80=94 it should be U+2212 MINUS SIGN there too,
> according to the definition.
>
> FWIW I *can* search for 'For --management-client' even before this
> patch, on Fedora 21. Changing to \- isn't required to fix the searching
> here. Is it still required on Debian?
>
Hi,

The original problem seemed to be that strings like "--win-sys" could
not be found from the man-page unless the dashes were escaped:

<https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D296133>

I tried to reproduce the problem on Ubuntu 14.04, Debian 6 and CentOS 6
and was unable to. Having or not having escaped dashes made absolutely
no difference. Note that I only tested "less" as the pager. In any case,
it looks like the problem got fixed outside of OpenVPN, which leaves us
with an inconsistent escaping style on the man-page.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



--oMvVqN2k620guaM5iG3nldilAqfGTj4gk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTGS3gACgkQwp2X7RmNIqOW3ACgx/BaiSA3Pf7w7zGaVMyvlezk
atYAn37uAShevFl/LfDqVRFYzKyyMp3i
=axyG
-----END PGP SIGNATURE-----

--oMvVqN2k620guaM5iG3nldilAqfGTj4gk--

