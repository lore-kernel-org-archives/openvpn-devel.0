Date: Sun, 26 Jul 2020 20:32:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200726183247.GT1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3uxO57+ARnj1BgnO"
Content-Disposition: inline
Subject: [Openvpn-devel] question on use of "push" on "non --server" peers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--3uxO57+ARnj1BgnO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Arne and I discussed PUSH_REQUEST/PUSH_REPLY handling in OpenVPN
a lot recently, and found something interesting.

Naively, one would assume that only "--client" (or "--pull") instances=20
would send PULL_REQUEST messages, and only "--server" (or "--mode server")=
=20
instances would reply to them, and behaviour in other cases is "somewhat
unclear" - a non-server would not have information about client IPs
to push, for example.

After looking at my test rig, it turns out that my --inetd test case
actually uses such a combination...

 - the server side has --inetd --tls-server  (because --server is not
   permitted in --inetd mode), plus a few "push route ..." statements
   in the config

 - the client has "--ifconfig" and "--client" in its config - so, it=20
   does not rely on server-pushed IP config, but it *does* send PUSH_REQUEST
   and the server *does* send PUSH_REPLY with the needed routes.

Breaking this "interesting combination of features" by permitting
replies to PUSH_REQUEST only in "--mode server" configs would not hurt
*me* much (we want to get rid of --inetd mode anyway), but it brought
up the question "are people using this?".

So: if you make use of PUSH_REPLY coming back from a "server" that is
not configured with "--server" or "--mode server" (so, technically,=20
the remote end of a p2p instance, not p2mp), please let us know what
you do and why :-)

Genuinely curious...

gert

PS: this is the reason why https://patchwork.openvpn.net/patch/1338/
was withdrawn, for now.
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3uxO57+ARnj1BgnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfHcxOAAoJEB2Cnv7KVigSigsL/jyBkAx5ABvjI6N1PVnJjZ7E
EKd9zL8aPe7SP0aFytuJ3hNewni6tBK8kLsXWnFwk0zih93bMUP0ph/4AQ3upON5
BvD5J/vUfoX5mxD/cxp+7tftRN5+1L0ZFt0co4kZuFMc+Y4B3kbPLiDBFBjBRqQb
qlDv1zxSdGWVrZF7f9rmiOTBbWveGOPrFNirFeO9LKhz5VNqCBCcysNMeqKTutcd
GvWAvcQdfmOhT4bwhGND6PM9uWcSaLUI2p6zRz5BfYQPBgAX5+C7etBXAg3n9xLQ
Ofw9eof58LZ2whX/lZ0SS8waUJtN4QhQ7V/jcToZNuOPGBsL5IWZc2Fuojhv9HZL
ean6hQwKTfHgcROQBIKMLmhmQUXPX3dZsNtgID4q5siNKBbp/6yKuUDJqG3zBW6K
npeGKaM4n7N/+sUEdeh8miKIBmyIgLp2g+AAGaf9hU6kx2212xr062l+KL4cYt4Q
sAUWNJGivic7l2XG3vBIyCU8FXQxfCRxQH1rs92wdQ==
=Poe5
-----END PGP SIGNATURE-----

--3uxO57+ARnj1BgnO--

