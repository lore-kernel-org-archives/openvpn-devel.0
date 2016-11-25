Date: Fri, 25 Nov 2016 16:27:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161125152710.GA81859@...1296...>
References: <CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
	<CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
	<CAFHpkQF7GtEXhaHBm-nRmHzcQ-cpsJt=MZM+h_1N4kORHERKeA@...278...>
	<CAKuzo_iEXGcuf1tt9zQh8dh42C5BX=jNoROXc_=CV-sOsBsW1w@...278...>
	<CAFHpkQFdVasrVF6Km_AnVwZL7QhGy1AAJAEeyiX7yt_Cq7R2Nw@...278...>
	<CAKuzo_h3kza0fftPTOc9vqhy=sSgTuOZXL=qzV3e29yhhpY8mA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <CAKuzo_h3kza0fftPTOc9vqhy=sSgTuOZXL=qzV3e29yhhpY8mA@...278...>
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 25, 2016 at 09:38:31AM -0500, Selva Nair wrote:
> Even if the GUI cjecks HKLM and HKCU, toggling the option will not work as
> the GUI cannot reset HKLM values. We do not want to be requiring admin
> rights to run the GUI and that option becomes "readonly" for the user if
> startup is set in HKLM.

How do other packagages handle "this is the system default, but users
can change their own setting"?  (So the admin could say "I want this started
by default, for all users" and individual users can uncheck this "leave
me alone!")

Just thinking aloud, no idea how much effort this is, and whether it's
a useful consideration in the first place.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYOFhNAAoJEB2Cnv7KVigSy5EL/2n3MCkEafodoxnoAIHuCNME
UYGWo72mj66KoRnF4d8oIt7tU9GPHV7lRf9R8feBd1oMIKDThYnbgzEjlCMx8tHx
AmKLLtGfGONje4jG4H0HlqY8MfBCxn6A6FFBVbOPBeLsgdy5R/lxZy3C4dC1iYpQ
yejkqE8ppZRTkZaFU3+N9qr/W5IU744UbGdBG/3DQqs6cZaWU7j9cO42BiyFSWx/
kNu7HuSrDntky4hS5NBfKloRep7JzOGzEIgRWUXor+fEy5BRUrdgKt8uojWOf/OZ
L2RLJseCQeLtkRkqzCJV/vig2Z35FIeBv0z99ALa8CEb28XpWZoEQGNED8R6lM8V
lcs8m0/+6mC21UqptWa1M2LnBcy64sl8hiSWGKeiqs+ewRnEHvLBYS1hclLs8m5i
00OmLZcL7VnQgesjHfqTRH2gKQ/0mx/nEDl8Ih5qJ5/Vk/t8ZnJvixoJe1yANt6y
ra/TfN0Mx4I/B9zzScYlUazoBxjrSArIoUIKYlRBQQ==
=AX8W
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

