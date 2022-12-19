Resent-Message-ID: <Y6Cf01E8aJgQhM7s@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Mon, 19 Dec 2022 18:30:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6CfqetfHEaXK/6J@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uU22S2c/6FlIDUUE"
Content-Disposition: inline
Subject: [Openvpn-devel] large-scale server tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--uU22S2c/6FlIDUUE
Content-Type: multipart/mixed; boundary="3Xz793ci9ej5Dxpn"
Content-Disposition: inline

--3Xz793ci9ej5Dxpn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I've been amusing myself over the weekend with breaking OpenVPN servers
by hitting them hard with a constant flurry of incoming client connections
and disconnects, connection time randomly between 0.1s and 15s, about
1/4 with --explicit-exit-notify, 1/4 with bad password, and 50% with
"good password and just disappearing".

The setup needs --username-as-common-name on the server side (since
all "clients" share the same cert), and a --auth-user-pass-verify
script to do the "good/bad" password.  Other than that, any server
setup (udp, tcp, tls-auth/crypt/...) could be excercised.

To get started, edit "gremlin.conf" to point to the server of your
choice (needs to be a valid openvpn client config, and *should*
contain route-noexec, because all clients would install the same
routes otherwise).  Then call "doas ./run-one.sh" to see if things
work - if yes, call "doas ./run-all.sh" to make it run ~30-50 run-one's
in parallel, until ctrl-c is pressed (or something crashes).

This might eventually end up being more polished in the "openvpn-testing"
repo, but for now I'm sharing so people can help break 2.6_beta2
with it :-)

*NOTE* - to have meaningful results, run the server with verb 3..6 - so
that *if* it crashes, there is something in the log to tell us why.

*WARNING* - do not run this against a production setup.  It will, at
least, flood your logs with crap, and might cause a crash.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3Xz793ci9ej5Dxpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gremlin.conf"
Content-Transfer-Encoding: quoted-printable

--client=20
--ca $myca
--cert $mycert
--key $mykey
--remote-cert-tls server=20
--nobind=20
--verb 3=20
--dev tun=20
remote-random
remote mytestserver 41212 tcp4
remote mytestserver 41212 tcp6
route-noexec

--3Xz793ci9ej5Dxpn
Content-Type: application/x-sh
Content-Disposition: attachment; filename="run-one.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0AAMI=3D$$=0Amkdir g$AMI || exit 1=0Acd g$AMI || exit 1=0A=0AS=
LEEPTIMER=3D`perl -e 'printf "%1.1f\n", rand(15)+0.1'`=0A=0ARECONNECT=3Dtru=
e=0A=0Awhile [ -n "$RECONNECT" ]=0Ado=0A    PASS=3Dgood=0A    EXTRA=3D''=0A=
    RAND4=3D`perl -e 'printf "%d\n", rand(4)'`=0A    RECONNECT=3D''=0A    c=
ase $RAND4 in=0A	0) PASS=3D"bad" ;;=0A	1) EXTRA=3D"--explicit-exit-notify" =
;;	=0A	2|3) RECONNECT=3Dtrue ;; 			# same username=0A    esac=0A=0A    echo=
 "gremlin$AMI" >aup.txt=0A    echo $PASS >>aup.txt=0A=0A    echo "$AMI - de=
lay: $SLEEPTIMER s - pass $PASS"=0A    openvpn --config ../gremlin.conf \=
=0A	    --auth-user-pass aup.txt --log openvpn.log $EXTRA &=0A    OPID=3D$!=
=0A=0A    sleep $SLEEPTIMER=0A    kill -15 $!=0A    echo "killed, wait.."=
=0A    sleep 0.1=0A    tail -2 openvpn.log=0A    wait=0Adone=0A
--3Xz793ci9ej5Dxpn
Content-Type: application/x-sh
Content-Disposition: attachment; filename="run-all.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Awhile true =0Ado=0A    NUM=3D`ps axwu |grep -c openvpn`=0A  =
  if [ $NUM -gt 30 ] ; then=0A        echo "OpenVPN Processes: $NUM, sleep.=
=2E."=0A 	sleep 1=0A	continue=0A    fi=0A    echo "OpenVPN Processes: $NUM,=
 start +10"=0A    for r in 0 1 2 3 4 5 6 7 8 9 =0A    do=0A         ./run-o=
ne.sh &=0A    done=0Adone=0A
--3Xz793ci9ej5Dxpn--

--uU22S2c/6FlIDUUE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjoJ+pAAoJEB2Cnv7KVigSOGQMAKUiwSz51GYT8ahH4XzpKpRi
trWDjx8BBLrn8cTCDq5Q3JHSejkF08PZ8QSYuNBwiYUpw3hahdt7M1UV+4pWJCLo
b63XWuFlSTaDRiG2P5SFZEkzVOMkggA2yNXCqzXrS0df9AsvnkYcDrHLVzp7ayY/
KA5GADeANEucwbbmXYBnMtVPjoID4Pm9IJEKNwGw0TtZGJiqH6hCLCWPntKBtY7g
EGQzaq2HxIvIOlIFXznCCJkSnvKnnXtcgGSCiJgKEBpo4C5BOVlZmeON8+HK9d8m
ml9nduRhkZ1owDYjdI7nA/oQlJasSdbrONIyzmn+1hUO0EX6foXneOQuzwbHvC+x
yemv+drRFtTxbDb1iGythKrrolursZIo6TIn7D9Nra2XdZCuDzPw7xbxpMrncjau
VOZf5+Rdckt9AS+9dOOEW/HooX1/VqED5xLlqlRqW6ejVf1PTyLbFSM1zU2QrsXj
gZHHTinO0KCNmTmGTFHivTh17D3ozmazv4S1paBiDQ==
=7GuY
-----END PGP SIGNATURE-----

--uU22S2c/6FlIDUUE--

