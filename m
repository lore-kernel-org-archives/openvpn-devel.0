Date: Fri, 27 Aug 2010 17:41:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100827154134.GD10703@...1296...>
References: <1282859040-25837-1-git-send-email-dazo@...384...>
	<1282859040-25837-4-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <1282859040-25837-4-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Added a simple plug-in
	demonstrating the v3 plug-in API.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 26, 2010 at 11:44:00PM +0200, David Sommerseth wrote:
> This plug-in can be tested by running an OpenVPN server like this:
>=20
>  # ./openvpn --plugin plugin/examples/log_v3.so --dev tun \
>              --server 192.168.240.0 255.255.255.0 --ca sample-keys/ca.crt=
 \
>              --cert sample-keys/server.crt --key sample-keys/server.key \
>              --dh sample-keys/dh1024.pem
>=20
> The client can be started like this:
>=20
>  # ./openvpn --client --remote localhost --ca sample-keys/ca.crt \
>              --cert sample-keys/client.crt --key sample-keys/client.key \
>              --dev tun --nobind --auth-user-pass

You might want to take a look at t_cltsrv.sh and build a "make check" test
script from there...  verifying the expected output in the logfile after
the test run...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTHfcrqkuBuNlUUl1AQIeZQP/dTCeFjR80ImiCAMaz0RF+74321fjlmZc
zcm5qrhq/triw+XGxlwT4HkOhlbVvNwB6INFL7A8sKjqMkiZgFT1RD8ualMvD5S2
GvdkJ9iDZLyPA5B1ybxctdZYXYlOz/TMzkzvX3k6kKxkfbZ6DAh/nsAIn/VKij3e
3NuQans+zDM=
=SzgZ
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--

