Date: Wed, 4 Jul 2018 17:11:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180704151116.GB989@...1296...>
References: <DM5PR2101MB1112D9B5D70AC19014BC5BEDB0420@...2412...>
 <MW2PR2101MB09219BB9BA77ADD409D3DFECAB410@...2433...>
 <MW2PR2101MB0921EB014B7B72E679386A98AB410@...2433...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lG9v85r552aFjg4G"
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB0921EB014B7B72E679386A98AB410@...2433...>
Subject: Re: [Openvpn-devel] Upstreaming pqcrypto changes from
 microsoft/openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kevin Kane <kkane@...2393...>
Cc: Jon Kunkee <jkunkee@...2393...>, Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, ???????? ?????????????? <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lG9v85r552aFjg4G
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Kevin,

besides the PQ Crypto stuff (which I find less interesting than Steffan,
because I'm the packet geek and he's the Man Who Understands Crypto :-) ),
you also have done "something with an openvpndial-0.1.dll".

Wild guessing suggests that this is hooking into the Dial-Up-Network
control panel and enabling a new approach to start OpenVPN sessions
from DUN, possibly even "on demand" or "before login".

Is this work you can (and want to) share?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--lG9v85r552aFjg4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbPOOTAAoJEB2Cnv7KVigSy9cMAJg0+NipTq0iXv1jg18xm33b
azSyrW4348TwcNKCcn1ntaZ1CVGwDTevCwwzCDrYH5swEoiLeER/JgcRRfo+6IO8
CFn9M6wWpJvdYwE80Y+OraoJZLZ1TWUTzVwTlHE1QB39jwr1fBeltsAvTDKkDO/X
R0yAvyF1TIkpORn0G/filOvKVbTtmaAHaGQs1hoovo3v/KgMVvgkpWWi/8AbSBZQ
DniobICarrAXfooFzK0aHaQattLggexeUbAykC7Y70yRep8d+j5/2zP8luAyO3tn
MjjDmkhRX9aNyIC+N5QWvM1+Oz+IFiYgJ5H6FtPJ5Jb/eGoOF6hXW4imwP+Iaxk9
dP+ynUsphuN/xHGU4JlTaDlu0E0qnH93UW5tWQKd6uLI/94r5gc/rHc1TNX7fkuQ
acRJ9dLXWS5XKKmcbBDbPeTEavKH3vuOVU5vrjNoAJvVd/+PnNZeBj6dwuxCXjuO
Ib6yPb/pybjuWFSN3m7ZUQSjcFoKAO4RNxffzpwmAQ==
=Ohrx
-----END PGP SIGNATURE-----

--lG9v85r552aFjg4G--

