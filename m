From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
Subject: Re: [Openvpn-devel] bugfix: SuSE handling in openvpn.spec
References: <41B0734E.3010105@...324...>
In-Reply-To: <41B0734E.3010105@...324...>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2787966.mOEkpn6O27";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412031618.44206@...187...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Dec  3 06:19:03 2004
To: openvpn-devel@lists.sourceforge.net
Cc: Stefan Engel <mail@...324...>, openvpn-users@lists.sourceforge.net

--nextPart2787966.mOEkpn6O27
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2004 12 03 (Friday) 16:08, Stefan Engel wrote:
> Hi,
>=20
> there is a minor bug in openvpn.spec (v2.0_beta19). In the %files
> section the init script is always taken from /etc/rc.d/init.d instead
> of /etc/init.d in case of a SuSE distribution. This results in an
> rpm build error on SuSE systems.
>=20
> The appended patch should fix this.
>=20
> Regards,
>=20
> Stefan
>=20
    What gives "rpm --eval '%{_initrddir}'" on SuSE? In RH/FC it gives
"/etc/rc.d/init.d", which I use in my .spec file:
--- cut ---
# to fix later: '--program-suffix 2' is optional, so use * here
%{_initrddir}/*
--- cut ---
    instead of
--- cut ---
/etc/rc.d/init.d/%{name}
--- cut ---
    If accepted then
--- cut ---
%if "%{VENDOR}" =3D=3D "SuSE"
%__install -c -d -m 755 %{buildroot}/etc/init.d
%__install -c -m 755 suse/%{name}.init %{buildroot}/etc/init.d/%{name}
%else
%__install -c -d -m 755 %{buildroot}/etc/rc.d/init.d
%__install -c -m 755 sample-scripts/%{name}.init %{buildroot}/etc/rc.d/init=
.d/%{name}
%endif
--- cut ---
    should be just one line :)
--- cut ---
%__install -c -d -m 755 %{buildroot}%{_initrddir}
--- cut ---

--=20
Regards,
  Doncho N. Gunchev    Registered Linux User #291323 at counter.li.org
  GPG-Key-ID: 1024D/DA454F79                        http://pgp.mit.edu
  Key fingerprint =3D 684F 688B C508 C609 0371  5E0F A089 CB15 DA45 4F79

--nextPart2787966.mOEkpn6O27
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBsHXEoInLFdpFT3kRAmNeAKDKGgvFJtmhWzJUp5BRrAs8Ro4WwwCdFR9u
qMpxM+tM0WvAN4DzvlKy83s=
=poJA
-----END PGP SIGNATURE-----

--nextPart2787966.mOEkpn6O27--

