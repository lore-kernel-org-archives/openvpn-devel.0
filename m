Date: Tue, 13 Dec 2022 14:19:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5h71+BkglSp5ZI0@...1296...>
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
 <b6c21ae8-536a-2c6f-07e6-d998102c646e@...2181...>
 <Y5gDkXBhDyqB+YZf@...1296...>
 <76119efc-1dc4-ddfb-dce7-8cf90d61cc1c@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="viFwcBJaPR8KxIc/"
Content-Disposition: inline
In-Reply-To: <76119efc-1dc4-ddfb-dce7-8cf90d61cc1c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Read DCO traffic stats from the
 kernel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--viFwcBJaPR8KxIc/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 13, 2022 at 01:12:30PM +0100, Antonio Quartulli wrote:
> Ideally a GET_PEER command is pretty standard and can also be used for=20
> any kind of state inspection (i.e. even for 'debugging', although it's=20
> not the primary usage)
[..]
> Like I said above, being this an API imho it is important to implement=20
> it in a way that can serve a reasonably broad set of use cases. (OpenVPN=
=20
> is the only user now, but may not be the case later)

I think there is nothing that stops us from doing GET_PEER on Linux,=20
if that's already there and a proper "people agree that this is the way"
API, and using the API we have for FreeBSD for the time being.

The Linux counter support patch might want rename the OS-independent
functions accordingly then :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--viFwcBJaPR8KxIc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmHvXAAoJEB2Cnv7KVigSGeMMAKpoFX3yYCU5RuUcaBHkOg9S
SLvZDQWI2SnSVUpcUOtTLvGcJQCoTY8ijAz44ZoI+qIJnip7Jovs72VGxPRjywGd
fRDJKpSEBtaDul+aoM4AG5CH/p/ocWi/QLn5m604Q3B3Wwst/eCa49m5S7SXcBTg
JHy6Zu0bwMNCy4I8OzR3VRX5YBlBjD9Fxp5jWk5HzxOF2YXZQ5WgtoOR8FO0BMOv
J/iE1opX46LRpjWLbFsorpuaLHhOO5eA/y9psXwIvflWaVYD2p4UGb7R5ru3w2T9
xJhm7AptYI1dHgaSqtyUalFVij4Pa36LPXR6I4+1g3uRoH7DDfSfjFVPv3ZJDhLH
+BRevgGjiTd+BGnMagXRHH18mOkDr15Fh6To/wJJxiO7KLfK3/MajkBVrFR6aNOo
Drv05jGdqoeqkimMsrgxstaPD4nsAjsrzAiLdP6IBkwKV4flBVWtblrSPP1zNb6E
YK49ehwusge/8R2V2RywTHsInchmphLLAhoQi8sm3g==
=WXCl
-----END PGP SIGNATURE-----

--viFwcBJaPR8KxIc/--

