References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <59329176-c948-a816-d128-4601d7720dcd@...2181...>
Date: Fri, 26 Apr 2019 16:02:26 +0200
MIME-Version: 1.0
In-Reply-To: <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dARORnW0BXSOj0jZXmc2oBcPHPpURpSf6"
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Pieter Hulshoff <pieter.hulshoff@...2499...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dARORnW0BXSOj0jZXmc2oBcPHPpURpSf6
Content-Type: multipart/mixed; boundary="Sxc8Nkzyq9xzGxYxi5K8EMEMD5QaZxwsk";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Jan Just Keijser <janjust@...1147...>,
 Pieter Hulshoff <pieter.hulshoff@...2499...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Openvpn-users@lists.sourceforge.net, Gert Doering <gert@...1296...>
Message-ID: <59329176-c948-a816-d128-4601d7720dcd@...2181...>
Subject: Re: [Openvpn-devel] Client reconnect issues
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
In-Reply-To: <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>

--Sxc8Nkzyq9xzGxYxi5K8EMEMD5QaZxwsk
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/04/2019 15:57, Jan Just Keijser wrote:
> I'd look into the way session tickets are configured and used in
> mbedtls, e.g. read up on
> https://tls.mbed.org/discussions/generic/what-is-the-correct-way-to-use-s=
ession-tickets
>=20
>=20
> For OpenSSL, OpenVPN uses SSL_OP_NO_TICKET, i.e. no session tickets are
> allowed. I don't know the mbedtls code base well enough, but as a start,
> I'd make sure that mbedtls is also configured to NOT accept session
> tickets.

PUSH messages are exchanged on the control channel *after* the TLS
handshake has completed, therefore I am not sure session tickets can
play any role at that point, no?

Regards,


--=20
Antonio Quartulli


--Sxc8Nkzyq9xzGxYxi5K8EMEMD5QaZxwsk--

--dARORnW0BXSOj0jZXmc2oBcPHPpURpSf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlzDD3IACgkQ9FVsWUWD
Dm1Xgw/9FjRfv5xJ/nRhWuVI+1YmJQ2KWA91+BqOEzRknMB11cOP2myl/huzaLCt
n5BQgnbWPjqx+rQoqb9o3fPbhZzI5LR0k1R7aSlCUxcra/WRGWsSZIfmAJMMBhqK
+jDvZSvbOx285003bt9sNETYUXTucVoztNeJpSlIX8HmWkimwSl48cK0t1qX2HzX
LB4pNW64sJfD8GDtKMkdUPKMVGT8kJdcfs56jc6AMxHR7fJ8zh2r8X7eUPhIM7Jv
waTBypi1ej1KuZ3V4PEuHBpYdTj4eH+YzBd8mfFd/YPZTPhNiHAE3gOAiZVtjbWN
A7fRMBhfE/Ssnt9AjW6QzeGhEr5k1x61Aljlp4kjrJFAAMVr3lh8uC6inESJ3gzH
3mifSlt8IKmtYawebeLmoR8/Iz4irJHT6WKlIMDEeDByIlcZFjJqYaWa+UvQNPUK
C4zL2v1dxXts1GUEu8FYNNdVxo+pgAmIofHBOdg5AJ7h3qsWyjJ3sY2OPS3EHrF6
JcVdP1fEseQYbLkhq6fmxG/Awvv32MJvB6vG122mMwurED5uvENIaDPb/7mDuSCp
tndZWBJLYFCMjlNg0qPq4pUUQld3GfZTPnQjq0a8K8aGJmAst0sYUR4dhKX+MExj
88Lhe4Z9EQo3izdNN6bIgcoQCByNrPxZHOoINl3x/vKVxL9yU8s=
=yZk0
-----END PGP SIGNATURE-----

--dARORnW0BXSOj0jZXmc2oBcPHPpURpSf6--

