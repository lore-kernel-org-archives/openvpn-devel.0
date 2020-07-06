Date: Mon, 6 Jul 2020 20:43:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200706184313.GJ1431@...1296...>
References: <20200706163516.11390-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="X/k4lTRLJEUoQv64"
Content-Disposition: inline
In-Reply-To: <20200706163516.11390-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Remember if we have seen a push
 request without async push
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--X/k4lTRLJEUoQv64
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 06, 2020 at 06:35:15PM +0200, Arne Schwabe wrote:
> The logic if we already have seen a push request is still
> correct/useful without async push. I am not entirely sure if also
> deferred management authentication can trigger this code path but
> it should be able to. The other benefit is removing a number of
> ifdefs.

NAK.

In combination with async-auth (plugin) this triggers some sort of
key inconsistency - the client does get the proper PUSH_REPLY, but=20
key state is kaput

...
Jul  6 20:41:30 gentoo openvpn[32657]: PLUGIN AUTH-PAM: BACKGROUND: name ma=
tch found, query/match-string ['Password: ', 'Password:'] =3D 'PASSWORD'
Jul  6 20:41:30 gentoo openvpn[32657]: PLUGIN AUTH-PAM: BACKGROUND: fbsd-tc=
-master: deferred auth: PAM succeeded
Jul  6 20:41:32 gentoo tun-udp-p2mp-global-authpam[31884]: MULTI_sva: pool =
returned IPv4=3D194.97.145.74, IPv6=3D2001:608:3:814::1000
Jul  6 20:41:32 gentoo tun-udp-p2mp-global-authpam[31884]: OPTIONS IMPORT: =
reading client specific options from: /tmp/openvpn_cc_6f7cfcfda4cb5ecf13666=
85a7270c804.tmp
Jul  6 20:41:32 gentoo tun-udp-p2mp-global-authpam[31884]: SENT CONTROL [cr=
on2-freebsd-tc-amd64]: 'PUSH_REPLY,route 10.204.0.0 255.255.0.0,route-ipv6 =
fd00:abcd:204::/48,tun-ipv6,route-gateway 194.97.145.73,topology subnet,pin=
g 10,ping-restart 30,compress lz4,ifconfig-ipv6 2001:608:3:814::1000/64 200=
1:608:3:814::1,ifconfig 194.97.145.74 255.255.255.248,peer-id 0,cipher AES-=
256-GCM' (status=3D1)
Jul  6 20:41:32 gentoo tun-udp-p2mp-global-authpam[31884]: cron2-freebsd-tc=
-amd64/2001:608:0:814::f000:21 PUSH: Received control message: 'PUSH_REQUES=
T'
Jul  6 20:41:32 gentoo tun-udp-p2mp-global-authpam[31884]: cron2-freebsd-tc=
-amd64/2001:608:0:814::f000:21 Key [AF_INET6]2001:608:0:814::f000:21:51780 =
[0] not initialized (yet), dropping packet.


"I was about to ACK-and-merge this"... but it's reproduceable, async auth
(without --async-push) is broken with this patch.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--X/k4lTRLJEUoQv64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGbBAEBAgAGBQJfA3DBAAoJEB2Cnv7KVigSgsIL9RNCLwqsTwG11x/IPRrSy16f
e1UEsKKrzmAM6kX6xcqnLLfFrdJi3p2HGpNBMbKJmJsQXe/6aYX+Mz9hk+lrT4oW
t0CauB3teN6MxV7r1p8oWnYlpXsmeH4ZYlZDBvwe+tVWkH649481TRijVJM/xLlu
MAuHBou9D31FBBHCloSOSdZEDKHU5iPjVSL6fqBaI3u/PAwUH+ZU07egHx+iUs7b
mOhW2s4Nx8JyaGCjFnjHVTEHzmKPbQLw6Dgn3R00XXx6HMkAn4VQbCVaQpWKmras
5QzIBE8ByjiwrsZkfYocuwnpTLjxiO++JuhgqvY1Qa4IwuoeHmcI25oBANJ2wWV0
xGfoXvNCJpRDPnscPgeSxZrEVDfPBlAz+DKUPlvEqcMBaFniFK7n+qFrDEhw59sb
JgPu/QFDfO0ghUxCyo7JzVTo6Qf+JE5CI0KxWUhs8XFqHKExUxXsTUlZkMtB4+b0
souG4bTKNZzM/SMLcxtWb9Xa/9Oz/2ZdlUMz5ogq
=1/V8
-----END PGP SIGNATURE-----

--X/k4lTRLJEUoQv64--

