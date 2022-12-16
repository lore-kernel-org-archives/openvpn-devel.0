Date: Fri, 16 Dec 2022 08:47:40 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5winDLuxdoNbkcb@...1296...>
References: <20221215190143.2107896-1-arne@...1227...>
 <20221215190143.2107896-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ePo7y+/VViv5Zqjk"
Content-Disposition: inline
In-Reply-To: <20221215190143.2107896-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/8] Make management password check
 constant time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, Connor Edwards <cedw@...2705...>

--ePo7y+/VViv5Zqjk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 15, 2022 at 08:01:36PM +0100, Arne Schwabe wrote:
> This changes the password check on the management interface to be constant
> time. Normally the management port should not be exposed in a way that al=
lows
> an attacker to even interact with it but making the check constant time as
> an additional layer of security is always good.

NAK on this, the min_int() logic is wrong.  My fault, sorry.

With this, it will only compare "up the the number of bytes that the
attacker has entered", and if he happens to catch the first character
of the password, he's in...

Escape character is '^]'.
ENTER PASSWORD:f
SUCCESS: password is correct

... the password here is actually "foobar"...

Doing a "+1" on the compare length will include the 0-byte (which is
different here, "o" vs. "0"), and that should cover all cases.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ePo7y+/VViv5Zqjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjnCKbAAoJEB2Cnv7KVigSWzkL/jMlnq4rYp2kc31YruC5mnZp
t5xJ+ptjrKiI2cMOGaRdy+EL4GKYDQL3UMcEyFLMrUu4ZJA9RHqZraTod0fx1qo6
eKa0tCVY8qZvr884z5gCNuh1rtO9Pd9mgEqBb8/fZsXI8yND8ruWRIzJu2npk0xX
zx8dPR9GSauKO26jemMnnvbnOEYI3Hj/ntMZWKyKs5tIRbwJ7848fYKYNtj5WhOq
MvLtigG7rzQHnhFQ1XCsKcbdOnqoXOqOxnZAVzq/csEpOtNqW2mTPs3z1sU9VkRP
V697W8DQQCjfPmbHtBiSUMBvn9GA00XGYEcAK01U1X/BcddG4TAM9Ui7VFBkUpMx
pHhK8mY/TQn1KC6nTVdyNR/9CJ/o18osGQnOv4zBdkZ1hXN5i3JgAgZJkGAFzg2S
uLhoJw9koGU6HFf4wmzZJzYM8LmyLR8dGuGi4mc2ffEvHSWNTXXMB6p6d0t9cyL6
y6BHWUmTJ6ExScscdUljI6QwhKOstZiq69aIw6P+yQ==
=fR7c
-----END PGP SIGNATURE-----

--ePo7y+/VViv5Zqjk--

