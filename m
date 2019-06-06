Date: Thu, 6 Jun 2019 12:18:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190606101824.GT1097@...1296...>
References: <20181219050118.6568-7-a@...2181...>
 <201906060650.x566o635087246@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yAzUYvkKIfeS0jQX"
Content-Disposition: inline
In-Reply-To: <201906060650.x566o635087246@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: unit tests: implement test
 for sitnl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--yAzUYvkKIfeS0jQX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

t_net.sh definitely needs more polishing... I see quite a bit of
buildbot explosions after this last commit.  Some of these look
like "why...?"

./t_net.sh: sudo /usr/bin/kill -0 succeeded, good.

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

sudo: no tty present and no askpass program specified
unit-test 0 errored out:

FAIL: t_net.sh

... so it really shouldn't check whether "kill" works, but whether
the "sudo $mytestprogram" works...  (and the buildslaves need to be
adjusted to permit this extra path) - and if not, make this a SKIP,
not a FAIL.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--yAzUYvkKIfeS0jQX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc+OhgAAoJEB2Cnv7KVigSRw0L/1UWOfVTNkqkSuqafM8wxCgm
Hty8vH+nGbMXxOqPoKBh6OyzX5+I6wG960vphCTg17u3ZJkt41+9JeqXCXw2Q7p1
8hmvYBrrR71ppNrfrGlvuCW+5P7b/1QLy1FBmIWIEmekx64CczLB9+ikyr/MD99i
AkI/Oh5gUHOPnkyh0zK2RnXEt4mrAw8IIOqEQ/gjEoigqX06UCF6Pttvmhz0Fe3W
gsiXJqP0V3wBGA/4RF46TtrpMyB2AKtUuiZJcgXCHvd10dxGs4xrB7XfJfO2ZGIt
Ll1wFpJvDjjUlASRGzNwwup8FJkhdIzpX4Q7mauVHUOIHYQ5nXEXoAHUGkWKC6Cx
LxOY4y2HYYWiJSfHTYM4P/bjkFjXHk0mt6ku57WRpugGoqUkRyWn74iuwz0/rvhI
aGSWHdK/iwxeMuQXIzwyyhsloGu6s9ZibfBrWNa9CKCapDJWUqWnAmHkfUHGvvjs
Ko6rVa3eiO7I5/NbOVr3LdIU0d8TO/+oT80u9ylNuA==
=kaTi
-----END PGP SIGNATURE-----

--yAzUYvkKIfeS0jQX--

