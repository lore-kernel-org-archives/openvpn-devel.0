Date: Wed, 13 May 2020 16:24:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200513142417.GG1431@...1296...>
References: <1582254028-7763-1-git-send-email-selva.nair@...277...>
 <202005131357.04DDvse1080882@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="55kmsllhnyURxeAZ"
Content-Disposition: inline
In-Reply-To: <202005131357.04DDvse1080882@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Persist
 management-query-remote and proxy prompts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--55kmsllhnyURxeAZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 13, 2020 at 03:57:54PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 93ba6ccddafcc87f336f50dadde144ea4f6178ad
> Author: Selva Nair
> Date:   Thu Feb 20 22:00:28 2020 -0500


*and* to release/2.4, because "bugfix".  Forgot about that comment when
I was done with review and testing...

commit 38b46e6bf65489c2c5d75da1c02a3a1c33e6da88 (HEAD -> release/2.4)
Author: Selva Nair <selva.nair@...277...>
Date:   Thu Feb 20 22:00:28 2020 -0500

    Persist management-query-remote and proxy prompts


applies fine, tests fine.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--55kmsllhnyURxeAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJevAMQAAoJEB2Cnv7KVigSL2wMAIycHHbVMvblCRn6SayeWwi0
BfIHw+QHjF1BQODb7Z8pCONdCRxMK0hEjoI5op10VjSx/2O2BoxlurX37lDvaooH
xmbbLin9CSzN9qJPSehXA3Sv01SqJqk0hZj7L2EjQmgpc31KQXTQhlW8BeDWRDN5
pdU5WScKotqzqLbOk4YN/rQu9GLwjANgSEDY+7xtiI0qJZg6yHpZQxJJUBly24jy
wK5gYGcYHnmE2csgBncjQZKHx1fBdmphRTwHSYonHMeK5EPjNaNOHB1YK9L9f2dy
nUwtBf+KSEEIPP1/A6SKqBkSrwV14GAPei9MLxDn7cRU08OAyhg260gbc9hxnlt8
/XYvw0ZvD/3D6AeHUMPFj6Xb3Z9j604XwfCBgu4THZShlelMbfmt2ud6wVPlgAaZ
EcooVuZ2K9rnOtDZeX4PPEoF9xWEhepop0nfX57sgOZE67TqoaV2XGTc+419IUax
YirJ1ETSdTY4Ao5WYmjzAGdj7FNMDtfFTcqhNqPlbg==
=6LUz
-----END PGP SIGNATURE-----

--55kmsllhnyURxeAZ--

