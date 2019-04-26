Date: Fri, 26 Apr 2019 19:56:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190426175629.GK31008@...1296...>
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
 <59329176-c948-a816-d128-4601d7720dcd@...2181...>
 <0600680d-4eb6-0790-9990-26a7cdf0b7cc@...1147...>
 <CAEYw=Woe1ycyBRx=FtL9pQOhSr66-Njwr5x3VR_46DFMQ9W52w@...278...>
 <CAEYw=WrCmqAwGDY=xEtL7Huy6pDvXVY=fgwrPz0zndKtdM1XRA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="n8rALO501tkk3VWH"
Content-Disposition: inline
In-Reply-To: <CAEYw=WrCmqAwGDY=xEtL7Huy6pDvXVY=fgwrPz0zndKtdM1XRA@...278...>
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pieter Hulshoff <pieter.hulshoff@...2499...>
Cc: Jan Just Keijser <janjust@...1147...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net

--n8rALO501tkk3VWH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 26, 2019 at 04:55:36PM +0200, Pieter Hulshoff wrote:
> As you can see, the message is never actually decrypted after the
> reconnect, and as such the server will never receive it.

So that's most certainly a bug, but not related to the suppression
of PUSH_REPLY messages - but "something handshake crypto mumble mumble".

I'm not the one who understands these bits, though...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--n8rALO501tkk3VWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcw0ZMAAoJEB2Cnv7KVigSxVoL/35xflXwDpeojRVHp43S2hma
sWQ6QP7Rv6WJifFSigZiPxxTMaLDWGOOzWRoK181gvC//BTnH6InevRHOaF9jaib
wsvMVMzzO0u3ao521+8iFizj9OAe/f3oo4hIrK/drBTBneJ3JSjjg+ZrMrOHG14p
biZlGFMpFSbyhXIXQt0MhhsgTRx/T/jFjnZSQEaMES2RhEQvHu6pc4Qakm7CUNgR
uZ9LMyz5Bd3ye82o8KP9jD134QisBP52NP3+oyyhVjVE5B4P/iLeAymi5uURK+AL
MKre/O53YrW5UKI/iGl86pD5Y00O42WygpT6zT4oeezh4OnnPSrIziPIT+pr1YmL
pGHeEQ0CLfg283m1Vh3DM6xfS+7/3OZxyhdHZu28zpeW2qx7mTplj4pzGvEfgQb9
2x3gdmX1ihVv80UXthQ523sCBhZDPTKDtTBPXUZ/sI0Ej7yp2/hAIxtmUucGIcey
3ScxNufhhz0zlUeRCramBDsItX3fMNAoGXYK3Y09Nw==
=sDS7
-----END PGP SIGNATURE-----

--n8rALO501tkk3VWH--

