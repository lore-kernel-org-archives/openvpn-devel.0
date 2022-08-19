Date: Fri, 19 Aug 2022 20:26:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv/V8QJjWJle0Btx@...1296...>
References: <20220629170555.116087-1-maximilian.fillinger@...2507...>
 <202208191704.27JH4gnC095081@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Te7niG+sRVbeFCYm"
Content-Disposition: inline
In-Reply-To: <202208191704.27JH4gnC095081@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Don't undo ifconfig on exit
 if it wasn't done
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--Te7niG+sRVbeFCYm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 19, 2022 at 07:04:42PM +0200, Gert Doering wrote:
> I had to apply a bit of pressure to get the patch to apply - it had
> one hunk trying to fix an #endif which never existed :-) - and the context
> of the last tun.c hunk needed adjustment (if (tun_dco_enabled(tt))) -
> both fairly trivial, and no actual code change.

"This mail escaped".  Of course I have only applied v6, but I had the
mail for v5 still sitting around, and never sent it when I discovered
that &gc was missing the "&"...

> commit 054f60fc5eaeacb90333e6b5e183459eb39a6d4f

This commit does not exist (outside of my tree).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Te7niG+sRVbeFCYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/9XxAAoJEB2Cnv7KVigSdaYL/293WTc1pgjXsCCLpUDS71l4
oYnaLNCXA+pb23/aIEusuFxTogOPbREzmGRs27BaSBtEf9726px66Y+g4Oj1L6zY
KyyczStVVCxwz+Cw1yKXns5J9l2img8OEL/P0+LbogD8XRf/enY9MKwvGeD5HpSq
ohpMcVsVJ0zJufueVsB186Gqx4YfKy02KN1NlGxfCxvduR6Cy1QzYjHgHk6Y4bMO
x4wrze/3RUCHXqu+8IoFaQpDGuES8cWjXYej4wbzGjBc4YYeY1MPFcZZlNaJDBAE
y4EdwZahk/WmsVBjr2A9AV4pplmI0/O9dYiXwFLPBlzQmk3QHVmSXiWX2KA2FIh5
oazJkIfWM1kvZrNmMJfb0zoN0/KGlqtgKDjv0/tHNLSHD++Disu5BdMK4AGCANgq
jETJs1F34SU9eWtG3/6OSrn+UdSso9rgqA78fLaZ80egeWfcuLrkewmYLKOO/Xl5
LkCXnQSWc8XIp4Yfjc9L6xODwWeyfV/gNFs3zmGLAA==
=DkKu
-----END PGP SIGNATURE-----

--Te7niG+sRVbeFCYm--

