References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <70cd8ca0-08a0-bc06-2d35-c665fb85b57f@...2080...>
Date: Wed, 19 Oct 2016 15:29:49 +0200
MIME-Version: 1.0
In-Reply-To: <53533abe-e85d-7a42-49ce-465267997724@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Mmjba9F9wEIXRMaRp1oEt34X587Urgx2M"
Subject: Re: [Openvpn-devel] Proper location for user-specific OpenVPN
 configuration files used by OpenVPN-GUI?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mmjba9F9wEIXRMaRp1oEt34X587Urgx2M
Content-Type: multipart/mixed; boundary="nTlRVIaG0O2WmFOAik48aeBluflQPo2T5";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <70cd8ca0-08a0-bc06-2d35-c665fb85b57f@...2080...>
Subject: Re: [Openvpn-devel] Proper location for user-specific OpenVPN
	configuration files used by OpenVPN-GUI?
References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
In-Reply-To: <53533abe-e85d-7a42-49ce-465267997724@...515...>

--nTlRVIaG0O2WmFOAik48aeBluflQPo2T5
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On 19/10/16 15:04, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> While preparing OpenVPN 2.4-alpha1 release the discussion about=20
> user-specific OpenVPN configuration files came up again. To give some=20
> background, OpenVPN-GUI can now delegate privileged operations (e.g.=20
> route adding) to the OpenVPN Interactive Service. This means that normal=
=20
> users are now able to launch OpenVPN connections without having admin=20
> privileges. On top of that, users can now store OpenVPN configuration=20
> files in their home directory, under %USERPROFILE%\OpenVPN\config[*].=20
> The rationale for this directory choice was discussed here:
>=20
> <https://github.com/OpenVPN/openvpn-gui/pull/18#issuecomment-190138431>
>=20
> Three directory alternatives have been proposed:
>=20
> %USERPROFILE%\OpenVPN\config (current approach)
> %APPDATA%\OpenVPN\config
> %USERPROFILE%\.openvpn\config

"When in Rome do as the Romans" ....

which means the .openvpn approach is just plain silly in Windows.
Hidden files and directories start on *nix with a dot/punctuation in the
file/dir name; Windows does not do that as it uses separate attributes
tackling this.

%APPDATA% is what I belive the majority of Windows applications uses today.

The %USERPROFILE% approach I'm a bit more reluctant to.

But this is just my personal opinions, coming from a person who haven't
really used Windows in 15 years++.  But I do think consistency with what
others do is of a bigger value.  Windows users who tinkle with slightly
more advanced stuff knows where to find %APPDATA%.  Windows users who
don't know that should most likely not even enter the OpenVPN config
directory at all.


That's my 2cents to the shed painting funding ...


--=20
kind regards,

David Sommerseth


--nTlRVIaG0O2WmFOAik48aeBluflQPo2T5--

--Mmjba9F9wEIXRMaRp1oEt34X587Urgx2M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYB3VNAAoJEIbPlEyWcf3y4qcP/j31MUL30BaQprX74IBTRXnT
VPYefTJN9vmgEh2mUEBF05coIUHMGiZyV4jsKmVZT4YH471ifrvmMrjxEKaHaKqr
eqP5igz4Ufwj6igd3YbqFE4wI0xh09kK6ygxDJbWang+v+U4ARoxwyCTOXGKQBjF
LPgUWRpnL5TctUFqeoXCtugwwSM8oe06BM6nsmeR1upb5UvMV4vBM5xPEwiAroqk
DRzlgW/0/pVXweI54+NciwnB953pV6vBaGsf2xorprKd5WDvc2MsPgM6ziH6euQg
PI7zEuoaz0UVgpCLW0MenvFCaDTQVTKAMYu+TVTi/0c9hm9D+5phOfFHEYQsYK2d
eLTYw2krxzKIO5nP/4U+XYjrr/Zu7NepJTpYXYsphNGr9UJ7LJRxkP1vfJD3K8r/
KFywoCiKDqRihFqFHE4maF4ajp+GoX/AjYMrqC5mGhCOmFlcCH93jNmAPLxWbfYT
eZwgb1Tc1nAiARPRxQp1gl5g9XDALaXeRuqF+ZfI+hDmjSxRMWIurwrVZMgQqoDB
VG6HVigXqGC9t4vtdetCRtAP5U0Rd0tpNIkJrcQJMoR3v6L2veyehJIo2cs/6VzV
ObZ+9cioXDR737RQjPfZglJRvxGDEzq5sTtzSUMQwRnwWPVPncklYd6bN5mhyOPr
LQoHhTpMfQvT7zwQLGcs
=gAXw
-----END PGP SIGNATURE-----

--Mmjba9F9wEIXRMaRp1oEt34X587Urgx2M--

