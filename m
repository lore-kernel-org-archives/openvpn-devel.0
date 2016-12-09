Date: Fri, 9 Dec 2016 22:46:46 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161209224646.1bc65baf@...1799...>
In-Reply-To: <98427851-6cfd-70e8-df2a-c646fa6087da@...2080...>
References: <20161209181303.20267-1-list@...1798...>
	<98427851-6cfd-70e8-df2a-c646fa6087da@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/61e=HGtNpXVbCwDWk6GoN0B";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] add more security features for
 systemd units
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

--Sig_/61e=HGtNpXVbCwDWk6GoN0B
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Fri, 2016/12/09 20:42:
> On 09/12/16 19:13, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > ProtectSystem=3Dstrict mounts the entire file system hierarchy read-onl=
y,
> > except for the API file system subtrees /dev, /proc and /sys (which can
> > be protected using PrivateDevices=3D, ProtectKernelTunables=3D,
> > ProtectControlGroups=3D).
> >=20
> > ProtectHome=3Dtrue makes the directories /home, /root and /run/user
> > inaccessible and empty for the process.=20=20
>=20
> Currently I don't think we can use ProtectedHome=3D .... as it is fully
> possible to save certificates and keys under $HOME/.cert on Fedora/RHEL
> (and clones).  There is even a specific SELinux label for files in that
> path, home_cert_t.

I know that NetworkManager and its openvpn plugin use $HOME/.cert/... But
openvpn is not started from systemd then. Do we have setups where openvpn
starts from systemd and reads certificates from $HOME?

ProtectHome=3Dread-only could help here... But I would still prefer
ProtectHome=3Dtrue.

BTW, setting can be overwritten with something like:

mkdir /etc/systemd/system/openvpn-client@...2210...
cat > /etc/systemd/system/openvpn-client@...2210.../protecthome.conf
<<EOF
[Service]
ProtectHome=3Dread-only
EOF

> For the others, I think they are more reasonable ... But I need to dig
> into the more murky details to be 100% they are safe for us.  This is
> anyhow something we need to postpone until after 2.4.0 ... I don't dare
> adding more things which may backfire in rc2, as we're on a strict
> schedule to manage the next Debian release.
>=20
> Once rc2 settles, I will start playing with this patch.

Agreed this is post-2.4.0 stuff. ;)

You can break this with something like:

status /etc/openvpn/client/status.log

in your configuration. Writing a status file
to /run/openvpn-{client,server}/status.log works, though. So the default
setups should be fine. Do we have any more cases where openvpn wants write
access for whatever?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/61e=HGtNpXVbCwDWk6GoN0B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhLJkYACgkQiUUh18yA
9HZtZQf/f+BfhpzPgWMWDQVypC2eBsNjQ/tbHcF6yGmUXiLc6Gw8M0TBqIZ7QBmN
x7jETeoiVKnCPumFd/tMK2RsrWlgC6jbgUtWEE7n2T7e3ydbpQF3oHBoxxGXC0kZ
WUwvY648RARIgsLKt6A5Dy8prfk21sw9hdcx2at0D4JM2Y3hRE0qz/yhmmqZ6WMm
nPIC+mxuAahpLCLgCOPaWmMa7kUySvhq/0KVKTJA00QWeHt1n6Tgl658Nm4C/xSu
SmG7HXvurpJJ48v5UjWvGvL75QLfFLE/exyQS/YRt6Qu5IzyVYm1W2rN+b6/k/Lh
yohBJFgkzq+bfQS1hWnIKYyURrvJgA==
=iPLk
-----END PGP SIGNATURE-----

--Sig_/61e=HGtNpXVbCwDWk6GoN0B--

