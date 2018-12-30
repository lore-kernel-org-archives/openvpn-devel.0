References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
Date: Mon, 31 Dec 2018 00:08:37 +0100
MIME-Version: 1.0
In-Reply-To: <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xWA41lDBtjeDy9aFPHn9oIG8ClZCZqoMq"
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
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
--xWA41lDBtjeDy9aFPHn9oIG8ClZCZqoMq
Content-Type: multipart/mixed; boundary="g8f01TPQkXgDuN3weorz5yXiCKy9pVKsN";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
In-Reply-To: <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>

--g8f01TPQkXgDuN3weorz5yXiCKy9pVKsN
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On 30/12/2018 13:37, Samuli Sepp=E4nen wrote:
> Il 28/12/18 16:21, tincanteksup ha scritto:
>> Hi,
>>
>> On 27/12/2018 18:11, Samuli Sepp=E4nen wrote:
>>> Hi,
>>>
>>> I've produced OpenVPN 2.4.6 packages for Ubuntu 18.04 and they're now
>>> available here:
>>>
>>> https://build.openvpn.net/downloads/temp/
>>>
>>> The Debian packaging files are taken from Ubuntu's own 18.04 openvpn
>>> package. They already used our openvpn-client@...1685... and
>>> openvpn-server@...1685... so I only need to make a few enhancements:
>>>
>>> - Restart active VPN client and server instances on upgrade
>>> - Stop activate VPN client and server instances on uninstall
>>>
>>> I also tested upgrading from Ubuntu's own openvpn package and that
>>> worked fine.
>>>
>>> Let me know if these packages work for you or if they don't. I'd like to
>>> get the to our official apt repositories soon.
>>>
>>
>> Successfully installed openvpn_2.4.6-bionic0_amd64.deb in Ubuntu 18.04,
>> tested newly installed openvpn-client@...1685... which worked correctly.
>=20
> Excellent! The openvpn-client@ and openvpn-server@ unit file templates
> "sneak in" to the Debian package from our upstream tarball. When looking
> at the Debian packaging files there's absolutely no sign of them. But
> they get installed and seem to work, including the tmpfiles configuration.
Those new service files are the ones everyone should use.  In our own
packaging, we should abandon the b0rken unit files from the old-days Debian
packages.  This is especially true for OpenVPN 2.4+ when built with
--enable-systemd (which should be mandatory on systemd systems!).  The reas=
on
is that it uses much better systemd integration which allows systemd to
understand better what openvpn is doing and when it fails.  Plus, the openv=
pn
process is being run with lesser privileges as well and for openvpn-server@=
 it
will even attempt to restart automatically the server instance if it dies
unexpectedly.

And IIRC, we managed to get the new unit files into the Debian openvpn 2.4
package.  And I just hope that they are updated with whatever we provide in
our tarballs; if not - it might be considered broken packaging.  The reason
you'll find the b0rken unit files in the upstream Debian packages is to not
break old existing installs.  Which is nice, just that it behaves broken
regardless.

So if anyone is in doubt ... UPGRADE to the openvpn-{server,client}@.service
unit files ASAP.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--g8f01TPQkXgDuN3weorz5yXiCKy9pVKsN--

--xWA41lDBtjeDy9aFPHn9oIG8ClZCZqoMq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcKU/9AAoJEIbPlEyWcf3y1sAP/3E+Y8S8ZksnencSmL6sIaIG
7laL17vR7qhyQ78HW7tUZx0qr5q90JRSkQ+W2zXsZbKIQaPWMFMp4OYIshq4MG1i
CcSVB4VQw3kZvK6xP7d2wNWIJRnVfDyfQQN9owEF+iBv05+Vufk1N6mM13NBHAQd
b6we7IBgoEB3x7sZ/ZUUqvlcNGRUnWN8EHRRj1jy4eLwE+Sy9mHR4cDJebPViSTu
TnT81RjV2Inqdgv8Y4XmBwx3QcOm8eal68TP/w0DBz4ZyeP0vvLhyj8ttLSFFu40
inmIgD4Xtnl38HyjVp7HTOmoyQgsvEPW8HoBN6//Vcj9Q/Nr58sCPLzjALiYT3Ia
T6uwrkjcUL9Ne8xoKWI/WeeeDn9qiVI0NTxyzAD/vUDcGsnHpw+mW+18Z+OiYfVI
ofkcNWH9QqsEsgtAlX2LlI9nnr5OLlxHv/kjIDNiXMbI7hrKhA/lLhjIdf7D9bTP
pqLeXVo0RNPXZ7djfXRY7dKS8C2FH8BzSkbNDKU8chgAp3rne3aAqwbVkBsvVKis
8bsm2Y3Rd9iAR9/np/sX718mBUaFxTuhLxD5ht3RpquT12pQP8wOguxJzIDRgb/Z
AGOu/RsFbG0OBU42iYZ1cNurMycthP2BFGq/eC5i2cth+cZODeMLOrP2lrGopjXe
QtuVVWdv4xXrSMoQaXR9
=raEA
-----END PGP SIGNATURE-----

--xWA41lDBtjeDy9aFPHn9oIG8ClZCZqoMq--

