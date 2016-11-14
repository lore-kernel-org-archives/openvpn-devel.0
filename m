References: <1479153490-6259-1-git-send-email-steffan@...1856...>
	<1479153967-6788-1-git-send-email-steffan@...1856...>
	<e95b939e-9486-eaf4-b351-4423c7dbfd33@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c4770934-7352-81ec-e4e8-2fd68e830380@...2080...>
Date: Mon, 14 Nov 2016 23:04:49 +0100
MIME-Version: 1.0
In-Reply-To: <e95b939e-9486-eaf4-b351-4423c7dbfd33@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Deprecate key-method 1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/11/16 22:35, David Sommerseth wrote:
> On 14/11/16 21:06, Steffan Karger wrote:
>> Key method 2 has been the default since OpenVPN 2.0, and is both=20
>> more functional and secure.  Also, key method 1 was only ever=20
>> supported for peer-to-peer connections (i.e. not for=20
>> client-server).
>=20
>> Let's get rid of some legacy and phase out key method 1.
>=20
>> v2: add Changes.rst entry, and update man page
>=20
>> Signed-off-by: Steffan Karger <steffan@...1856...> ---
>> Changes.rst | 7 +++++++ doc/openvpn.8         | 5 ++++-
>> src/openvpn/options.c | 6 ++++++ 3 files changed, 17
>> insertions(+), 1 deletion(-)
>=20
> I wanted to give this an ACK ... but I think we should just remove
> it all together as we seem to be in a broken state already.
>=20
> /usr/sbin/openvpn --dev tun --local 192.168.122.1 --lport 1194 \=20
> --remote 192.168.122.100 --rport 194 \ --secret
> ../../sample/sample-keys/ta.key 0 \ --ifconfig 10.8.0.10 10.8.0.20
> --verb 3 \ --key-method 1 Options error: Parameter key_method can
> only be specified in TLS-mode, i.e. where --tls-server or
> --tls-client is also specified. Use --help for more information.
>=20
> That is with /usr/sbin/openvpn --version: OpenVPN 2.3.11
> x86_64-redhat-linux-gnu [SSL (OpenSSL)] [LZO] [EPOLL] [PKCS11] [MH]
> [IPv6] built on May 10 2016
>=20
> So unless I messed up my simple and stupid static key p2p mode
> tunnel, this doesn't work at all with v2.3.  And git master haven't
> "fixed" this issue.
>=20
> If nobody noticed this by now, then nobody really uses
> --key-method.

Okay, so I was mistaken.  It is possible to use p2p mode with
- --tls-server/--tls-client without setting --mode server.  My prior
tests used --server and --client, which does not allow --key-method to
be set to anything but 2.

Running a test-case using the
sample/sample-config-files/loopback-{client,server} test configs
triggered the correct code path, and both --key-method 1 and 2 could
be tested properly.

So it's an ACK after all.  But I will slightly modify the warning +
Changes.rst to recommend not setting --key-method, as that will
currently default to --key-method 2.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKjUBAAoJEIbPlEyWcf3yRxAP/0HZCEWTN5pdOCb/gPJ/C9CM
71Br6fzMZqF/cm/rd6EhZwFd8PB+YTq7ppiRbKBHxLZFNT2ZpE94FvkzNGtWePW5
xJB0vcLjejDUcXAY04iuf9Ye1HPMq7y+GN6cGwMD9pO6Y6iqPKCuBKstkypT0XU7
80QuNoXXCzP9+DWcGnLlKWLC+CLlE6LKVycGCCl/mMppLHZwlCFNw7JKfr7GKYCT
FgMcPlqh9EGAcZOnxQIGWhxOUatWHcZm2vEdLhziCWA4MDO2ubeoEh6ol0+p1XcN
BirZHgvNmw/wq31GG38KGOiE7qMGjUHf9UR6WMwS/g+BzJCV8/0LcNCjXaTWDMKI
qlzb9nXXJ7a2CiigW1a3DmCXICBjwKimrzoRWM2GZQfwmrQP1joDnDJvG12ieHab
3yXh406Ky33/wnx/DG+om6OiJsGNV2Ygh8EtqyrKKIgHh7NzHVbESsTRSVfNOApn
aM0jwotj2s4rWgJ9Uf4PLp1p+7ujNegJ/9ZcFZLqLH7eAD+VsBGA8qg+KLNk0ldu
lnbCdyMO2mxZV+oVLVWAHODbJI/8OIxihNuV8lqzDyY4dS6HeOFnfePGKJJK9JI3
g/KWbLhPmWG4oQ4ocG04I9mbiJYHgfa6B1Xda1JwCiOexreoWW3rbFX5EqzjYx9L
fKgS3he37m8WQCHqD4SB
=3D8vbI
-----END PGP SIGNATURE-----

