Date: Fri, 11 Feb 2022 12:33:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YgZJd5GpPFsuCPgV@...1296...>
References: <20220210162632.3309974-1-arne@...1227...>
 <20220210162632.3309974-3-arne@...1227...>
 <YgZIKSDaeZjKDYLD@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="v+nHvkupxw102iOt"
Content-Disposition: inline
In-Reply-To: <YgZIKSDaeZjKDYLD@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4 3/8] Add mtu paramter to --fragment
 and change fragment calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--v+nHvkupxw102iOt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 11, 2022 at 12:27:37PM +0100, Gert Doering wrote:
> the crucial part is "lsi=3D0x0" here, I think, but I'm not sure why... we=
 do
> have a socket, we know we bound it to IPv6 (+dual-stack)...

Trying this trivial fix...

--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -234,7 +234,7 @@ get_ip_encap_overhead(const struct options *options,
 {
     /* Add the overhead of the encapsulating IP packets */
     sa_family_t af;
-    if (lsi->lsa)
+    if (lsi && lsi->lsa)
     {
         af =3D lsi->lsa->actual.dest.addr.sa.sa_family;
     }

... moves the crash onward to

0x00005555555891b6 in datagram_overhead (proto=3D<error reading variable: C=
annot access memory at address 0x24>, af=3D10) at socket.h:617
617         overhead +=3D (proto =3D=3D PROTO_UDP) ? 8 : 20;
(gdb) where
#0  0x00005555555891b6 in datagram_overhead (proto=3D<error reading variabl=
e: Cannot access memory at address 0x24>, af=3D10) at socket.h:617
#1  get_ip_encap_overhead (lsi=3D0x0, options=3D0x555555642280) at mss.c:248
#2  frame_calculate_mssfix (lsi=3D0x0, options=3D0x555555642280, kt=3D0x555=
555642b40, frame=3D0x555555642dd0) at mss.c:305
#3  frame_calculate_dynamic (frame=3Dframe@...1851...=3D0x555555642dd0, kt=
=3Dkt@...1851...=3D0x555555642b40, options=3Doptions@...1851...=3D0x5555556=
42280, lsi=3D0x0)
    at mss.c:334
#4  0x000055555557b2bb in init_instance (c=3Dc@...1851...=3D0x555555642280,=
 env=3D<optimized out>, flags=3Dflags@...1851...=3D10) at init.c:4234
#5  0x000055555557c4a6 in inherit_context_child (dest=3Ddest@...1851...=3D0=
x555555642280, src=3Dsrc@...1851...=3D0x7fffffffc4b0) at init.c:4459

which looks weird, but is likely due to inlining.


The culprit is this one:

    return datagram_overhead(af, lsi->proto);

"lsi" is still NULL...

Not sure how to fix this in a good way.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--v+nHvkupxw102iOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiBkl3AAoJEB2Cnv7KVigSGYcL/RD/9RU3UHJevLdx3m8Fwzal
cM4NGt57SVC9x39LrprBsJT9aGNmuwcxSS/zlj/PxDAke7ppL5SVaheJOX4B+XBN
FJ95wA8+ZzTQSR+uURLUAlB0A71P4WtWR/aSJHStv0x0iNISLKE5p4u9W9rWo0QB
lSE2EwFyRCTb8D23cp+Dkr8JFlGAN9kblppTeaBDOTTcmdzvvW6TzZCN4H60+zom
6njyi3seeAadWYVjTKcPUlm2sasalQzXBbso+lXkQQdApFoLOoqKaP6dEPvXM60i
A+pTDMaocAT++K3961enaxIx1ShOacZxzu7CYEIFHLPExMm8FhUCq95WZw6mekxT
U7vYyimtsBDuJY3vYF+ktRaql3zP5GvwWbBUi5CBrNOl8ThIBzv5JeyA5wStU/y5
h+iOF0MvSTkSHnZ1ZlXJ+HWWBXhR1YQ0eOoQ0y+EoDrXcl9m1XPTw/4EkrxqMJDG
ughJyOljYMT/ZV0oQDcWDq0T5JjUeU/dHYH7+CIkTQ==
=kvsj
-----END PGP SIGNATURE-----

--v+nHvkupxw102iOt--

