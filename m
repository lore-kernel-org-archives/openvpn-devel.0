Date: Tue, 28 Jun 2022 16:44:43 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <iiZepkuUFabbwD41g6PkJM_nweDSa_G6htcQgoYbTcgWcgoWyeCQpqT8kQ8g5sh87VLqfrpIW1V9DYWuB6sqzbnuB1aF7aOj4KQOoc-p7UA=@protonmail.com>
In-Reply-To: <CAKuzo_ix3cfKshpv4NQBfizA=g6JxVfVoUfvTrOHks_qQUKv2w@...278...>
References: <94AB30AF-0C34-4FEB-AFED-862E019793FC@...2679...>
 <CAKuzo_iQa0n=2z3GHzf5=mimL-8t_NXgJ=2+K4ojQD+8UUaq-Q@...278...>
 <9E388592-F025-4FD8-AE06-1ED0A9B43589@...2679...>
 <6e170cb2-e7b2-454e-8373-488715201517@...515...>
 <090369D8-2510-4CDB-9502-2A35BFA9A06F@...2679...>
 <_lh1UrJ7Cql9sFQswIPrS090v4LBzv0VyeQM9pK3VeV-j5eqEdJt6mEN7vFHPLGcrNPAVuJPVaAd-mpuipXublJ0_Mgiszlon0lMaW-g5SY=@protonmail.com>
 <G4aRsFZ6Y8HhGRWnand85pVPUfTYQSpoU4Mir-QOZisHQza0GBtnuqs58wFR7KkwvpqVyr_yRfKb_xnDBeC0jAc78qWHlOJ4fjPmhyee0b8=@protonmail.com>
 <i1O1BG6-8Rm4QWb5H71UFkZJtMHmc_8sNjC1OPxTct4pUj_jXhOQJEkogjzL3jJKS1TCKQITHXo2EAhWo4qC1v2kgH7f5lC2QJOIhVi1BLI=@protonmail.com>
 <CAKuzo_ix3cfKshpv4NQBfizA=g6JxVfVoUfvTrOHks_qQUKv2w@...278...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_ddDqwqUL7hcOMSzpRoO2pVX5JvaR45of5VTXDCvITow"
Subject: [Openvpn-devel] Fw: Re: [Openvpn-users] Problem with service on
 windows server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_ddDqwqUL7hcOMSzpRoO2pVX5JvaR45of5VTXDCvITow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


Forwarding to openvpn-devel, as requested.

CC'ing -users FTR.

------- Original Message -------
On Tuesday, June 28th, 2022 at 02:59, Selva Nair <selva.nair@...277...> wro=
te:


> Hi,
>
>
> >
> > the \\config-auto folder is only created if the 'openVPN Service' is
> > selected *manually* during installation.
>
>
> We need to install the automatic service without manual intervention. Is =
this also the behaviour on a fresh install instead of an update? The logic =
for installing the service was complicated from start because we wanted to =
detect when automatic service should be set to autostart, migrate configs i=
nto config-auto if required etc. during an update. But, in the process, it =
seems we have somehow ended up not installing it by default.
>
> Actually, always installing and even setting its startup to auto should b=
e safe now as we have a folder exclusively meant for auto-start ones (confi=
g-auto). This was not the case with older versions.
>
> Selva
>
>
>
> >
> > However, the 'Interactive-Service' *is* installed by default.
> >
> > This feels *needlessly* complicated.
> >
> > As a long-time Windows user, I am much more accustomed to turning optio=
ns
> > which I do not want OFF than I am turning options which I do want ON.
> >
> > Also, the installer does not have the customary:
> > * FULL (Default)
> > * Standard - This could be renamed 'CLIENT ONLY', if that is the intent=
ion ..
> > * Custom - Debugging ..
> > * Advertiser sponsored - This is common enough.
> >
> > which I would normally "hope" to see from a well behaved .msi installer.
> >
> > my2c
> >
> >
> >
> > ------- Original Message -------
> > On Monday, June 27th, 2022 at 22:49, tincantech <tincantech@...2282...>=
 wrote:
> >
> >
> > > Correction: 2.5.7-I602 not 2.5.5
> > >
> > > ------- Original Message -------
> > > On Monday, June 27th, 2022 at 22:35, tincantech via Openvpn-users ope=
nvpn-users@lists.sourceforge.net wrote:
> > >
> > >
> > >
> > > > Hi,
> > > >
> > > > I must point this out:
> > > >
> > > > <quote>
> > > >
> > > > > > > > I am setting up an OpenVPN server on a windows server for a
> > > > > > > > client, but ran into the problem where the openvpn service =
in
> > > > > > > > services doesn=E2=80=99t pick up the config files I placed =
into the
> > > > > > > > C:\Program Files\Openvpn\config folder.
> > > > > > > >
> > > > > > > > I can start the server from the command line just fine and =
also
> > > > > > > > from the openvpn-gui client, but when I start the openvpn s=
ervice
> > > > > > > > in services, the service starts and stays running, but the =
server
> > > > > > > > isn=E2=80=99t listening for incoming connections.
> > > >
> > > > </quote>
> > > >
> > > > It is not clear if the following point effects the OP, however ..
> > > >
> > > > The correct folder for auto-start is:
> > > > C:\Program Files\Openvpn\config-auto
> > > >
> > > > However, this directory and the README are not installed using 2.5.=
5-I602.
> > > >
> > > > This could be due to recent changes.
> > > >
> > > > --
> > >
> > >
> > > <cut>
> > -----BEGIN PGP SIGNATURE-----
> > Version: ProtonMail
> >
> > wsBzBAEBCAAGBQJiujWDACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
> > 9muQuJ2LYAf/Vh4nss7ejL0d+H6gCyxryTURfwoCPL60mfdqXYWuXIBHN19c
> > rB5lMr3oa9yzx3MU4ga6zBQzbXlwEw3F7wGVokqNDP1u+BSzjQIIYZsC2QBD
> > wdQMa2wdAIOpwwUml3DIyuz68vFmotXYp37DcafHt/tgTyWLNcaXrLSopM7K
> > ICwjKFrJ0Wd3Fz9eqMMBMeOimYFCMlqNbYqUWur3Ve9GNMuaou6pURo0X0+e
> > Gqmxo7QoGDPVYR59NXL2LQTO8mCAVRkd/9oAUbmpP7d/XuKMBPoPo/gcChx6
> > k1NGhNQR8DqsyK8vA/xFCIiBhg78NfgZMY2qk0Iq4heyGi+z5KZc0A=3D=3D
> > =3D2LbF
> > -----END PGP SIGNATURE-----
> > _______________________________________________
> > Openvpn-users mailing list
> > Openvpn-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-users
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJiuy/qACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ0E5ggArCAVCZwbhBOt6w+JsZj76USHN7enjWo0OG24qB+BzfOjhZOx
r14C1jCZmGydSS7MIjgYy0Toj3Al7N+6ZUwFwzm8h13x23KQIkyAd2lG2kIs
zxMRooKIpMmoE/HYF88RCSM5whsJjPVcHJ6VV8tkNnibCnUcTj5h4Mog6TRQ
EXv622Hen23tGjWUWU8GV2qXk/PRuDF31VEhs0+nQ7DitVolZe2NMawPdtVl
W0Z7KBuW2c7R5TjCqWeOAzjSqSocoF/SOAY19kSTDqN2zhvsyM1DOlUgI7UC
15elTAQj2Y9H/Jp8o2mlf93rCOS5f6uRhyQ8NYYp7wc4JB00gURl/w=3D=3D
=3D7ZIh
-----END PGP SIGNATURE-----

--b1_ddDqwqUL7hcOMSzpRoO2pVX5JvaR45of5VTXDCvITow
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_ddDqwqUL7hcOMSzpRoO2pVX5JvaR45of5VTXDCvITow
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAGBQJiuy/qACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec9muQuJ2xlgf/Vcws
/bkgX+8+X4p1uhCkOArZZjp9vLTgB4iBg9+p16fJr+7y9A4TLLfshT/NY6KFcUIT8vTMi1MH++O0
bq/cFWhRltdO8ALSh/1isfZbg3AphEwW33S89kZG9cyzhAtdUzxUtIumonSnQ+Ds3uTZQJ7tFS3m
3G6nZvjxG81LJCwetwE8cTWZRL7TPiY5Qq3m+yQX4KQVL6uZ5EycCdPkUl1Ka3cVTy1rjkscZaTm
SlUfCXPfIpE4w3v5fdltuhCh9W8ouJLkQU9nHMsUspsiiwLei5J5Ii8tnl7vqlCVGfTJJqemkAKa
JF0QrL333k3tIdlMSPUsN5JKQuJDhJencg==

--b1_ddDqwqUL7hcOMSzpRoO2pVX5JvaR45of5VTXDCvITow--


