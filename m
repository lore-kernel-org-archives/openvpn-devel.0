References: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
 <20200421183735.GB1431@...1296...> <20200421185953.GC1431@...1296...>
 <59fc004a-b2d7-3f7a-6f61-683acd04215e@...1147...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7b513593-81ce-d5ca-80a7-fd90fe290b4c@...1227...>
Date: Wed, 22 Apr 2020 10:13:27 +0200
MIME-Version: 1.0
In-Reply-To: <59fc004a-b2d7-3f7a-6f61-683acd04215e@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Og3CM2pWeREb6vROk5pLedek8JhJgS8c6"
Subject: Re: [Openvpn-devel] [Openvpn-users] new openssl = new OpenVPN
 release ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Gert Doering <gert@...1296...>, mike tancsa <mike@...1800...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Og3CM2pWeREb6vROk5pLedek8JhJgS8c6
Content-Type: multipart/mixed; boundary="uMqmFwGLj6xWeV55oD8BwDroRIxvsUZbK"

--uMqmFwGLj6xWeV55oD8BwDroRIxvsUZbK
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

>> SSL_check_chain() function".
>>
>> Which we don't, I just grepped through our source tree.
>>
>> So, unless I misunderstand something about OpenSSL intricacies, I think
>> we're safe - no new installers needed, and OpenVPN is not in risk.
>>
>>
> the advisory applies only to application that use the SSL_check_chain()
> function as part of a TLS 1.3 handshake. AFAIK, iIn OpenVPN 2.4 we don't
> do anything with TLS 1.3 just yet, so this security advisory does not
> apply to OpenVPN. Also note that this bug appears only in OpenSSL 1.1.1
> [d-f] , so anything older is fine as well.
Hu? OpenVPN 2.4 supports TLS 1.3 just fine. We have support for it in
tls-version-min and also tls-ciphersuites which is TLS 1.3 specific.

Arne


--uMqmFwGLj6xWeV55oD8BwDroRIxvsUZbK--

--Og3CM2pWeREb6vROk5pLedek8JhJgS8c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6f/KcACgkQFRhsZwKx
RFReBQ/9HIe5o00eDqOL9nxekQbf4FYvcQsJDpD7sjEgWTiFfhEfZo/0A0JoZ/DD
BxUCjEzzzOohOwAwIpi8p8xuEiaKcZpJQ14NamTa0DfVOWE0S7tSWPal0v2wwLx1
7qeiJUprpvv11d3lvlG745acCBiDPjyf7za2MdqSx3Rtf6GuV5EWvYq23lWF+iJ+
ROPxNuso0VsZgfZiaAUuyG3cUigtE9c813PDx5iY071FA3lI0jdOhbGUAxUdhM/k
/8DqoBZE2HErT6mp4vSdYFuZO+tzsnjXzG5PELiSoctfiT+qC1KSqHqZSdM7FHpU
a2CAb3uYi0sJSzYuokdqpB03cfaxWHjTYREckh0rpcpDD6HmRmnbT9eQKbqn6WTc
82+waCMuv27lurNqvcUPX7av8F+uO8iR/WYdqElPaijrVlCEPeiu5lJU3X47hKL0
t+tVxvctP7iLh8nOilCNP6l4hFV1qQxTIQreXCtHzDQt8PKbsW9NED41BPxXXueI
ETO8nUG35ptE51HVSBDJI2Ibq4kwBubsQjqvcw+9F2Z2E2iQFPMv+B97ru8RKVP+
xw44RKHJusKU81Mn73EPqTEc3hlc93ztd/iVvVVDLP+VUioVC/0BLO3PSr4eyx4m
5k6Dve1PtcEoBoJU2PyJytbgyUHlvqNbN1F/pfpXLTDaaPyVtYw=
=nHGx
-----END PGP SIGNATURE-----

--Og3CM2pWeREb6vROk5pLedek8JhJgS8c6--

