References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bd3993ac-841e-1f70-f1ff-7c54990d2f28@...1227...>
Date: Sun, 30 Aug 2020 14:44:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="si2MtF2FKGuGcbg6Wtl6EBavc3HdG1TWv"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--si2MtF2FKGuGcbg6Wtl6EBavc3HdG1TWv
Content-Type: multipart/mixed; boundary="p5bBnx7f6CPO29L07lOb8TTUcOkND2tIT"

--p5bBnx7f6CPO29L07lOb8TTUcOkND2tIT
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.08.20 um 21:19 schrieb Rafael Gava:
> Hi Arne,
>=20
> This thread has a could days but I'm testing the version 2.5-beta2 and
> I'm getting the following error:
>=20
> 2020-08-29 16:02:53 us=3D643016 OPTIONS ERROR: failed to negotiate cipher
> with server.=C2=A0 Add the server's cipher ('BF-CBC') to --data-ciphers
> (currently 'BF-CBC') if you want to connect to this server.
>=20
> I have added the data-ciphers and also the data-ciphers-fallback to the
> client's config=C2=A0file and in all attempts I'm getting the same error =
message.
>=20
> data-ciphers BF-CBC
> data-ciphers-fallback BF-CBC
>=20
> I know that you guys are trying to get rid of the BF-CBC but my question
> is, should it still work if we set these parameters in the config file
> or am I missing or doing something wrong? :-)

Can you try if the following works for you?

cipher AES-128-CBC
data-ciphers "AES-256-GCM:AES-128-GCM:BF-CBC"

That helps me knowing if you have the bug I found or if it is something
else.

Arne


--p5bBnx7f6CPO29L07lOb8TTUcOkND2tIT--

--si2MtF2FKGuGcbg6Wtl6EBavc3HdG1TWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9LnykACgkQFRhsZwKx
RFQJpw/9EHHpW9s8PGuJHUBwLiaXw+nHCkcIKd8dAJI5FyoyE+s+ooIoFXEYNUT0
pzADd+NCUj9OJJKxZqiTDwe3+dlWNE1fF+yTnksBGu42qzsPe3fOxAA+PTMboln0
DnNqFQhIsQ5DZ+6mJAROvqj1EPKfLjLdB14GzWPnduaMQKM3P/dcxpxGWHlmaxHd
MykaWEAWJukXleGCRNJWNXAI/ZKbJcQR0SNflGgvsc0UNin+IuxQFyA6gaHnJfPA
YY+x54MYvPOZxFv47pg9v65/eNuan6CxOYwXAYZENpHxPm53JnNlK61gHMt0pjIy
12dNaChB+O05OpZ9R1cNXpjbrK90UzILMF1KDyzUL7IXa8inBVwkrsqn1lQYXOaT
vbRWqykgXVMefpD6h5DrcA6wfwymYup0A2D8ik3jhfPB1tW1eZ/0U9fdi+0wjOi8
tmcwjsGcjsJfvZvaa/CE4xXqt81m+8HgloVGQBf4r1ZWZteYvKqOTvr27c0zcDj1
oUkDl3u8d7D9QcjKSKgniQTLyPtzsq6Z4Ypkf3k3o6OV3fpjmrq5vw+xpr5N9Uom
7uiaoDA/uQlVmO18pvID1cXg8FTm10cZdlx8b9WizcJj+RbdtVgSelV3M1VMUIzR
F0aRqJ0UwHU+9M7Ax3asAOQdx13M6iuSiAKf5v+dE56ACZ+cI0o=
=h1Ih
-----END PGP SIGNATURE-----

--si2MtF2FKGuGcbg6Wtl6EBavc3HdG1TWv--

