Date: Fri, 9 Apr 2021 18:28:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210409162846.GT976@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JkruBhkweMiRU3U7"
Content-Disposition: inline
Subject: [Openvpn-devel] make --persist-key always-on and remove "off" code
 path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--JkruBhkweMiRU3U7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

there was a big discussion on the IRC channel today about interactions
between "--chroot" and "--persist-key" and how and when stuff is reloaded
or not.

Now, we all seem to agree that OpenVPN has way too many obscure options,
so I propose to get rid of another one, namely --persist-key - and I
suggest to make it permanently-active ("load the keys at startup, and
then do not touch these files again").

Unless someone explains to me in simple words what the benefit is of
reloading the keys on every new outbound connection...  yes, you *could*
put in a new key/cert/CA set while OpenVPN is active, and then trigger
a SIGUSR1 restart, having it "seamlessly" move to new credentials...

But...

How many of you do that?  Instead of just calling "service openvpn restart"?

I do not use --persist-key, but I still restart my services after fiddling
with configs...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JkruBhkweMiRU3U7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgcIC9AAoJEB2Cnv7KVigS87wL/3b+BGiBhq/VbQHh9wO7gXmb
o1aGVmzQHZlwfn4vVrTZEZElHw4t7cTS0TL0gZa39m8gyzDEV3Acg3fgewYbxySF
qSnmV+NVtOCDxuiCJi4qvi0yKGdIt9vPQ5sRqWr2A0dwVui6sYM5K83S1OMwoU2b
cC2w8tyhZnn36WaKtQxPzRmM49xdKUWDSNr2dTKdIMEg8fq1jiT3GGQAGhQii+Ci
dxaMm6B5hW+bYgz9UJxxtWBXFE/Gx56B60iuj0RDkD3sDFDnsCoZZOixhIXJX2Fe
SCQQldxhuuGCQ7AEkbpLCMESqgHRbpEe/+VAQu7qgkOF2/6B8s3x3nWMuqUtgaHE
Amwc8ofsahdAmEn1JG5izjnfzVtHbgxF7QWFzanf7mryCtmTz9oDAoKOYz++PpJA
k9oMYDzV8vdDCnbW1d3bT0HcFP4ZaFP0ufJgokvRmy5JAKbXDgW3ANjWkWd9Hje9
LzcQRmIoCRGTIMAj4zMXH2KBA7N7t62bKI1hbrBrcA==
=B7+Q
-----END PGP SIGNATURE-----

--JkruBhkweMiRU3U7--

