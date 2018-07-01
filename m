References: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
 <1ba4b18f-1861-f211-42ef-9ee23cb92563@...2181...>
 <CACDCbPq44YQzeGRwvSAaQARKk6GPWZOvDP_UmQ+LxvOyRs9bUQ@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ef435965-b357-880f-c059-bb2a49603804@...2181...>
Date: Sun, 1 Jul 2018 12:56:33 +0800
MIME-Version: 1.0
In-Reply-To: <CACDCbPq44YQzeGRwvSAaQARKk6GPWZOvDP_UmQ+LxvOyRs9bUQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wqYlywLZWsH1zvjWzliYHMvMW6dxipEjj"
Subject: Re: [Openvpn-devel] [PATCH] Remove deprecated plugin functions from
 code samples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wqYlywLZWsH1zvjWzliYHMvMW6dxipEjj
Content-Type: multipart/mixed; boundary="eqKhOr6ku4jTonDnF4SycJXnAYQA8JeiG";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <ef435965-b357-880f-c059-bb2a49603804@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Remove deprecated plugin functions from
 code samples
References: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
 <1ba4b18f-1861-f211-42ef-9ee23cb92563@...2181...>
 <CACDCbPq44YQzeGRwvSAaQARKk6GPWZOvDP_UmQ+LxvOyRs9bUQ@...278...>
In-Reply-To: <CACDCbPq44YQzeGRwvSAaQARKk6GPWZOvDP_UmQ+LxvOyRs9bUQ@...278...>

--eqKhOr6ku4jTonDnF4SycJXnAYQA8JeiG
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 01/07/18 05:08, Greg Cox wrote:
> On Sat, Jun 30, 2018 at 5:49 PM, Antonio Quartulli <a@...2181...> wrote:
>=20
>> I'd remove the last paragraph and the greetings from the commit message.
>> But this might be done at commit time.
>>
>=20
> =E2=80=8BIt was unclear how to handle "explain what I'm wanting" in one m=
ail.
> Sorry.
> =E2=80=8B

When creating a patch with "git-format-patch" there are three dashes at
the end of the commit message ("---") - anything you write after that
will be dropped when merging the patch, thus that's where you can write
what you want to explain :)

>=20
>> did you concatenate two patches? or what happened? It seems that the
>> part after this is not recognised as proper patch.
>>
>=20
> I think I dropped a few lines from `git format-patch HEAD~1 --stdout`=E2=
=80=8B on
> accident.  Take two:
>=20

Thanks. Normally "git format-patch" + "git send-email" take care of all
the details for you (without --stdout, but by just using the produced
file), so to ensure that the patch lands properly formatted.


You can try next time :)

Cheers,


--=20
Antonio Quartulli


--eqKhOr6ku4jTonDnF4SycJXnAYQA8JeiG--

--wqYlywLZWsH1zvjWzliYHMvMW6dxipEjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls4XwEACgkQB6U8WA7y
zXR93RAAkFNPNT/CVGZoS93oeLGLr281TrtJxhaGPp51Dz1ja9R/D7rffIYOA4J7
tD/DOkhooptFGhplmfhM0jr4fAYhh+Sj2gWb3NTf+XOc5q/SKiZiHiFsniQMo9rF
GZg24TcDXBRPzKGm2cJZqzE7d1L8aomtEUtHgF+EhvPIhDWRR+MlCcCJYAjS61ec
eAzx9/M8GgX49l9uqqkjQqO+RAcumGfjx/+rWnFijqNDsHYZyPEvwWPDXx1e7TfD
3jT+haluXfCL4x5SA7aqvGO6q0dyIfpHlLJ1FHfI4bUhyxcCLWKCgnJ72C/xU/vh
WpwaVok0WQHC2nZA+75eKO2ld7G/oYGDB7hq1E81kWVondF37qhW+9iEXJe1Nf35
iRw2vSQMq9hBTAwFEAcqnCA5jQPQlUELL6od7c4mBajCYCz3UwA1zfrf9muvDLgY
rs5uhxJB2ISKcJ7pVzsqWBwmaZWPXz3eNBukhwGb77hy4ef5MEtUYGdrHrXkC4By
qzh3wc8EpFeUgZoKH8WiXoLW0/qPukM81nsVr4e1J3UJXCBuNqlqgwfI9CJaCOXl
j7KnVUG0lBpSqIZanoyI1959mAryGhaMVyLhQx69EuNxUO4u0POhq31sp7tLtI2U
GaPVUQ0UZTYNHNvjl0k95Qj7htUn+syAPxB1YbYqBUA+d3me1ig=
=XYYW
-----END PGP SIGNATURE-----

--wqYlywLZWsH1zvjWzliYHMvMW6dxipEjj--

