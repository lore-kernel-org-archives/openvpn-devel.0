Date: Fri, 26 Mar 2021 12:14:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210326111448.GW976@...1296...>
References: <1538820128-27086-1-git-send-email-lstipakov@...277...>
 <1540904039-2129-1-git-send-email-lstipakov@...277...>
 <20210326071222.GR976@...1296...>
 <325f28a6-127a-f10a-dd94-5c76cc6c4f69@...2181...>
 <0fada0d5-19f6-4fbc-fc46-cb5bb3fbda54@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="buabu8+Kjf/sMnM/"
Content-Disposition: inline
In-Reply-To: <0fada0d5-19f6-4fbc-fc46-cb5bb3fbda54@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Improve "recursive routing" warning
 message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

--buabu8+Kjf/sMnM/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 26, 2021 at 12:11:10PM +0100, Arne Schwabe wrote:
> On Android where VPN setup is a bit different from normal setup.
> Different enoguh that the recursive routing message is easily triggered
> and the client always sets the allow-recursive-roouting option. I cannot
> remember the exact details anymore.

Yeah, on Android the whole code could probably go into an=20

#ifndef TARGET_ANDROID
#endif

block...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--buabu8+Kjf/sMnM/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgXcInAAoJEB2Cnv7KVigSSdML/2TG5Xbu/FhFYIxYXk+gPaDa
psw4VQYe9bSoZd3Kv5KgaF/wYZ5gz41cy7+VpdKEdk2sMH3t3XLI3Q6dRFQSJ6fL
5MmcL9M3hzNHlMQ09D6sccFw7aHC1st+Q+brr/udw9MzxPBvCIhmubUCsfsfHLq3
eiWt1X/4LcX/yX4pMWs9fHT+o8+XTtQuWMRS/h/QtdzGCYAP+6xEcXh0OVFerJt1
zWXBx+BEQ3oqNV4xXGhENU5wvK9f6vq9PSEvmzgR1/BqGD/NuWV9+qW1RNYGxPbn
4cvqMrmuzw3H9f0q6BalmjavE7H9TznM96veplIUn+dmkoKqPx9iVcAh27aJxSHQ
kDbLEu9PFqHuvxE82eMIHPOPfouyD0rimrkF6vo2Ly1a5FIMTu7VG3K9Bxu2TkRZ
JCGPdoP1AhkRj4prEHJ0isUn6lynGewJSdLc03XEf5/umT/3vbl6SoyZ6qJ32dqs
4pDHW61nbuKnAS7T74VXoCx1c8XaT1QSwR1bcaws7g==
=ag5L
-----END PGP SIGNATURE-----

--buabu8+Kjf/sMnM/--

