Date: Wed, 11 Apr 2018 09:15:42 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20180411091542.39c8c01d@...1799...>
In-Reply-To: <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qdaXkNbL9m.T/7DfWxbjEgc"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

--Sig_/qdaXkNbL9m.T/7DfWxbjEgc
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli <a@...2181...> on Fri, 2018/04/06 15:43:
> Two new files, namely networking_sitnl.c and networking_ip.c, provides
> two implementations for this API: one uses the new sitnl code (netlink)
> and one uses iproute2.

This complicates the situation for my followup code: Running the process wi=
th
unprivileged user works with netlink interface only. If we want to support
netlink and iproute2 we end up with creating the files from templates (or
carry static files in at least two versions).

This kicks into the discussion we had about supporting newer systemd featur=
es
selectively... Shipping different static files for distributions and/or
systemd versions duplicates the number of files.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/qdaXkNbL9m.T/7DfWxbjEgc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlrNth4ACgkQiUUh18yA
9HaSQQf/fVazc6SGZQxmZiqyTbVguRdp/SlKGHy2vTvnzG3uAE1/B18Ci8LPBNJs
JWLXwYP65aehdOLMWjIzHmdPtPp2lGSY2ayPbWXTEvNiYPrzNa1CHXOa8ojI3am5
UokFi0JVyctjHIHpA+61eOI/B+qz2THyy4ViJLCjfE4f4Ow0c59gnH2tsrKvhU1I
LxcVAK7ojrGbRmEUBveczxW9Znamo1ce0mxzuwN54laGfCeUwjBMEA1r6Kn3TRSB
40Vi934lr127/vYr/Om2ApAYJYiy/M9bmfXR9e9IlUqIQ38XhzRV8qSvDRA9Tqf2
lJSXTy6fz0p42sCOzzLC257gSdAA7g==
=um8y
-----END PGP SIGNATURE-----

--Sig_/qdaXkNbL9m.T/7DfWxbjEgc--

