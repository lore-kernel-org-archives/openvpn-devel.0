Date: Mon, 12 Mar 2018 09:21:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180312082122.GP69387@...1296...>
References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gqUrV6DUXoHnB0ku"
Content-Disposition: inline
In-Reply-To: <1520817479-17203-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip expired certificates in
 Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--gqUrV6DUXoHnB0ku
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Selva,

On Sun, Mar 11, 2018 at 09:17:58PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Have the cryptoapicert option find the first matching certificate
> in store that is valid at the present time. Currently the first
> found item, even if expired, is returned.

Are these two intended for master only or master+2.4?

(I admit that I am too lazy right now to go and actually look at the
surrounding code :-) - but with all the recent work wrt cryptoapi and
external management key, I lost track which bits are considered "new
goodies for master only")

Functionality-wise this makes sense (feature-ACK), and it also makes
sense for 2.4 - because "if there are two certificates, an expired and
a valid one, and we take the expired one" smells very much like a bug
to me :-)

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--gqUrV6DUXoHnB0ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJapjiBAAoJEB2Cnv7KVigSnmEL/3KWgMdSHoAyrXCTIUJXF4z6
g2IzWrDeiBlAMKBEEQiptYyinkLQIS3fSFmbqAQyvnQcARbq80vQFOoVydh9cMXH
xZ/cnwp8Ovpkb7yWopcvaZaoTrY80TjtHLDI7kVM3HgDD9nniQFGg/mKfcl1+eK9
ZUSEZBbQysKsFATMMmC7B80g2A4B/io5j4m7DTUMLe3ARjF7qMXLb2F3E2lvV6D9
VtFObRJuJ1tQkODmwjGAXpfiusAQG/iBq6z5AYJcF4IkjEAK2GpWjlUeh4dcnlpk
Hf0OEqbQKvg4C/ax4Lm76rEu/2+7IXYTQdc57ZlF/Q7qSAF/fGuRf+yKVQSAO5bD
x6PeV3fqC6oiLFMxE0bQataPt37Yl4vgjCTxZUcdDP0PZdng2/q+er9ncEeSPI2J
KRCiSbQFdIziOl1TndpvOzn0/IWMxJDr86Jjg97XX7Wxsc4ncxTF0AhYYayCZ3fR
5cRvR7OtxCfFlzLkTFWeqeN5ZYLy+Q7d1eDnIwMIOw==
=SPSG
-----END PGP SIGNATURE-----

--gqUrV6DUXoHnB0ku--

