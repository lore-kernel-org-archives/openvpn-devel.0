Date: Fri, 5 May 2023 09:33:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZFSxQELSohwLfK-V@...1296...>
References: <ZFSsu3eazsdo8zoA@...1152...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YRR39cIE+Wipn+7O"
Content-Disposition: inline
In-Reply-To: <ZFSsu3eazsdo8zoA@...1152...>
Subject: Re: [Openvpn-devel] [Openvpn-users] auth-token-user/auth-token
 issue with "TLS Auth Error: username attempted to change"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--YRR39cIE+Wipn+7O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 05, 2023 at 09:14:03AM +0200, Ralf Hildebrandt via Openvpn-user=
s wrote:
> May  5 09:06:00 openvpn-gw170-int openvpn-udp[29574]: hildeb/10.31.192.11=
5:55334 TLS Auth Error: username attempted to change from 'hildeb' to 'hild=
eb::1f047fb6' -- tunnel disabled
> May  5 09:06:00 openvpn-gw170-int openvpn-udp[29574]: hildeb/10.31.192.11=
5:55334 TLS Auth Error: Auth Username/Password verification failed for peer
>=20
> What do we have to do to make the server accept the the
> auth-token-user it pushed to the client?

As of today, there is no way to make it do that.  On initial TLS
authentication, the session is tied hard to the initial username(*),
and changing username on reauthentication is not allowed.

That said, this breaks at least two use cases

 - there was no initial username/password authentication at all - and
   you absolutely need auth-token-user here, to make the client actually
   send the auth-token back.  It fails, because the server is locked
   to "empty username" - I have sent a patch for this, but Arne is not
   fully agreeing with me that it's the right thing

 - actually *changing* the auth-token-user from an original username/passwo=
rd
   authentication - it runs into the same problem, but this might be=20
   workaroundable by not actually pushing a new "user".  So, question to
   you, what is the intention behind changing the username here?


For "my case", I think handling the "username was empty before" case
specially is the easy way forward (even if Arne disagrees), but for
"your case" we'd need to disable the "tie TLS session to username",
which is a no-go for Arne...

So maybe we need to introduce a new server option

  push-auth-token-user $name

which would be internally converted into

  push "auth-token-user $name"
  + tie $name to the TLS session

Will discuss this with Arne.  Not sure he's reading openvpn-users - so
copying in openvpn-devel.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YRR39cIE+Wipn+7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkVLFAAAoJEB2Cnv7KVigSXLIL/2sFrDATnm3wHGnbmLk2SO+B
YXTkiTVGA7ql/5sLFbLSq/uPBqTe/NTFn0OGElF1ooEc4+Dw3OkLWQLI775sZX/O
NS+dirhBRt+tuMJ4Ka98fa9QK3f8nvJ7EH9VwN2M0gDHd0F+tYXNsvmPl0e1pifz
IXX5d5cdAEl5fBPq9hqMMkFfjmtFS7dLy/Uq9aLm8zQN6aCb4dKZJp03nmc+UHfB
i/BNI1IUl5GHBhSl9R43ELPM6pj1wC0DpQhs7XzCjoYQbYs/GdpsjXFAW9mnfC+F
V1vLw+LR5rU/4Hr3wTY3+prQ3p8cyzuhc5nGahfFJ2xSIUW4P2WR2b+DD1DQUlAZ
ndvSL6IULoP4MQQ43R/OVxfs+g6015P3tGGLYvinxqU3ZcTqVfSVc27WqAm4w0Vp
b80upiERF3ilOstU4hokPFB8oWCF+9SmiGvgXfs6LegaCYPl92MfnAkXqXcM1Rho
1gmkoaugLLfoDMSsS2XpUmBXJhsDpvZTzxxmAvJCNQ==
=pTrI
-----END PGP SIGNATURE-----

--YRR39cIE+Wipn+7O--

