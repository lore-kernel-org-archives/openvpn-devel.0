Date: Tue, 21 Apr 2020 20:59:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200421185953.GC1431@...1296...>
References: <2b5fbffa-6b18-2226-5b29-7c6be670413b@...1800...>
 <20200421183735.GB1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+QCzO7ZIoRBwAbcw"
Content-Disposition: inline
In-Reply-To: <20200421183735.GB1431@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] new openssl = new OpenVPN
 release ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mike tancsa <mike@...1800...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--+QCzO7ZIoRBwAbcw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 21, 2020 at 08:37:35PM +0200, Gert Doering wrote:
> On Tue, Apr 21, 2020 at 02:15:43PM -0400, mike tancsa wrote:
> > =A0=A0=A0 Will the sec issue with OpenSSL force a new release of OpenVP=
N ?
> >=20
> > https://www.openssl.org/news/secadv/20200421.txt

So, speaking to myself again :-) - I've looked at the advisory, and
it talks about "Server or client applications that call the=20
SSL_check_chain() function".

Which we don't, I just grepped through our source tree.

So, unless I misunderstand something about OpenSSL intricacies, I think
we're safe - no new installers needed, and OpenVPN is not in risk.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+QCzO7ZIoRBwAbcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJen0KoAAoJEB2Cnv7KVigSLqkL/3F/LXjQ0XVlA8mqw7Bmz4GT
YIF8n8IxY2PRBsNI4A65tAgYZB0v1XFvBM6FHBbqPBrYFZUTi2ZXp+IY2c+DY/zd
IfRbbbVj/Od8g92VAY6uOqswiSNpQpwAeu4dTQYM4CxsA/QCMZyMRL7XXLrtzjM6
LukRhqOLktWA9tc3g+qf+ZX8hQq0P29OV9PSQETGGFUZIgu5572vlpJhi4Ympj/+
8JWjTeGxdlRxobl8sA7n+7E6+csV9a9VFcpmLu5LYDMY12aZyPxA6wZXRU7Hpxuw
WB/af/r5DT0uVW15ZbQQw2JEKSON4oo0uVVqC/nl+70Ynnfa33IreysLDPwfotJP
BhPQcGWmso1AyE1qsizChcjSIi6hXRJjtGYp/rKawf7RqLvqsCAAA6px2W75Och9
GtvbYFeb71Ta+p3z68mpwUSdC9a8iTbrJrkjaR47oIqoVjPRIjICtXkJ+82RP4Rq
UlZyfrPSj7IXHV7LsTmUW9fCfdyMllslCXcdlo5fLw==
=G0xK
-----END PGP SIGNATURE-----

--+QCzO7ZIoRBwAbcw--

