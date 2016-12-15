Date: Thu, 15 Dec 2016 11:05:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161215100509.GM78624@...1296...>
References: <1481728374-7196-1-git-send-email-davids@...515...>
	<6083f8ec-b180-5cc3-b776-dd7e1e14d94a@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RGWD7DVgroTnY8ja"
Content-Disposition: inline
In-Reply-To: <6083f8ec-b180-5cc3-b776-dd7e1e14d94a@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] auth-gen-token: Hardening memory
 cleanup on auth-token failuers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--RGWD7DVgroTnY8ja
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 14, 2016 at 10:08:25PM +0100, Steffan Karger wrote:
> Looks good, but I think there's one more occurance you should
> incorporate in the patch:
>=20
>   if (openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
>                             &multi->auth_token) < AUTH_TOKEN_SIZE)

Under which conditions can this ever fail?  In other words: if this
fails, should we consider it a major programming error and ASSERT()?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RGWD7DVgroTnY8ja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYUmrTAAoJEB2Cnv7KVigSTe8MAKrIINaZTNmY6j5+U7D35rKv
FdP/5mk5G3K9lqqS2CnVgIYQ2mpREOj3whnml8Ua0Y1g0+oC9pdSGfoWwhM/ppr0
AI3E80ipgYh6i7rrdhOvQJcW0i0ju5Qsx7oTX1Si8AHzhlqRnf/iORaIDolp/6U3
Uvd0uUxKaGRmpCLCJISEogGp1RpraqFacfkPVPtVzKLnMA/RoDjbS3suPsejelSA
PN30h5hLl8ytmicv7ngq9rjqSSEpmCc45eb9u0r0mOU3hIBDRofSUP//stOqGAXW
oGQ1AxihRY4MyGNG5Ia6JsXZgvwW/7j7OS0/F6c4NaodntDr7A/UTnxlgdv24tOu
AWd61f7oI5KVovrGeTFANc1ye8UeXdzgr6eXALe+QbgcSvnDaunEYcUGLgu61yFo
4nLchqo/hVdFoIoSui3ceHEHPOItXCkbLUXEA2wohtIZGarDLRnbZzzro8kgNW8p
Ve+NKxdNwrBP53LfYPbJQODC3ur3RtIk+hggtb4hfw==
=/IEG
-----END PGP SIGNATURE-----

--RGWD7DVgroTnY8ja--

