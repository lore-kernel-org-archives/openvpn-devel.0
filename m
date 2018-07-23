Date: Mon, 23 Jul 2018 17:45:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180723154548.GE55859@...1296...>
References: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
 <20180719062932.GS55859@...1296...>
 <0091DE50-2189-4819-A5B8-7412C8FC32B9@...1031...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9H9VVCLI5QJPfUsZ"
Content-Disposition: inline
In-Reply-To: <0091DE50-2189-4819-A5B8-7412C8FC32B9@...1031...>
Subject: Re: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adam <adam@...1031...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--9H9VVCLI5QJPfUsZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 23, 2018 at 04:51:53PM +0200, Adam wrote:
> Hoping that clarifies your concern. :)

It leaves me a bit puzzled, to be honest...  our buildbots *should*
have caught it (NetBSD 5.1/amd64 and NetBSD 7.0.1/i386), as it runs a=20
"topology subnet" test and tries to ping the remote IP and something=20
"behind" it...

If I run the test by hand, it does indeed fail.

...
Mon Jul 23 17:28:43 2018 /sbin/ifconfig tun1 10.194.3.14 10.194.3.14 mtu 15=
00 netmask 255.255.255.0 up
Mon Jul 23 17:28:43 2018 /sbin/route add -net 10.194.0.0 10.194.3.1 -netmas=
k 255.255.255.0

nbsd70$ netstat -rn |grep 10.194
10.194.0/24        10.194.3.1         UGS         -        -      -  tun1
10.194.3.14        10.194.3.14        UH          -        -      -  tun1
nbsd70$ ping 10.194.3.1
PING 10.194.3.1 (10.194.3.1): 56 data bytes
^C
----10.194.3.1 PING Statistics----
5 packets transmitted, 0 packets received, 100.0% packet loss


Now, two actions on me...

 ... figure out why the NetBSD buildslaves did not detect the problem in
 the first place (most likely "not running the remote client test suite due=
=20
 to mistakes in setting up things")

 ... test your patch and get it in :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9H9VVCLI5QJPfUsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbVfgsAAoJEB2Cnv7KVigSc8cL/j54gxqeuJML4Xu147D4bQc0
MKM2icD7OmtVbpokCZarseszjsTyb6ISmuga4Z6oPQD4zb+0E5F9Qw25RMaT3j6a
y4WHqCMpF6pKa6ySIzc0dqeEhU/R6l9otpt7GT0lcXgK8pWhCaLAzCsifRhQENSu
3A/co1bW91uyMO55akX7P/q3evon65lWOiVMRLnwO5LUzjzFzvWjzk5X6PSRI8Cu
z4RgwEkhqKH++Z6D2q3h0mGGu0l50fTMXWur19+fA6RA6VLs5yFI7kGrUbbxLBzw
in9skj0N7MNVJL72POJLY9zYM3mPvFIeW8mZ6gAMhEM57mcoE79C+BTeew53/mZ7
0ZqPja3OV1tAWiQsYL7B5q8skgu8A41PjWHRCsLEeUj+ZRhBgMgim5iu077PcKBf
Zqd95r5nOYhv1GZdwHQj6fv4fJh17g0QxaPRXCs3rJJOcfSiq8/l3HEo6RaAoq+u
DLxmm4/57fBcEv5E+VbYvDReDoEhAfVTxQuNPMY/0A==
=DDdI
-----END PGP SIGNATURE-----

--9H9VVCLI5QJPfUsZ--

