From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] openvpn-2.0.2-pkcs11-20050916.patch
In-Reply-To: <432B0855.1060909@...277...>
Message-ID: <Pine.LNX.4.58.0509161845180.11393@...41...>
References: <432B0855.1060909@...277...>
MIME-Version: 1.0
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
Date: Fri Sep 16 18:06:15 2005
Content-Type: TEXT/PLAIN; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 16 Sep 2005, Alon Bar-Lev wrote:

> Hello,
>=20
> This patch enabled openvpn to access PKCS#11 cryptographic=20
> tokens. It is based on the opensc patch that was post earlier=20
> (http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D1114521&gro=
up_id=3D48978&atid=3D454721).
>=20
> This patch was tested under Linux. It was tested with the=20
> opensc PKCS#11 provider. Since it works with the opensc=20
> provider and PKCS#11 standard is much more common, it makes=20
> the opensc patch obsolete.
>=20
> This patch compiles under Windows, but was not tested. I will=20
> be glad if somebody will test it under Windows as well.
>=20
> The patch is capable of using several PKCS#11 providers at the=20
> same time.
>=20
> The following options were added:
> --pkcs11-providers provider... - Loads a PKCS#11 provider.
> --pkcs11-sign-mode - How to perform signature.
> --pkcs11-slot-type - Specifies how to locate correct slot.
> --pkcs11-slot - Specifies slot name.
> --pkcs11-id-type - Specifies how to find certificate and key.
> --pkcs11-id - Specifies certificate and key name.
>=20
> The following standalone options were added:
> --show-pkcs11-slots - Displays PKCS#11 slots.
> --show-pkcs11-objects - Displays PKCS#11 token contents.
>=20
> Please refer to man page for further information.
>=20
> The patch can be found at=20
> http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D1293066&grou=
p_id=3D48978&atid=3D454721
>=20
> Any comments/suggestions will be gladly accepted=20
> (mailto:alon.barlev@...277...).
>=20
> Special thanks to:
> Fritz Elfert - Wrote the original patch.
> Iv=C3=A1n Casado Ruiz - Updated original patch and helped in=20
> testing this one.

Alon,

This is very cool -- thanks for your efforts.  We'll plan on merging this=20
when the 2.1 beta series starts up.  I'd like to see some Windows testing=20
as well.

If you don't mind, it would also be great if you could put together a
mini-HOWTO on this.

A few details:

Make sure that it's easy to #ifdef out all the pkcs11 stuff, if people=20
don't want it.  This is mostly for the embedded crowd who are very=20
sensitive to code size.  Notice how almost every major non-core option can=
=20
be selectively disabled:

./configure --help | grep disable

Try to add a ./configure --disable-pkcs11 option as well.

The other minor point is that you add a pkcs11 directory in the source
distribution root for some header files.  Right now, just to stay
consistent with the current source file organization, could you keep those
files in the root as well?  (I know that means that you'll end up with two
pkcs11.h files, so one would need to be renamed)

Thanks,
James


