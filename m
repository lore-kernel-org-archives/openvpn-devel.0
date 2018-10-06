References: <20181005135849.28718-1-steffan@...1856...>
 <CAFHpkQH_D9EOWCKk8oF8ijqw9=rHuVhSVYJssMe841fNQnrmhg@...278...>
 <20181005195929.GO962@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c8521752-6807-f2ef-7138-b5f066701b90@...1856...>
Date: Sat, 6 Oct 2018 09:54:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181005195929.GO962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QnXtO6bWGd6x6bcSqm9n21yJkBkqYrc96"
Subject: Re: [Openvpn-devel] [PATCH (2.4)] Fix --disable-crypto build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QnXtO6bWGd6x6bcSqm9n21yJkBkqYrc96
Content-Type: multipart/mixed; boundary="CdgfH6MBHkTkpDPcBLUBR202vSct2SdYQ";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <c8521752-6807-f2ef-7138-b5f066701b90@...1856...>
Subject: Re: [Openvpn-devel] [PATCH (2.4)] Fix --disable-crypto build
References: <20181005135849.28718-1-steffan@...1856...>
 <CAFHpkQH_D9EOWCKk8oF8ijqw9=rHuVhSVYJssMe841fNQnrmhg@...278...>
 <20181005195929.GO962@...1296...>
In-Reply-To: <20181005195929.GO962@...1296...>

--CdgfH6MBHkTkpDPcBLUBR202vSct2SdYQ
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05-10-18 21:59, Gert Doering wrote:
> On Fri, Oct 05, 2018 at 08:23:28PM +0500, ???????? ?????????????? wrote:
>> shall we add "--disable-crypto" to travis-ci matrix in 2.4 branch ?
>=20
> I'm afraid this will bite us a few more times, so "yes, please"

We already have this - that's how I noticed it was broken :)

-Steffan


--CdgfH6MBHkTkpDPcBLUBR202vSct2SdYQ--

--QnXtO6bWGd6x6bcSqm9n21yJkBkqYrc96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEED9EpzGW9WeE8Ifd8mALKPQB+0ogFAlu4akEACgkQmALKPQB+
0oj39wf/Q0FS7TQFJQIsyVDtkoIOWpv82iWyA6lkBGf1nSj2v+c419FnyV8DdNVG
S8/W1YMxkUMTNT+sv9rjVw766UtKyi3EGgbW93PfEyczzZaeuoi1rC45LzJmMqi7
XX6NTe8r3J/xA6wEpfobJ/C2knvsM40bV04WOjO+V0zm1b7dyQm5Ps4FTvZ8ykSr
qPHZzYQ0NawYAyroVbWXNS0ag+aB6lkXyePpXNqiRELdMua++hzDyFGTHH996VYk
CTwoqwSFxjIecTSDk2vEcxIN+cp4AUjzpMY8XuAJpl0Jg16x1hnWhwbLorjzF9Vu
gkSYdA2Cusw6sJ9ggKk4I3wZ4JYRkQ==
=0dv+
-----END PGP SIGNATURE-----

--QnXtO6bWGd6x6bcSqm9n21yJkBkqYrc96--

