Date: Wed, 29 Aug 2018 21:05:56 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20180829210556.0b76af25@...1799...>
In-Reply-To: <20180829142715.417-3-christian.ehrhardt@...1808...>
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-3-christian.ehrhardt@...1808...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0w.NYD5JFUkM26A+bLt.BVw"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 2/2] systemd: extend
 CapabilityBoundingSet for learn-address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@...1808...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/0w.NYD5JFUkM26A+bLt.BVw
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Christian Ehrhardt <christian.ehrhardt@...1808...> on Wed, 2018/08/29
16:27:
> It seems a not too uncommon case that learn-address needs to recycle
> dnsmasq - to do so it would need CAP_KILL.
>=20
> This was suggested on https://community.openvpn.net/openvpn/ticket/918
>=20
> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@...1808...>
> ---
>  distro/systemd/openvpn-server@...2221... | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/distro/systemd/openvpn-server@...2221...
> b/distro/systemd/openvpn-server@...2221... index d1cc72cb..edace213 100644
> --- a/distro/systemd/openvpn-server@...2221...
> +++ b/distro/systemd/openvpn-server@...2221...
> @@ -11,7 +11,7 @@ Type=3Dnotify
>  PrivateTmp=3Dtrue
>  WorkingDirectory=3D/etc/openvpn/server
>  ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log
> --status-version 2 --suppress-timestamps --config %i.conf
> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> CAP_AUDIT_WRITE +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN
> CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT
> CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_KILL LimitNPROC=3D10
> DeviceAllow=3D/dev/null rw DeviceAllow=3D/dev/net/tun rw

I do not like services being allowed to send signals to other processes. As
dnsmasq supports a dbus interface... How about using that? For example to
clear the dns cache of an instance started from Networkmanager:

dbus-send --system --print-reply \
--dest=3Dorg.freedesktop.NetworkManager.dnsmasq /uk/org/thekelleys/dnsmasq \
uk.org.thekelleys.ClearCache
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/0w.NYD5JFUkM26A+bLt.BVw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAluG7pQACgkQiUUh18yA
9HZB5Af/Q+gQ9tNym4WgGalvVLQZ+eAG8loa/UFCStcMDB0CrqUiakwUJeB5Gery
N7kWbpJ++G0SDApHbreBaE9Ky/yhvtxdtPS+AHjdP2qsFnF2CNDqgiQmoBPSxjBp
cJUem6AUH8EJMR1EonSkb0pjx2wDOQz2sGE3HgNzt/NUQCt5yzJLvepySBtDrk/0
3xCLu30ZuLMfHAaYyOd5o1KfzIGGuNWu6r4criRy+8+2UyjEqvRgwmYx2KIskxnO
rujk6ofYzw8F0Mlxz77epoFg1C1APHvRZNL9+9QHaTKpCQRGSSjwU7yo1xm4u2v1
8dMzU8hFrGe+mwa6rLB7tDiZZu6eGg==
=KI+A
-----END PGP SIGNATURE-----

--Sig_/0w.NYD5JFUkM26A+bLt.BVw--

