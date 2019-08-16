Date: Fri, 16 Aug 2019 20:44:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190816184446.GQ1349@...1296...>
References: <324fcf27-5a5a-62a7-f77d-cd279f46c712@...2080...>
 <20190808145129.1142-1-arne@...1227...>
 <f5258f61-c751-00a8-df92-5089bea2cb9e@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <f5258f61-c751-00a8-df92-5089bea2cb9e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] Rewrite auth-token-gen to be
 based on HMAC based tokens
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 16, 2019 at 07:13:14PM +0200, David Sommerseth wrote:
> On 08/08/2019 16:51, Arne Schwabe wrote:
> > The previous auth-token implementation had a serious problem, especiall=
y when
> > paired with an unpatched OpenVPN client that keeps trying the auth-token
> > (commit e61b401a).
[..]
> Since I've tested and reviewed the rest in earlier rounds and the change =
from
> previous version i sjust changing %lld to PRIu64, I'm giving
> this my ...
>=20
> Acked-By: David Sommerseth <davids@...515...>

While I'm all happy to see this ACK (and I trust David to have done a full
review on the code changes), there is a slight problem with this - it
breaks "--disable-server" builds:


cc -DHAVE_CONFIG_H -I. -I../../../openvpn/src/openvpn -I../.. -I../../inclu=
de  -I../../../openvpn/include  -I../../../openvpn/src/compat      -I/usr/l=
ocal/include -I/usr/local/include    -DPLUGIN_LIBDIR=3D\"/usr/local/lib/ope=
nvpn/plugins\"  -Wall -Wno-unused-parameter -Wno-unused-function -g -O2 -st=
d=3Dc99 -MT auth_token.o -MD -MP -MF .deps/auth_token.Tpo -c -o auth_token.=
o ../../../openvpn/src/openvpn/auth_token.c
../../../openvpn/src/openvpn/auth_token.c:100:16: error: no member named 'a=
uth_token' in
      'struct tls_multi'
    if (multi->auth_token)
        ~~~~~  ^
../../../openvpn/src/openvpn/auth_token.c:112:42: error: no member named 'a=
uth_token' in
      'struct tls_multi'
        char *old_tsamp_initial =3D multi->auth_token + strlen(SESSION_ID_P=
REFIX);
                                  ~~~~~  ^
../../../openvpn/src/openvpn/auth_token.c:119:21: error: no member named 'a=
uth_token' in
      'struct tls_multi'
        free(multi->auth_token);
             ~~~~~  ^

... so, can I have a v7 of this, plus an ACK...?

Sorry for being a spoilsport here.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdVvmeAAoJEB2Cnv7KVigS+dEL/0C9jysf++53VE68svS4fOpD
0UxgPi1xWNOEjR5M+kV64or8qYQcpnRjCx1NP2JTTXxMyC/Q1/GHmbRgkF3JvcMt
UaQe46i3IBQTjOAnv65LqFqiEIqr0guda+OdlzcmfKuIrd47AndqhgZfUY4XPudr
x1qbUBMpwwzVbgaMONZJ8kFdLNOA0psUV0+j7FxAeS8/miWKyWAnmiSRYS8yCoM9
zXzR8P3NDZxvpf7uPpY8dErVVB5BQ/MaltbKAlZ7DDfA7l9fkLxsfyOBvUatA+p2
OCq+oN/UbZl5HNjpWFASpFVCo2qeSI7/QgEpCVOA52GRKcW1CliyfX/scoTeDvB1
BaWEisi43ureXkZ9yy3eqCyqtUnHK9s1+zs2db4hs3wwJRULlbqrUCJ/K9DS+acG
AT8cM4fEG5Aumn+h9hnr8GkQw95l41ABajkoCRlujRLNKhIamJyC+uQX2pPE0moS
8fKdKikS2nJrTMKvxQBlu720D8k57UOOPrPhebAo9A==
=sCAH
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--

