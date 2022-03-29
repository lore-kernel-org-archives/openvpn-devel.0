Date: Tue, 29 Mar 2022 12:28:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkLfTY6hyQzy9QW7@...1296...>
References: <20220329053709.19462-1-info@...2666...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="69NRHJiE/nIKboes"
Content-Disposition: inline
In-Reply-To: <20220329053709.19462-1-info@...2666...>
Subject: Re: [Openvpn-devel] [PATCH] Enable usage of TLS groups not
 identified by a NID in OpenSSL 3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Baentsch <info@...2666...>
Cc: openvpn-devel@lists.sourceforge.net, Michael <57787676+baentsch@...2668...>

--69NRHJiE/nIKboes
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 29, 2022 at 07:37:09AM +0200, Michael Baentsch wrote:
> From: Michael <57787676+baentsch@...2243...>
>=20
> OpenSSL3 prefers to specify groups (including EC groups) with names
> instead of NID to allow also groups provided by providers.
> This commit also removes the mapping of secp256r1 to prime256v1 for
> the OpenSSL3 code path as OpenSSL 3.0 recognises secp256r1.1
> ---

If Arne is fine with the actual change, I think the commit message
is good to go.  The "From:" line (which is what git recorded as author)
is a bit weird - if you're fine with that, I'll use your e-mail From:
instead, also for the "signed-off-by:" header.

(The exact meaning of the signed-off-by: is a bit fuzzy to me - our
developer docs say "patch is ready to be applied", but they also say
"if it is missing, the value of From: is used".  Some other voices
interpret it as "yes, I've read the project guidelines and license,
and agree to them"...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--69NRHJiE/nIKboes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiQt9NAAoJEB2Cnv7KVigSbw4L/0pKtWFvv8fXDzdqLCjTc7lv
wiy+E5PdC7itOjsLpvJ2c+7IG4vtMjyekR4zwxKApwSDSjl7NzDvThsnlobNPaJv
1ikslWy7EWNL5RyMScT2CooyrLQ3rnw5VZdHstSosYS2Th52OTlWjPvErpfBAaSp
erBdi6SUVoHc315V2fhVQEx+6jNIXQBj35cqxdmsdUCPLyBnTt76Z/X9iMrqI9Q5
THil2Hf6gkEeteumgN4kHDGh34w9+nBIRDJWzCIoLf+QSu8cEXyFmpVHjE5UtU06
+AjDXp+rmmTnoNhNsO3s+ATCQOfRp7o4bseO+sKIE1irLz4B+zjRcnc+cV0WP06E
SVplJMHpA5v5Y4fTseBDv9m7u76PL0ZReKhhYdymBySVCKXuxhEKWAOTxQYjuPeP
N4IjoXTNgXhfrgRJmN915hatoGj9Gv37HFr2cou31+0ocXvzICn4t3+LBjOMUzj+
HHuFSyyNJTrlj06+0eEW1KrNT7mcC7hi8htISuTlXg==
=838u
-----END PGP SIGNATURE-----

--69NRHJiE/nIKboes--

