From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 21 Jan 2013 10:54:26 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90133FB458E5@...1436...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
	<1358411009-2350-4-git-send-email-steffan.karger@...1435...>
	<50FBEC82.2050503@...68...>
In-Reply-To: <50FBEC82.2050503@...68...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



> -----Original Message-----
> From: Matthias Andree [mailto:matthias.andree@...68...]
> Sent: zondag 20 januari 2013 14:09
> To: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH 3/3] PolarSSL-1.2 support
>=20
> Is there any important system where requiring PolarSSL >=3D 1.2.3 is not
> an option, besides "admin is too lazy or can't convince his manager
> that he needs to upgrade"?
>=20
> This #ifdef stuff makes the whole story a bit inconcise.  It might be
> suitable for 2.3.X, but not to base 2.4 or newer releases on.
>=20
> Barring that, I'd suggest to add stuff to fail the build with older
> PolarSSL versions and kill the PolarSSL < 1.2.3 code.  It would seem
> from the changelogs that PolarSSL 1.2.N (with N highest available) does
> away with certain design issues in earlier versions, so there is a
> compelling reason to upgrade.
>=20

I agree that it's annoying, but I wouldn't remove support for an existing, =
still secure version of PolarSSL in a dot-release. We could mark 1.1 as dep=
recated, and remove it in 2.4? For the moment, recent versions Debian (sid/=
wheezy) and Ubuntu (precise+) still contain 1.1, meaning that it's a nice s=
ervice for them to keep support for a while.

> (I was irritated anyways that the newest released OpenVPN version would
> not work with the newest stable PolarSSL version, and am foregoing the
> PolarSSL option on the FreeBSD port - we do have an up-to-date
> PolarSSL, so it wouldn't build.)
>=20

Unfortunately getting PolarSSL to work wasn't trivial due to some (necessar=
y) PolarSSL changes. We're still working on getting support patches for a n=
umber of the new features ready. Adding these patches to 2.3 during the RC =
phase would have caused to large a disruption for an RC.

PolarSSL targets a clean API, sometimes sacrificing the stability of the AP=
I in the process. While that is annoying in the short term, in the long ter=
m it helps to keep me sane as a developer.

Regards,
Adriaan

