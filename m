Date: Mon, 13 Jul 2020 08:58:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713065828.GN1431@...1296...>
References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <20200713061023.GK1431@...1296...>
 <20200713063303.GM1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VkeZbbawk1bLsZB0"
Content-Disposition: inline
In-Reply-To: <20200713063303.GM1431@...1296...>
Subject: Re: [Openvpn-devel] git master crashes on connect of 2.3 client
 with --enable-small
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--VkeZbbawk1bLsZB0
Content-Type: multipart/mixed; boundary="3M2bWMunpm/Om+dB"
Content-Disposition: inline

--3M2bWMunpm/Om+dB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 13, 2020 at 08:33:03AM +0200, Gert Doering wrote:
> On Mon, Jul 13, 2020 at 08:10:23AM +0200, Gert Doering wrote:
> > Ouch.  This is not good.  My gut feeling is "2.3 with --enable-small =
=3D=20
> > no OCC *and* no NCP =3D the server runs across a NULL pointer here".
>=20
> B=E4m.  Fully reproduceable here
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7af51be in ?? () from /lib64/libc.so.6
> (gdb) where
> #0  0x00007ffff7af51be in ?? () from /lib64/libc.so.6
> #1  0x00005555555d4a7b in ncp_get_best_cipher (server_list=3D<optimized o=
ut>,=20
>     server_cipher=3D0x5555555f28da "BF-CBC",=20
>     peer_info=3Dpeer_info@...1851...=3D0x5555556781c0 "IV_VER=3D2.3.18\nI=
V_PLAT=3Dfreebsd\nIV_PROTO=3D2\n", remote_cipher=3D0x0, gc=3Dgc@...1851...=
=3D0x55555565e070) at ssl_ncp.c:231

... and this is why (added a msg() call):

2020-07-13 08:36:59 us=3D802772 ncp_get_best_cipher(), peer_ncp_list=3D, tm=
p_ciphers=3DAES-256-GCM:AES-128-GCM:AES-128-CBC:AES-192-CBC:AES-256-CBC, re=
mote_cipher=3D(null), server_cipher=3DBF-CBC

if "remote_cipher" is NULL (=3D no OCC) we pass that to "strcmp()", and that
does not want it.


Returning NULL from ncp_get_best_cipher() if there is nothing the client
has to offer works fine, though it triggers this warning

2020-07-13 08:43:01 us=3D483904 cron2-freebsd-tc-amd64-23/194.97.140.21:309=
27 PUSH: No common cipher between server and client.Expect this connection =
not to work. Server ncp-ciphers: 'AES-256-GCM:AES-128-GCM:AES-128-CBC:AES-1=
92-CBC:AES-256-CBC', client supported ciphers ''


which we might want to reword for this case ("No information about cipher=20
support received from client, cannot ensure correct operation" or so).

Patch appended.

Comments?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--3M2bWMunpm/Om+dB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Handle-connecting-clients-without-NCP-or-OCC-without.patch"
Content-Transfer-Encoding: quoted-printable

=46rom c67f62a8ecd7d65af8d22bd65e86d1bcacaa5294 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Mon, 13 Jul 2020 08:54:28 +0200
Subject: [PATCH] Handle connecting clients without NCP or OCC without
 crashing.

ssl_ncp.c:ncp_get_best_cipher() would crash if a client connects without
NCP (or with a NCP cipher list that does not contain the first NCP cipher
in the server list) due to a NULL pointer strcmp().

Work around / fix by just assigning an empty string to remote_cipher here
("not NULL but will never match either").

Add new warning message in multi.c for the "we do not know what the client
can do" (no NCP and no OCC) case.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c   | 16 ++++++++++++----
 src/openvpn/ssl_ncp.c |  6 ++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a2af071a..3302959e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1833,10 +1833,18 @@ multi_client_set_protocol_options(struct context *c)
             {
                 struct gc_arena gc =3D gc_new();
                 const char *peer_ciphers =3D tls_peer_ncp_list(peer_info, =
&gc);
-                msg(M_INFO, "PUSH: No common cipher between server and cli=
ent."
-                    "Expect this connection not to work. "
-                    "Server ncp-ciphers: '%s', client supported ciphers '%=
s'",
-                    o->ncp_ciphers, peer_ciphers);
+                if (strlen(peer_ciphers) > 0 )
+                {
+                    msg(M_INFO, "PUSH: No common cipher between server and=
 client. "
+                        "Expect this connection not to work. "
+                        "Server ncp-ciphers: '%s', client supported cipher=
s '%s'",
+                        o->ncp_ciphers, peer_ciphers);
+                }
+                else
+                {
+                    msg(M_INFO, "PUSH: No cipher info received from client=
 "
+                        "(no NCP and no OCC).  Cannot ensure compatibility=
=2E");
+                }
                 gc_free(&gc);
             }
         }
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index ea1dc960..fe7f5855 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -225,6 +225,12 @@ ncp_get_best_cipher(const char *server_list, const cha=
r *server_cipher,
=20
     const char *peer_ncp_list =3D tls_peer_ncp_list(peer_info, &gc_tmp);
=20
+    /* non-NCP client without OCC?  "assume nothing" */
+    if (remote_cipher =3D=3D NULL )
+    {
+        remote_cipher =3D "";
+    }
+
     char *tmp_ciphers =3D string_alloc(server_list, &gc_tmp);
=20
     const char *token =3D strsep(&tmp_ciphers, ":");
--=20
2.26.2


--3M2bWMunpm/Om+dB--

--VkeZbbawk1bLsZB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDAYTAAoJEB2Cnv7KVigSc2ML/3mRS0tUJXaUf7MaSNsmVjH7
Ni9fwEpM/TzXgyyeVcPP3nMBPx/xH0K4l2jDr2NHSJkDKzKwZNRMf4RyDb8U+84M
HsVHykY2LFhmEJlvn6it5Y9nw0KHZ76lBs93OJA8hoiHCF4zizsNgwUojejEZqZA
cgprwYdaj+lO3GSKE1y5UqeVHMgcs1QsyCNPLvpldKzkZ7vGTkz80x78qMexl0uB
oXOiqNv1vK3453YNB3N11PoCqDnL+WfT+dwv1j1bp7qnZED0ZpoJ1SJBHbsR53tS
hstX9DxXpfsMU4BhphXOzqsTERkUf9/4tnos6M2hVVNt3m/Q9fxknetdG8p5/i+E
+LlDxdO2w7sz5e8DycrUO40TByu9gj0HL5Cs2yFNy5VVu0vT7IkaVLVSBeJ9zfpE
W5a+iNli4YGkwB5JHY9QV5srromeSTDR8ALNlsxuef1zWl3akbybf8b3PhVkLCdM
20GdOqvNARdLe0MEN0VR22Gcw7iLua84M5ElfdE10w==
=FzkX
-----END PGP SIGNATURE-----

--VkeZbbawk1bLsZB0--

