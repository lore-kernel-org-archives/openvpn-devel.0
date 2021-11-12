Date: Fri, 12 Nov 2021 07:57:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YY4QQ/QuOvTN8dN2@...1296...>
References: <20210520151148.2565578-7-arne@...1227...>
 <20211111192051.3706965-1-arne@...1227...>
 <YY2GYxV5lT8xVoF8@...1296...>
 <CAKuzo_jqbuwOtwfjh9DZnf8OiMZ22AdSi6y3Nbw7dv+QU=GHDg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jgGQ4+Qfyt3Ry4ZQ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jqbuwOtwfjh9DZnf8OiMZ22AdSi6y3Nbw7dv+QU=GHDg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v5] [OSSL 3.0] Allow loading of non
 default providers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jgGQ4+Qfyt3Ry4ZQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 11, 2021 at 04:26:17PM -0500, Selva Nair wrote:
> I'm supposing that we do not want --provider to become a M_FATAL error
> in mbedTLS builds.

For "generic OpenVPN" I'm not sure this makes a real difference - you
know what your build uses, and if you need --provider, you know that
you do (it's not something you add for fun).

For my server testing environment it does, as it builds with different
crypto libraries for different days (mbedTLS, OpenSSL 1.1, OpenSSL 3.0),
so having an option that is needed for 3.0 builds but breaks mbedTLS
builds would complicate things...

That said, the code looks like it assumed "the option is always there,
so on mbedTLS, ignore and warn" :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jgGQ4+Qfyt3Ry4ZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhjhBDAAoJEB2Cnv7KVigSRDIMAKxgrddOdvTX+XiofM/mnhON
+Eq/pYNPkFyt3DOzCSuA9ec7LooGApdjnIHt/KdCt1m9qfMc9fDHsWbEjfJtOxT2
J5sAASpmhgXO2bF1AJ3KypDwCPu2J867xiDt3zw+9B1AZO2P2GX2QDfEIS4HP5XT
RJd1c4L2XYwR5RkDHfjcI49yAqXVApal3iznpIA2KKln0M3zE7fynMCx41cUSX6e
AUI1lQ7GU6F7+DEuPXVnZS0DulgWxwe1FmRXczgu2amqv/fgMvJaqMz51DNrUoTP
htaVCMBOb0ftJePp9lxYGJkz4/Qfm73ecTrL64IX5u+RBgr/alxmTi5jcgR3JqPy
0BAqhjnUT6Z7SgZCzQDxFtBsfe2Lq/fH7i4O2j8zM3tV50RafBEkdBzvv9rTPgg/
uwYtj8eScAHZEr+ZsDuhOX217mhDhKNpGC8Kno/k8so4inbxKM9/bklkaKQHbb+1
SGJwXAKsgFI1f2306ueGPolbHz9K/6Z+MkhJ1biQnw==
=DcNw
-----END PGP SIGNATURE-----

--jgGQ4+Qfyt3Ry4ZQ--

