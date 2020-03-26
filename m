References: <20200323171156.295122f1@...1661...>
 <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
 <20200324143702.21f24651@...1265...>
 <efc9cf7f-7b20-bb92-08a1-8364490c579f@...1227...>
 <20200325193545.59c59983@...1661...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <11b7bb4a-992e-b97e-9d4e-47ff3e9b1c57@...1227...>
Date: Thu, 26 Mar 2020 09:38:49 +0100
MIME-Version: 1.0
In-Reply-To: <20200325193545.59c59983@...1661...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mPIU74F4oPIjwFa3sKXyQYomTcdwQ7tQX"
Subject: Re: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Kress <lists@...1660...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mPIU74F4oPIjwFa3sKXyQYomTcdwQ7tQX
Content-Type: multipart/mixed; boundary="TJzTUQyPODzaPAr8yJXPgN41eyqO5WyaN"

--TJzTUQyPODzaPAr8yJXPgN41eyqO5WyaN
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 25.03.20 um 19:35 schrieb Michael Kress:
> Hello Arne,
>=20
> Am Wed, 25 Mar 2020 12:50:34 +0100
> schrieb Arne Schwabe <arne@...1227...>:
>>> 1) Do you run automated tests of the OpenVPN code on any build
>>> server?=20
>>>
>>> 2) If that is the case, is there any test with a version, where=20
>>>    -DVERIFY_ALIGNMENT is enabled?
>>>
>>
>> I never heard of this option and Google does not want to spit
>> something out for me for that.
>=20
> That's a #define in the OpenVPN code, for example in
> src/openvpn/buffer.h line 943 ;-)


Ah those. Yeah. They are mainly for performance reasons and debugging I
think. If I also remember correctly buffer.h is written in a way that
these *not* actually trigger unaligned access on a CPU level. But for
performance reason having the uint8_t array aligned to 4bytes will make
everything faster.

> RPI? You mean Raspberry PI?
> Maybe on this machine the problem is not a problem. We also use OpenVPN
> 2.4.7 on a ARMv7, and there is no obvious problem, just on the old
> ARMv4.
>=20
> Finding all problematic places in the code will still be difficult.

I just look at my RPI and it seems that it has the option you mentioned
set by default:

cat /proc/cpu/alignment
User:		0
System:		0 (  (null))
Skipped:	0
Half:		0
Word:		0
DWord:		0
Multi:		0
User faults:	2 (fixup)

But it seems that the CPU will not trap but instead allows unaligned
memory access.

But since your machine requires that and setting it to 3 (warn+fixup)
actually fixes the problem you should get warning messages in your dmesg
output about the points in the code that trigger this problem.

And you could then either lookup with gdb what the IP addresse are
pointing to in the the code or (probably easier) configure the kernel to
send a SIGBUS, so you get a core image and can print a backtrace. If we
know what code path actually trigger the unaligned access we can take a
look and figure out what is wrong. Gert has done similar things with the
sparc machines in the past.

Arne


--TJzTUQyPODzaPAr8yJXPgN41eyqO5WyaN--

--mPIU74F4oPIjwFa3sKXyQYomTcdwQ7tQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl58ahkACgkQFRhsZwKx
RFTydQ//fZMlDfM8ooOqYob8lce90xYq38bMaNsMjGWRY2jkIGwVXhNVTKcNDoO6
QXL8dZgNhN+fx5uOKgHMAV47ix/75nui9ahr3Dbpo6BXHOvtRCuKtORiD+Fvhh7U
qyD0v7t0N5eh5jhHPtvsdB1vD9NkR0N6aJ/gWpRCfEq3wTmpJmwTtD5vH+PXczb6
Kh1omzxp+DWDn/ykXxhY1UxLkCBVKWrQt0KJJyRWbqAlzLQ8EKh/I08+7bmZi53I
Mvu7BPM252NDn+qn6NPWMUtCJNqUeqm8+oeLOEQkQAUhF19fQnuDwd2BhY1cRLFA
ntC3ihMsVn8PX+2Zud8833IiFMkV4pI9mxcFmaRCbu7w+uMO/MPbPqE6dNKeNCXC
xH6ayoK71D2lbW+XVwrnwhYg0YsIShwZEv2qo/or0MmbvxF4nkwF0DwnrB8lp2Pi
1mLF4NfkLTXNWV8ObXWccUtJhxj4pRUvKT7StaWSRFoHqEK0WrSjVkiZEY0hymnd
ATN+v2h/YbXq6w/ndhSEHnVI4ZX8UYRxJenX90++YK4p4TjdENHGNacOth2VIHqV
4Xb1fbNNNCPjkUvXM6ggIMD/+BOviZ7Bz+5Kx/LJfSxjbTRUewooSpESgH4/5qJL
RvQD1pbRs3CGNzfzUkbB9UoTKUXUaCZQr9Bxro5VIe8HP1Q9XCM=
=CTxQ
-----END PGP SIGNATURE-----

--mPIU74F4oPIjwFa3sKXyQYomTcdwQ7tQX--

