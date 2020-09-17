Date: Thu, 17 Sep 2020 10:57:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200917085739.GQ976@...1296...>
References: <20200916141755.1923-1-themiron@...2010...>
 <202009170845.08H8juQs054283@...2054...>
 <000001d68cd0$2dd4df20$897e9d60$@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <000001d68cd0$2dd4df20$897e9d60$@yandex-team.ru>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix fatal error at
 switching remotes (#629)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: 'Gert Doering' <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 17, 2020 at 01:54:39PM +0500, Vladislav Grishenko wrote:
> Thank you a lot,

Not needed :-)

> That "fix for real" is about persist_remote_ip option as far as I
> understand, not directly related to this fatal assert fix.

Well, the whole preresolve / connection entry "complex" is old and
has been extended and updated a few times, and your SVR patch also
builds on top of that.  At some point, refactoring is needed...

(We have some other thing to consider which is even more intrusive -=20
when we reconnect to a different IP address, and that new IP address
is currently routed into the tunnel, we need to set up new /32 host
routes before moving to a new server can work... openvpn3, as I
understand, sets up "all host routes!" right at the start, but that
might or might not be the best solution either)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfYyUCAAoJEB2Cnv7KVigS2DkMAIk26S8PUkoDu6Urp903o2m9
rCF9OYUAKDYQlgrimNAHf2nwv3d6SfvpHQlLsIZLOAKna3vJ5j7OMr+Gsvf69DoM
03VJe1sFIyvws7WISNXLJ3KNv0ugMY/zAZeX24UC7WDpS57FKuSG+n6XAKeFFNWG
+4e6s6ZhXSAmwldv29LXtI7cBYQDxKoXlPltKTZVC9IQR7zBRQmAuDhhtxrK1I3B
VkpzfAG0SvrllYgc1kMNDkmkc5HvYMyFm10gGtWJWHZkdO/sG6AyT/Sm/AzXXAh+
ook4nQkmLmj2d9z9MqbhYNPbYZCDSaQb/k0q+tvTnwh21mvpnpEkViy32t5502MN
DRXdpkB0x0jEP2d1CNkDGmbhsyVsChTBa9mOJBIvp7eJLjPqSgoBQTiO/ckioJc9
w1q7Nm0FaQqgKm2kIUpQp5Tz+53ubsLfF6K13OXLocEBmuIdFAXNouCfC9AfYTKs
yZ+Sc+D7egmSqiD1PnYMo7qaUcVyfzQ50MDalAcrQQ==
=fqTu
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--

