References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...> <56DA3817.5040602@...1147...>
	<56DA6DAA.4020501@...2070...>
From: ValdikSS <iam@...2070...>
Message-ID: <56DA7827.90806@...2070...>
Date: Sat, 5 Mar 2016 09:09:43 +0300
MIME-Version: 1.0
In-Reply-To: <56DA6DAA.4020501@...2070...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6B4nvKfO3iCIhElr4UBWQgAiGe1Kt2wLJ"
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
--6B4nvKfO3iCIhElr4UBWQgAiGe1Kt2wLJ
Content-Type: multipart/mixed; boundary="ktoV0uTqd1sU7a537eQaSVxBSegRJulQP"
From: ValdikSS <iam@...2070...>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
Message-ID: <56DA7827.90806@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...> <56DA3817.5040602@...1147...>
	<56DA6DAA.4020501@...2070...>
In-Reply-To: <56DA6DAA.4020501@...2070...>

--ktoV0uTqd1sU7a537eQaSVxBSegRJulQP
Content-Type: multipart/alternative;
	boundary="------------070005060306030208090005"

This is a multi-part message in MIME format.
--------------070005060306030208090005
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/05/2016 08:24 AM, ValdikSS wrote:
>
>
> On 03/05/2016 04:36 AM, Jan Just Keijser wrote:
>
> I've signed my new CA's private key (4096 bit) with old CA (1024 bit) and=
 it became intermediate to my old CA (what you call extending trust), but a=
lso issued
> self-signed new CA. I issue server certificates with new CA.
>
> Current users trust only old CA, so to make them connect to the servers w=
ith server certificates issued by new CA, we should either add cross-signed
> (intermediate) certificate on the client side, or push it from server. Th=
e latest I'm trying to achieve.
>
> New clients will get configuration files with new CA inside, and they wou=
ld be able to successfully connect, since intermediate certificate, pushed =
from
> server, would be just ignored. Old clients would eventually update config=
uration files too. After some time, we'll move all users to new CA and remo=
ve
> intermediate certificate from server.
>
>
Just to clarify, both self-signed new CA and cross-signed new CA share the =
same private key.

--------------070005060306030208090005
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    On 03/05/2016 08:24 AM, ValdikSS wrote:<br>
    <blockquote cite=3D"mid:56DA6DAA.4020501@...2070..." type=3D"cite">
      <meta content=3D"text/html; charset=3Dwindows-1252"
        http-equiv=3D"Content-Type">
      <br>
      <br>
      <div class=3D"moz-cite-prefix">On 03/05/2016 04:36 AM, Jan Just
        Keijser wrote:<br>
      </div>
      <br>
      I've signed my new CA's private key (4096 bit) with old CA (1024
      bit) and it became intermediate to my old CA (what you call
      extending trust), but also issued self-signed new CA. I issue
      server certificates with new CA.<br>
      <br>
      Current users trust only old CA, so to make them connect to the
      servers with server certificates issued by new CA, we should
      either add cross-signed (intermediate) certificate on the client
      side, or push it from server. The latest I'm trying to achieve.<br>
      <br>
      New clients will get configuration files with new CA inside, and
      they would be able to successfully connect, since intermediate
      certificate, pushed from server, would be just ignored. Old
      clients would eventually update configuration files too. After
      some time, we'll move all users to new CA and remove intermediate
      certificate from server.<br>
      <br>
      <br>
    </blockquote>
    Just to clarify, both self-signed new CA and cross-signed new CA
    share the same private key.<br>
  </body>
</html>

--------------070005060306030208090005--

--ktoV0uTqd1sU7a537eQaSVxBSegRJulQP--

--6B4nvKfO3iCIhElr4UBWQgAiGe1Kt2wLJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2ngnAAoJEFzXIC7viPdyNoEP/05V3Gu0cDMDROOlsMZJXPlr
AzQqKb9C6cRUw1wyOJGFFWgxKg3YfZyHmFvPEeTw0aGDThlXXCiR940bM3Ix2SPC
hVtdzJM9ChohqfgqIJSekZ70JYABChvXXFeHOppK+mL2WFVSOf0fb/fJVF9EX5w9
pUESaPZt1W114P2rslp632WXZ1Z2vnlrFfj/7sWGPhEYoV4KRwPfGdSlu8Z0PIBy
DA9PLQVEAIrlpb3z95QvwARgL6wTf4b/zOu8Wf2HQ2tB5K4Gd2pL6BUrix+5clL3
GXhmo7146HnwNmSwHv7PzD1pWwgejMgRvxQqaSc+35cL9tvwle7KxAU3+/y7mX2g
M60oJ5ll3HApANZCVVhAxnKqP/V5eov3zpPrARnSJvUGWghFdFGwBkFO81OwUeXK
QBZ1HKISN2FkO9ytxsOSX20ZO8vT+pX9BeAJsNIWMJTqK77rE4OQuXKliKJn0Z31
ImPUHVRx7xN8sWgrhHAF8qBtWxufthxU/GqOKnLZ+T2mr3N23BTkLU2AFu423z32
LAHvnbbUzAUaQVhLH6Hm3n+Mm/hddgskE1TodbXEkypFqMjKLQS5chyGlWBXIls/
1N75iVACu4qFDLA/3OWh6Qrf5MQMWh8eKc05R+WytBCma+Wcu1CdqzM5+M/eTXWx
tTAKxA36FISextDnQIMi
=oBB7
-----END PGP SIGNATURE-----

--6B4nvKfO3iCIhElr4UBWQgAiGe1Kt2wLJ--

