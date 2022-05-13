Date: Fri, 13 May 2022 14:22:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yn5NmnwBHD2WSIQZ@...1296...>
References: <20220512231105.1076835-1-heiko@...2662...>
 <20220513093740.1091639-1-heiko@...2662...>
 <86eaf819-1fb2-126b-5cf0-ccd1d0472527@...2080...>
 <021bffb8-0a02-5c63-3d90-81f21b831187@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ufTnA+pgyj+3Yaui"
Content-Disposition: inline
In-Reply-To: <021bffb8-0a02-5c63-3d90-81f21b831187@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] signal --dns support in peer info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

--ufTnA+pgyj+3Yaui
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 13, 2022 at 01:40:07PM +0200, Arne Schwabe wrote:
> So this flag doesn't really do what I expected it to promose (This=20
> client will accept --dns and use them)

So you want something that goes hand in hand with code to actually
"do something with it", like

+#if defined(TARGET_WINDOWS)||defined(TARGET_ANDROID)
+	/* we have full backend support for --dns options */
+        iv_proto |=3D IV_PROTO_DNS_OPTION;
+#endif

and whenever a platform gets a "real" implementation, be it "openvpn
provided --up script parsing the correct variables" or "NM plugin" or=20
"directly implemented by magic", we add it to that list?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ufTnA+pgyj+3Yaui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJifk2aAAoJEB2Cnv7KVigSkoAMAKgH/ziZEUiSsXlWgp+EYc+I
F8LhwvH7s88yF5ENUT3LWeGtG2eWivkxJrU1IRuZmx/tSYXCIdwF+fQ+kvFVmnKB
w05h1iwx9JwHbjfLeuXrzd9g02zs3M7wdfZxO4uYKtlo8MqIETywaQFmjEuYbJdM
qSCFI3dcohRzBFD9hEGbPiqocvKYmXo74ktT/dtyQhCgTq3gBBam+IrQRz2R1JRu
kgPm1I33Bhl/4iK9wFlA6w0p3n7FqLjHY70j32dpoBxbdoS58y5z1LCBMAIR0Vbo
va2tsc7gTFdHKk6YgQso51kJ8msazb7EjCH/1le9ws9BKXU8UNzjkj0ZspuWCjkZ
UigwFfYJOJnO5MAGIDmP7zqIvIlZzXuwHz0N2IAtN4PJkAFoo0crfsMg9vyYVZ9W
fy/wdm5UjqkV6xmc0iykj9Fsfn7WeFrFs3q8gv+Vp5qsSmC4owHGyQ92cJ/epgoC
hZsZfCpQPFHeDUDrN54qle3Qx/Qz9pBn0sSl/VQVJA==
=Fmtc
-----END PGP SIGNATURE-----

--ufTnA+pgyj+3Yaui--

