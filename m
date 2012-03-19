Message-ID: <4F66F5ED.30006@...1114...>
Date: Mon, 19 Mar 2012 10:01:33 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
	<20120316152145.GF1359@...1296...>
	<4F66EE39.5050405@...515...>
In-Reply-To: <4F66EE39.5050405@...515...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/03/12 09:28, Samuli Sepp=E4nen wrote:
>=20
>> I think the default should be "what most people are using".
>=20
>> - enable crypto and ssl - enable lzo
>=20
> Everybody made good remarks. That said, let's enable crypto, ssl and
> lzo by default and get over with this, shall we? Otherwise this
> discussion will never end :).

Agreed.  In the end, this seems to make most sense to me too.

I just compared the what we had before and what we will get with the new
build system.  I see these changes basically, regarding to default
feature enabling:

1)    --disable-lzo     >>    --enable-lzo
2)    --disable-pkcs11  >>    --enable-pkcs11
3)    --disable-selinux >>    --enable-selinux

Regarding to 1), I agree making this one default.  I also agree that 3)
should be a Linux distro responsibility, as that's strictly distro
related.  Which is also why we have --enable-systemd disabled by default
too, as that's also strictly Linux oriented.

When it comes to 2), I'm torn again.  This feature requires external
libraries, and to have a real use case also specific hardware tokens
(Smart Cards + readers or USB tokens which resembles the same features).

AFAIK, the PKCS#11 libraries are default on all Enterprise Linux
installations, and many other Linux distributions.  I don't know how it
is with *BSD and Solaris, but would expect this to be an expected feature
in the Windows world.

I'm not going to fight a battle to change the default for PKCS#11 either
way.  But just wanted to raise attention to this one as well.



On a related note: --enable-iproute2

Should we also expect this to be available on all *nix platforms?
iproute2 has been available on most platforms I know of for a very long
time, and is superior net-tools in very many ways.



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9m9esACgkQDC186MBRfrpkYACgmsg0QcAH1QXtqTQE8IihQGfF
/rMAoJuiM7i6V9ugXBJpyBGd6SZ/ZA3F
=3DkLgH
-----END PGP SIGNATURE-----

