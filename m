Date: Mon, 4 Jun 2018 09:15:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180604071508.GS79551@...1296...>
References: <20180602034206.9459-1-a@...2181...>
 <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
 <ceb7f155-cfc4-ac89-4703-fed77e662881@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bS87dHSPlkoPpvQ6"
Content-Disposition: inline
In-Reply-To: <ceb7f155-cfc4-ac89-4703-fed77e662881@...1147...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a
 per-connection-block option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--bS87dHSPlkoPpvQ6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 04, 2018 at 09:10:23AM +0200, Jan Just Keijser wrote:
> What's the particular use case for putting tls-auth files in connection=20
> blocks?=A0=20

"I have one existing server that is not using tls-auth yet, and a new one
that has tls-auth, and I want both in the same config file"

Plus, what Steffan mentioned: tls-auth rollover

> Does it apply only to tls-auth/tls-crypt files or also the=20
> certificate/private keys?=A0 I could see a use case for that as well...

Right now, only tls-auth/tls-crypt, but this is the same question I asked
on IRC yesterday :-)

The "traditional" use case ("my key/cert is my identity") would see=20
"a single identity for all remotes", but indeed, upgrading to a new server
with a new CA (--ca -> <connection>) and newly distributed identities
might also be an interesting use case.  For @work, I've decided to tackle
this part with "just distribute two .ovpn files", but it's worth thinking
through the idea.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bS87dHSPlkoPpvQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFOb8AAoJEB2Cnv7KVigSOiQMAIbVcW2OIAff0/qi6tmkcoKG
+VtWTKQNGw6qUusdCeaxsrHZVTbZuWZMd2OoC/4giQPczq5J4mmmEtWHu5EZuNKm
SJP1ww6XqHbrgbO7wePaMt6lwEl4Fg6WC8j6OOH5m23LW2dzGJ2EEVCl3+OcpLn1
8PJairamqNgwuoTdpxOrQ0fZ5Mtb9YQKrycZ8Hvjj0o1tOflvEh8HbTCjRPtl5l0
ChS1j2xEX8iP+tZtxQ49uE8FYty4KsA/OPuix6qz7fxZLgxG7oscKsnzxViBtuU2
xZNxMNAXCWj1vL1/iUAkx7tPSOlG/75r2m+U4zTbORqMSSwOI9yXIph2MgS37gBk
hoQ5TinJVz7UaIfNFczEL7qM1ENXKgxKU+XUUncDy2h259ud4XHK1Pc9MQEx+QUw
mneuyZjeMqzc0CGnGlUO+O7jvebmZBwijkPAJg+WYpWmWGaOJDEBPjPBR84OKkHe
vrqviT7yc8VBEbyX1WBvYbmKRoo6XoDz8YC0kO50KA==
=rnF2
-----END PGP SIGNATURE-----

--bS87dHSPlkoPpvQ6--

