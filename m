Date: Mon, 20 Apr 2020 08:30:07 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20200420083007.3ed97ad0@...1799...>
In-Reply-To: <87a61aa5-bba1-637d-2169-4f9aa74d5044@...515...>
References: <0a607581-4179-a97b-1e8b-e19dd6bd85bd@...515...>
 <CAEsd45Q+GvZf3du9FYCaLiPeupN88UTv3BjE1dzPKsJO2hzFjQ@...278...>
 <20200417213506.GI1431@...1296...>
 <CAEsd45Tym2Rs=v0RyQY57wWvNd0N=BXVLgRus5hoDYZRY+W4Fw@...278...>
 <67d10ca6fb99ba7d75ff0b65f84cb76f.squirrel@...2260...>
 <20200419100325.GZ1431@...1296...>
 <87a61aa5-bba1-637d-2169-4f9aa74d5044@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MDGlhnL/oblNHDhaFCL2lc7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Subject: Re: [Openvpn-devel] OpenVPN 2.4.9 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?UTF-8?B?U2VwcMOkbmVu?= <samuli@...515...>
Cc: Gert Doering <gert@...1296...>, Simon Matter <simon.matter@...2249...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Sig_/MDGlhnL/oblNHDhaFCL2lc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Samuli Sepp=C3=A4nen <samuli@...515...> on Mon, 2020/04/20 09:13:
> On a related note: I think we should consider stopping the distribution
> of the security list's public key from our webservers and just instruct
> people to fetch the key from the keyservers and refresh it if they have
> trouble.

Key server operation became instable lately. I would suggest to set up a web
key directory (WKD):
https://wiki.gnupg.org/WKD

Downloading the key from your WKD would require this command from a
recent gpg:

gpg --locate-keys security@...515...
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/MDGlhnL/oblNHDhaFCL2lc7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAl6dQW8ACgkQiUUh18yA
9HYyGAf/RGlPPMr26rys1mwbrZtnfQzbuHtHFsH5cysqq4fmecnpFGx1G0AVxSTF
NWq+KM38L9mAd2ET6ntxOiD09lQzwZSeWJGg8EmoahDqqIbb/6ebIc2eCeGZuTnt
lAlyJTW3/F1wtGv6/ZDT1yq8KDH/Yva1adhsHIsPnxwQN+gPbzRUPzTzwI22aojO
pjSssTJEeyoODrpJe4BrGC3nK55bzPs/Ln4tInBA0Gd6EI82PrymFP/PnQS7jR6h
Zmsez9ImHnf/+NWQtdMfLAbrCdC1FL/LLZzi6IjoM9Hoxx/Sl9rDDZqYyojajE5q
7njHUB4vmOf32YMnBH065Hj0toASyg==
=Vdce
-----END PGP SIGNATURE-----

--Sig_/MDGlhnL/oblNHDhaFCL2lc7--

