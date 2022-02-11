Date: Fri, 11 Feb 2022 12:27:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YgZIKSDaeZjKDYLD@...1296...>
References: <20220210162632.3309974-1-arne@...1227...>
 <20220210162632.3309974-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qJpH0YpXzqc30n9U"
Content-Disposition: inline
In-Reply-To: <20220210162632.3309974-3-arne@...1227...>
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

--qJpH0YpXzqc30n9U
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 10, 2022 at 05:26:27PM +0100, Arne Schwabe wrote:
> Instead relying on the link_mtu_dynamic field and its calculation
> in the frame struct, add a new field max_fragment_size and add
> a calculation of it similar to mssfix.
>=20
> Also whenever mssfix value is calculated, we also want to calculate
> the values for fragment as both options need to be calculated from
> the real overhead.
>=20
> Patch v2: Fix syntax in rst man page

Not sure what exactly caused this (maybe the reordering), but applying
3/8 after 1+2 (in tree) leads to "UDP p2mp server crashing"

2022-02-11 12:24:07 us=3D152359 Initialization Sequence Completed
2022-02-11 12:24:18 us=3D290966 MULTI: multi_create_instance called
2022-02-11 12:24:18 us=3D291063 194.97.140.21:62328 Re-using SSL/TLS context
2022-02-11 12:24:18 us=3D291116 194.97.140.21:62328 LZO compression initial=
izing
2022-02-11 12:24:18 us=3D291376 194.97.140.21:62328 Control Channel MTU par=
ms [ mss_fix:0 max_frag:0 tun_mtu:1250 headroom:126 payload:1376 tailroom:1=
26 L:1622 EF:38 EB:0 ET:0 EL:3 ]

Program received signal SIGSEGV, Segmentation fault.
frame_calculate_mssfix (lsi=3D0x0, options=3D0x555555642280, kt=3D0x5555556=
42b40, frame=3D0x555555642dd0) at mss.c:305
305             overhead +=3D get_ip_encap_overhead(options, lsi);
(gdb) where
#0  frame_calculate_mssfix (lsi=3D0x0, options=3D0x555555642280, kt=3D0x555=
555642b40, frame=3D0x555555642dd0) at mss.c:305
#1  frame_calculate_dynamic (frame=3Dframe@...1851...=3D0x555555642dd0, kt=
=3Dkt@...1851...=3D0x555555642b40, options=3Doptions@...1851...=3D0x5555556=
42280, lsi=3D0x0)
    at mss.c:334
#2  0x000055555557b2bb in init_instance (c=3Dc@...1851...=3D0x555555642280,=
 env=3D<optimized out>, flags=3Dflags@...1851...=3D10) at init.c:4234
#3  0x000055555557c4a6 in inherit_context_child (dest=3Ddest@...1851...=3D0=
x555555642280, src=3Dsrc@...1851...=3D0x7fffffffc4b0) at init.c:4459
#4  0x0000555555591af3 in multi_create_instance (m=3Dm@...1851...=3D0x7ffff=
fffc3f0, real=3Dreal@...1851...=3D0x7fffffffc2b0) at multi.c:759
#5  0x000055555558b89e in multi_get_create_instance_udp (m=3D0x7fffffffc3f0=
, floated=3Dfloated@...1851...=3D0x7fffffffc33f) at mudp.c:103
#6  0x0000555555591efa in multi_process_incoming_link (m=3Dm@...1851...=3D0=
x7fffffffc3f0, instance=3Dinstance@...1851...=3D0x0, mpp_flags=3Dmpp_flags@=
...1851...=3D5)
    at multi.c:3107

the crucial part is "lsi=3D0x0" here, I think, but I'm not sure why... we do
have a socket, we know we bound it to IPv6 (+dual-stack)...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qJpH0YpXzqc30n9U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiBkgpAAoJEB2Cnv7KVigSjNsL/iFyZajroviS/VM7K1cpdSi/
b0tLbA/+6hRJ8CHWyHYuFtqKJzMP7mgekTt3CSnOUknC4f49XRDV2GnA2yrTVeIg
w6iMVQ8hYf5D3seGQgJXmhYXPcYIxFad0QPu5Jyn+cqibCAbVbAJq3So8JzlfmIK
mBIwCu8DlkhcDJCU1A0qV4qoWmwLWTVe9welutOf5EhguhQTAaW8ZtGHxcO0bPWp
n9cRXS18Nxag4BbivKDK5utrOCSA2+2yFDEsta3H0d3SvYvnPa8Qqou5aiyxzrFN
z4wdnpIYze2qRS1MbNmv5A28aVfwNxZ4U0xJVNeUyHMYb66Mdd6cejb679JanSSU
cM+X/NAzkoWxa68X3qPw7PQr4CguMOdyP6ABESS9TthEeLTHvX0dFftOpM4ZFIPN
0csczMN5X07NRblGNpQdumnI+DZi77KmtjzMWNPPSGvpDa2v1a4OjlBMEilh2i0l
q0vnfF8faNfG2DIuwuKu5L/l42CHYR2JMtjQKEJycA==
=nkVu
-----END PGP SIGNATURE-----

--qJpH0YpXzqc30n9U--

