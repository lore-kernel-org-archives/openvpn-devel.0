Date: Mon, 19 Feb 2024 14:49:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZdNcUQEFzxLaKLMr@...1296...>
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
 <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
 <Zc45NJAyJyLoTRee@...1296...>
 <8021c4ad-fca6-443c-9ce6-37c7e85bca81@...2181...>
 <6d8657f9-738f-44be-acbb-7e044d89e0f3@...2181...>
 <ZdNT18oVbBxUGDoU@...1296...>
 <911d560e-45b3-4029-a9c4-24d59c91c91e@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xDTJ0vW7VK23Bw+O"
Content-Disposition: inline
In-Reply-To: <911d560e-45b3-4029-a9c4-24d59c91c91e@...2181...>
Subject: Re: [Openvpn-devel] [S] Change in openvpn[master]: Minor fix to
 process_ip_header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net

--xDTJ0vW7VK23Bw+O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 19, 2024 at 02:23:08PM +0100, Antonio Quartulli wrote:
> On 19/02/2024 14:12, Gert Doering wrote:
> > Maybe that would be a more reasonable approach here... get rid of the
> > umbrella if(), and check individual bits inside.  It seems to be a
> > micro-optimization "skip this branch if we have no single feature activ=
e",
> > while at least MSSFIX is active by default.
>=20
> Technically we still retain the "speed up" when all features are disabled
> (i.e. remove this and this from the config and gain some Mbps)

"some Mbps" - maybe not... "a few kbit/s" sounds more like it :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xDTJ0vW7VK23Bw+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJl01xRAAoJEB2Cnv7KVigSRiQL/3M20G4crBNyCn53HbOd2WJ3
qxYHMaDKuQcizNUjKnF7AUuQQuL16mzbfU9Vl0bXkCSbASpTZPLJ2IP3MEfZTFxE
Aw/CCxjTb3jafWWNYvp66yTPdxBXXQXgI6qITRRK2jBBtpOxlY9LmQgDQqcH0qi5
KG+iqbdDmZYXBJd6PKrjqFkAhNzTom1ZBh/60PL9Mf2FeHb/a1gSOnexIAODoyv2
8ccr1rmK+4D4DHITaQNOY9waJeHVh53izY04Wxp63LgCPT+PPFx+3lsQd9IPJj3f
Mux2nk9KVco57V5wVmczhwT7khrOpvDlVKuAZ5KXYqM76FLDJln+FPxvSa0r8j8a
woxhj+NdhjngtxNP56KWdRI81U3UPBVYxUSnHsvJtNPV/5uycuz5y78nhEsf0DWO
p00bBoD3eAAy8Y55TpkB5OYsvCY74VcW7KjLwsFbr/ynx1mUDSDKqHxhE3XwUsME
/70PR8/DZZ7RD3UK2RhjtEnx9btceDlL+9S/Jl9nyg==
=KULU
-----END PGP SIGNATURE-----

--xDTJ0vW7VK23Bw+O--

