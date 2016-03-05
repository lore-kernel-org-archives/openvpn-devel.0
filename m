References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...> <56DA3817.5040602@...1147...>
From: ValdikSS <iam@...2070...>
Message-ID: <56DA6DAA.4020501@...2070...>
Date: Sat, 5 Mar 2016 08:24:58 +0300
MIME-Version: 1.0
In-Reply-To: <56DA3817.5040602@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="20l2ASRmXcTws38KsvXkGS4mOeItaIcmq"
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
--20l2ASRmXcTws38KsvXkGS4mOeItaIcmq
Content-Type: multipart/mixed; boundary="5vaeinVB5lI4MF9wJhcBKMbaVn9vav3GL"
From: ValdikSS <iam@...2070...>
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net
Message-ID: <56DA6DAA.4020501@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...> <56DA3817.5040602@...1147...>
In-Reply-To: <56DA3817.5040602@...1147...>

--5vaeinVB5lI4MF9wJhcBKMbaVn9vav3GL
Content-Type: multipart/alternative;
	boundary="------------070106050509060409020201"

This is a multi-part message in MIME format.
--------------070106050509060409020201
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 03/05/2016 04:36 AM, Jan Just Keijser wrote:
> Hi,
>
> On 04/03/16 22:58, ValdikSS wrote:
> how did you generate the cross-signed CA certs? I've looked around but al=
l cross-signing either requires you to use the same private key (i.e. bit s=
ize) or
> that you extend the trust of one CA with that of another. The first is of=
 no help as the key size needs to be different. The second (extending trust=
) does not
> work as you'd need to install this cross-trust CA at the client side.  I =
found this interesting example on how to generate cross-signed certs here:
>   https://chromium.googlesource.com/chromium/src/net/+/master/data/ssl

I've signed my new CA's private key (4096 bit) with old CA (1024 bit) and i=
t became intermediate to my old CA (what you call extending trust), but als=
o issued
self-signed new CA. I issue server certificates with new CA.

Current users trust only old CA, so to make them connect to the servers wit=
h server certificates issued by new CA, we should either add cross-signed
(intermediate) certificate on the client side, or push it from server. The =
latest I'm trying to achieve.

New clients will get configuration files with new CA inside, and they would=
 be able to successfully connect, since intermediate certificate, pushed fr=
om server,
would be just ignored. Old clients would eventually update configuration fi=
les too. After some time, we'll move all users to new CA and remove interme=
diate
certificate from server.

>
>
> JJK
>
>


--------------070106050509060409020201
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 03/05/2016 04:36 AM, Jan Just
      Keijser wrote:<br>
    </div>
    <blockquote cite=3D"mid:56DA3817.5040602@...1147..." type=3D"cite">
      <meta content=3D"text/html; charset=3Dwindows-1252"
        http-equiv=3D"Content-Type">
      <div class=3D"moz-cite-prefix">Hi,<br>
        <br>
        On 04/03/16 22:58, ValdikSS wrote:<br>
      </div>
      how did you generate the cross-signed CA certs? I've looked around
      but all cross-signing either requires you to use the same private
      key (i.e. bit size) or that you extend the trust of one CA with
      that of another. The first is of no help as the key size needs to
      be different. The second (extending trust) does not work as you'd
      need to install this cross-trust CA at the client side.=A0 I found
      this interesting example on how to generate cross-signed certs
      here:<br>
      =A0 <a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext"
href=3D"https://chromium.googlesource.com/chromium/src/net/+/master/data/ss=
l">https://chromium.googlesource.com/chromium/src/net/+/master/data/ssl</a>=
<br>
    </blockquote>
    <br>
    I've signed my new CA's private key (4096 bit) with old CA (1024
    bit) and it became intermediate to my old CA (what you call
    extending trust), but also issued self-signed new CA. I issue server
    certificates with new CA.<br>
    <br>
    Current users trust only old CA, so to make them connect to the
    servers with server certificates issued by new CA, we should either
    add cross-signed (intermediate) certificate on the client side, or
    push it from server. The latest I'm trying to achieve.<br>
    <br>
    New clients will get configuration files with new CA inside, and
    they would be able to successfully connect, since intermediate
    certificate, pushed from server, would be just ignored. Old clients
    would eventually update configuration files too. After some time,
    we'll move all users to new CA and remove intermediate certificate
    from server.<br>
    <br>
    <blockquote cite=3D"mid:56DA3817.5040602@...1147..." type=3D"cite"> <br>
      <br>
      JJK<br>
      <br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------070106050509060409020201--

--5vaeinVB5lI4MF9wJhcBKMbaVn9vav3GL--

--20l2ASRmXcTws38KsvXkGS4mOeItaIcmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJW2m2qAAoJEFzXIC7viPdyb3YQAIOwAwuMFTRVXbGc4b7f7l0j
W+O2ab3KSszQXRhVZtosR7XHmmkoHoq9uiMuMxaeJutUVSpiUgu0U0QZ0lH45seG
B83+fd8wO4YJlvStYd+CZSc/eqopkDu2dIZ6G+L99B4X5oQiJwBBK1+71V6pBLJQ
xpy1pdR6RYFGnBPXjN9uTYr3jvq3h+y/chD58Uk1A9PjRxSYI0rIykE11RYrrIRA
dw34xiROQ3k1sqDWpQKImk2nU+TFK+e0pjBQ+8qfBMM+Hx2yEyKVsut8w/G4yFFK
49Cm+GvAq8wjFLvWYwrVfnNqZrgEZMLH3DEv+jCkLlll8gWC4mHeJ7tIO1SKb2XX
TVSGkkXcFqH6KSKIond8u4y3dc3pHqdl/1BaryAzcSQFiRHxOVnZ9X6n75mq4J8l
dbrXaZr/UGerII1NXQX30MwvmB00H147cU0Qzkjs1edRBGUtZE14ZU//KngW3vVJ
dSKTxXRArkmmpHSnyBLICPDDMCmE+rvOk5mr1k4CazG5bqiZ4ylJSkfcbHkSmNI1
oo1tXp5h+kZMiMhQo2LPJRmOg0dkLWERnrYfyukWbPjXeggfikrkoAGs2LV9Xjj/
KYQgX8LZ6vCKY1sJuzYBQ039bqCAbmnNPr200gKyONfNKpmY0mursLerC1nqwQxo
23VpM26OhxUIsmeCfJMV
=KxNn
-----END PGP SIGNATURE-----

--20l2ASRmXcTws38KsvXkGS4mOeItaIcmq--

