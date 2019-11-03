Date: Sun, 3 Nov 2019 19:33:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191103183351.GD40538@...1296...>
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gdEaXsHGJIWX/19R"
Content-Disposition: inline
In-Reply-To: <20191103182443.GC40538@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--gdEaXsHGJIWX/19R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 03, 2019 at 07:24:43PM +0100, Gert Doering wrote:
> I tend to NAK this, on a number of reasons - we support arbitrary
> point-to-point links "since ever" if you do "topology p2p" (can be
> out of the same /31, or just arbitrary addresses on both ends), so
> I do not see why doing this in "topology subnet" would be beneficial.

I do see where you're coming from - the man page talks about depreciating
p2p, in which case you need to make sure topology subnet does /31s.

It might certainly be a useful excercise to investigate our current
ifconfig (etc) calls - in the 2.5 branch - and possibly get rid of all
the "broadcast" settings, across all platforms that do not need them.

Personally I've never understood why people are so keen on explicitly
configuring broadcast addresses everywhere (like in the network config
files, etc.) - the standard address can be computed and "just works"
(and on a tun interface, there are no link-layer broadcasts anyway, even=20
if we pretend it were differently).

The code was that way when David and I inherited the project, so I can't
explain *why* it is - but this might be the opportunity to kick out a bit
of needless garbage.


Out of curiosity: does the sitnl code path handle /31s?

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--gdEaXsHGJIWX/19R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdvx2PAAoJEB2Cnv7KVigSJiYMAJyQkK4+JrDnox4vGW4S4Ejj
pDQAwRTbirLXnma0o3qyq98nzpUATgoLvOXngp72iqD/HU0+vWmo8Cl1t6ka/Svs
AjTUAQQgYd+OEFCyCGlIn6d7Nazhh0vRuSBoE6wcyaPqKUk1vW/UHGYks+ay3amA
8P7smkiqYdc+XQWq/IyDFVAgIfbaU0hX/C9yF/ncCDCtsyzMIy+w5Qb7xZdSbvd1
gSml8Q38lR7tC/J0sYPoqDDI2agdP1ieRxkZwZ1osud4gPJeg+f1mAoz1vsC8EF3
O7OUNpr5SD+/SjWaCwIe/5Cn6J/LaYSk6oQvGimrApge//0svZXvVv6YzRPCKDbi
3mqyCU1sjhr4DapLGXmowLNXS0bp69HiN9O5zoKeV6vGwToXG2bL/zGfr8nK2c0E
ZiTjlRlQHvwYrZKVwFXfT3bD9USvrRbnKqmmX6TyZN/Y02+ALtYFh3PlgnFtuiYn
32gZ1YdEyZXiB1lsp2SXJHkUXWZU6kUqZaNmjV9W6g==
=zhdu
-----END PGP SIGNATURE-----

--gdEaXsHGJIWX/19R--

