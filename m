Date: Thu, 7 Nov 2019 13:27:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191107122743.GQ40538@...1296...>
References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PDzrc2MStrmgSXgo"
Content-Disposition: inline
In-Reply-To: <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PDzrc2MStrmgSXgo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 07, 2019 at 02:18:25PM +0200, Lev Stipakov wrote:
> This broke (again) Visual Studio build:
>=20
> > error LNK2019: unresolved external symbol vlan_process_outgoing_tun
> referenced in function multi_process_outgoing_tun

Can you please send a patch that adds vlan.c to the list of source code
modules to be compiled and linked?

> Can we please ack and merge this patch
> https://patchwork.openvpn.net/patch/868/ to catch these things earlier?

I'm a bit unhappy with that one, as it changes behaviour for all non-windows
builds (including all the openssl build output even if it succeeds).

Besides this, we need to fix this whole MSVC mess - all other platforms
are just done with "add new source file to the Makefile.ac" and done
(including mingw builds), and then MSVC is broken again, and this will
happen again and again.=20=20

Is there no reasonable way to build these project files from Makefile.ac?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PDzrc2MStrmgSXgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdxA2/AAoJEB2Cnv7KVigSFHwL/AlBMU+VfR6OgZ8xG9OBgLBZ
DG+x+WWBM91FdrxPLLTjXOYLeVVHvuJfkl1URhY+ekC0ALImsO5A98pQfVzoTRYO
qcXU+T4Qx7NGaaVt64eA2IEGvt2Ou+kW69XyvCJ7kNcelMBNF7GCTufNbX+awxuR
1k989BvZYQPeVEIK6KKLXfiI6pm8Zk08ebrjknsC+sFItivmMfRY0IY8nf/omc8c
BR21ouWuW7NC+TVggEKUegr8oy/TWTWehBb7PR2tAo2xs0o7jsWPM4SemQC79p/i
cYcXTT6nFXi4jVyDCqFhVJQrMYU8ryXPUR07b/f8PYknnVhWxFZgt6JMZs69syvk
hb3mFCNPiLSTlMVTiq0DdRio86I/4RUP9ZLPuTR5TpkuAAOmEyB2Il6EMzhmuAzt
RvZpvKcc0blsNfwlkYo/L7l2ysi6pF4t7N2LElSMyIL086euIQ5h7QdYcTYFEk1G
VRp02VYmO93GeHPEcWqVUxACCcmsXrFM/hChKtdPLw==
=DnHX
-----END PGP SIGNATURE-----

--PDzrc2MStrmgSXgo--

