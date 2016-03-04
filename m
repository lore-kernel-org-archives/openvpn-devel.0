References: <56D8A6C4.5080803@...2070...> <56D989C7.5040403@...1227...>
	<56D98B2E.20903@...2070...> <56D98CA8.8060307@...1227...>
	<56D9EB59.8010507@...1147...>
From: ValdikSS <iam@...2070...>
Message-ID: <56D9ED9D.4010302@...2070...>
Date: Fri, 4 Mar 2016 23:18:37 +0300
MIME-Version: 1.0
In-Reply-To: <56D9EB59.8010507@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WMolKdvsRTnxTk5TBuEuoP2UVSPGdAXLv"
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WMolKdvsRTnxTk5TBuEuoP2UVSPGdAXLv
Content-Type: multipart/mixed; boundary="XjjmdnaI6Nn4AsN86IAK5U96EDBiGB2ah"
From: ValdikSS <iam@...2070...>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
Message-ID: <56D9ED9D.4010302@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...> <56D989C7.5040403@...1227...>
	<56D98B2E.20903@...2070...> <56D98CA8.8060307@...1227...>
	<56D9EB59.8010507@...1147...>
In-Reply-To: <56D9EB59.8010507@...1147...>

--XjjmdnaI6Nn4AsN86IAK5U96EDBiGB2ah
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/04/2016 11:08 PM, Jan Just Keijser wrote:
> Hi,
>
> On 04/03/16 14:24, Arne Schwabe wrote:
> the more I think about it, the more I think that what you are trying to a=
chieve ought not to work:
>
> your current situation is this:
> - clients are equipped with a 1024bit CA cert; the server certificate (ch=
ain) must be signed using this end-entity CA cert for the client to trust t=
he server
> - the server supplies this 1024bit CA cert, as well as a cross-signed 409=
6bit CA cert and a server cert.
> - The client will never "accept" the 4K CA cert as the new end-entity, as=
 that is not configured in the config file.

This is correct, except that server doesn't send CA.

>
> *but*
> anything signed using a 1K cert should be considered insecure, as it's fe=
asible nowadays to brute-force generate a key that will match that certific=
ate. That
> means that an attacker can grab your 1K CA cert, generate a new CA key fo=
r it, then generate new server cert (or even a 4K cross-signed CA cert) and=
 lure an
> unsuspecting client to the server - your shiny new cross-signed CA cert w=
ill not prevent this.

This is also correct.

>
> The only way to prevent this from happening is by getting the clients to =
stop trusting/using the 1K CA cert - thus, you must alter the client-side
> configuration for this, painstaking as it is...

This is only to easily move to a new CA. New clients will get configuration=
 files with new 4096 bit CA, old clients would update their configuration f=
iles in 2
months. I'd like both old and new clients to be able to connect to the serv=
er without any hassle. Then, in 2 months, when all clients use 4096 bit CA,=
 I'll
remove old chain from server.

>
>
> JJK
>



--XjjmdnaI6Nn4AsN86IAK5U96EDBiGB2ah--

--WMolKdvsRTnxTk5TBuEuoP2UVSPGdAXLv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2e2fAAoJEFzXIC7viPdyZOMQAMAoaaVAHTKSkhPkDckQgvUu
NVseYE1TJwgL4d6Uq5A4zauOVdRRJKbuopWIuXhNY39tQhSmu76h4g11WFfzSJ2f
oH8cUyCjEN6M7Ppcw1vjKN+8O5Yu+MS2IkzdYDoNIqXTtDoBA/mIbBsqfQq0lZk4
eTP7axORWRMQQXg1HvxlZ2HBdUs31q73pdy5s9AxJ4w6PmB06vpjOre7BDK2ySKJ
2YK0nAKNkiW+UR1TqphzykQ0wHxQ75Z0YgWSL0sO+g3j+N0Cd5E4trR2o6x+rXWb
ZMUEpqdlrsHhDn3bShp+j+q+PUv1p5VrTfTbcIPmP+TY8MzzRrg4SkuzuTj7zOIG
LQ0pkV4GqwrrRNZH/DPpACSljibyOKTLGs6JoALEUtlBqoVxNA265+c34qs9wC/m
ExkyjpVtzef6YSdQ+QI/nFOKEXuyMP82WraAOQaG8hb7D66h+0TWq36xAql7S1zg
M7/hhr+xn7/6KyXS4dyhhKmUXx4PEzGr/6suKgwpsltnRSeD5TBf3FHbD+Sblz0+
jd4PU3FaVE9pH6ff7HzI6IzHBfVysWXaV7/8F5ZHzYfARyzCvPwRgI26xT32CPLE
pOas4tW9k72IdvNIWj7cHGKHHmNvOSLNM4AIbW5mPTdyCTEJ/eR7cDAoArjGT0vN
9HZ8mnBzwnYJQadhTlBM
=306J
-----END PGP SIGNATURE-----

--WMolKdvsRTnxTk5TBuEuoP2UVSPGdAXLv--

