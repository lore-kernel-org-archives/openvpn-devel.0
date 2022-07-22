Date: Fri, 22 Jul 2022 18:15:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YtrND9EAUEoe4Lvv@...1296...>
References: <CAGyAFMWSHhzpTzEe+TJXD6jasv+w+vGCYygH6uXjEm1k4L0qxQ@...278...>
 <20220503002840.295-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fb6wHmicrABlvKzo"
Content-Disposition: inline
In-Reply-To: <20220503002840.295-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix M_ERRNO behavior on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--fb6wHmicrABlvKzo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 03, 2022 at 03:28:40AM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> We use M_ERRNO flag in logging to display error code
> and error message. This has been broken on Windows,
> where we use error code from GetLastError() and
> error description from strerror(). strerror() expects
> C runtime error code, which is quite different from
> last error code from WinAPI call. As a result, we got
> incorrect error description.

This patch breaks extended socket error reporting.

In the git tree, we have those two right next to each other

commit 54800aa975418fe3570f3206a5f9b277dc59bd47
Author: Lev Stipakov <lev@...515...>
Date:   Tue May 3 03:28:40 2022 +0300

    Fix M_ERRNO behavior on Windows

 -> broken

commit 043c67f36342969cd171d24c70ee6b62ebc95fee
Author: Gert Doering <gert@...1296...>
Date:   Tue Feb 22 15:35:14 2022 +0100

    Implement --mtu-disc for IPv6 UDP sockets.

 -> works


Testing is easy: point openvpn on a Linux system(!) to an unreachable
destination (--verb 5 used here, but 3 should be sufficient)).

With 043c67f, this gives

2022-07-22 18:07:59 us=3D599924 UDPv6 link remote: [AF_INET6]2001:608:2:a::=
253:1196
W2022-07-22 18:07:59 us=3D628976 read UDPv6 [ECONNREFUSED]: Connection refu=
sed (fd=3D3,code=3D111)
W2022-07-22 18:08:02 us=3D168862 read UDPv6 [ECONNREFUSED]: Connection refu=
sed (fd=3D3,code=3D111)
W2022-07-22 18:08:07 us=3D228896 read UDPv6 [ECONNREFUSED]: Connection refu=
sed (fd=3D3,code=3D111)

with 54800aa9754, this becomes

2022-07-22 18:14:16 us=3D271797 UDPv6 link remote: [AF_INET6]2001:608:2:a::=
253:1196
WWWWW^C2022-07-22 18:14:46 us=3D706438 event_wait : Interrupted system call=
 (fd=3D-1,code=3D4)

("nothing nothing nothing ctrl-c")


I can see that the patch at least touches code close to it...

+#endif /* EXTENDED_SOCKET_ERROR_CAPABILITY */

... so it would be nice if someone could have a look what this patch
is trampling on that it shouldn't...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fb6wHmicrABlvKzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi2s0PAAoJEB2Cnv7KVigSCf4L/3HQr5lLCQ/PNiOBoiHsn7HX
0YDPG/1c8P5gIzbIExP7I1QdSOCoM8Bme/HqR4cYplZS11TqsiGhd8i/trmUg0gf
61BHMIh26kBEf4eOUq90o3W0lKZq+s/YA3C6ui2jz2GSy4x3BreOxaSjF5pmmQ2w
bJ6qwPbqAYvwKio8SPezWk7QKP0z/s8EJcm7VOLtxbVAZxcbSKGNy67RKywcOKT0
orJhcM6Ll0MTZp8z/DvWQAgc1e4AvZjrw5CjlIPk1CVeRaq8mihwgoJHNJIWg9Wt
U7G7CcR6RYGpPwlz1+vzSxsFh91qmupwzBzKBbPNC2lqCvvzto1i1/oJPe5ec8P7
tf9FtnrGi0JmrWgWdbzkIfTHx1ICsjh7w0xY1F1oymIjOC6b5bjdpuiybl5pRwtr
m9wHwwVPe2wRHiPUgaEjQGjHGeumV/toMqTFpYo1WraL8++AlW9l1KwZwNFCIeRS
Z5T4QuoouIKOEl2v+0jMxGr3CLVWYUIe5hVFwD9Qkg==
=03py
-----END PGP SIGNATURE-----

--fb6wHmicrABlvKzo--

