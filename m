Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-2-christian.ehrhardt@...1808...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7da7d03b-7edc-f923-979f-4cd2e2b8849f@...2080...>
Date: Mon, 3 Sep 2018 10:38:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180829142715.417-2-christian.ehrhardt@...1808...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="yXdx2PgqPL1MLrudAEBLX59tWfm75jcld"
Subject: Re: [Openvpn-devel] [PATCH 1/2] systemd: extend
 CapabilityBoundingSet for auth_pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@...1808...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yXdx2PgqPL1MLrudAEBLX59tWfm75jcld
Content-Type: multipart/mixed; boundary="pxdHjSjnZflPyzqjtWhctmXb9A1jyr9Hf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Ehrhardt <christian.ehrhardt@...1808...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7da7d03b-7edc-f923-979f-4cd2e2b8849f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] systemd: extend CapabilityBoundingSet
 for auth_pam
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-2-christian.ehrhardt@...1808...>
In-Reply-To: <20180829142715.417-2-christian.ehrhardt@...1808...>

--pxdHjSjnZflPyzqjtWhctmXb9A1jyr9Hf
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29/08/18 16:27, Christian Ehrhardt wrote:
> Auth_pam will require audit writes or the connection will be rejected
> as the plugin fails to initialize like:
>   openvpn[1111]: sudo: unable to send audit message
>   openvpn[1111]: sudo: pam_open_session: System error
>   openvpn[1111]: sudo: policy plugin failed session initialization
>=20
> See links from https://community.openvpn.net/openvpn/ticket/918 for
> more.
>=20
> auth_pam is a common use case and capabilties for it should be allowed
> by the .service file.
>=20
> Fixes: #918
>=20
> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@...1808...>
> ---
>  distro/systemd/openvpn-server@...2221... | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/op=
envpn-server@...2221...
> index a8366a04..d1cc72cb 100644
> --- a/distro/systemd/openvpn-server@...2221...
> +++ b/distro/systemd/openvpn-server@...2221...
> @@ -11,7 +11,7 @@ Type=3Dnotify
>  PrivateTmp=3Dtrue
>  WorkingDirectory=3D/etc/openvpn/server
>  ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log -=
-status-version 2 --suppress-timestamps --config %i.conf
> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT=
_WRITE
>  LimitNPROC=3D10
>  DeviceAllow=3D/dev/null rw
>  DeviceAllow=3D/dev/net/tun rw
>=20

Acked-By: David Sommerseth <davids@...515...>

(The discussion is in a sub-thread, but keeping the ACK close to the patch =
for
simplicity)

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--pxdHjSjnZflPyzqjtWhctmXb9A1jyr9Hf--

--yXdx2PgqPL1MLrudAEBLX59tWfm75jcld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbjPL7AAoJEIbPlEyWcf3y+pQP/1yeo69ssB+f0StDHEHTa4SZ
312/6IjFjajKyixQ24EkZx4IZj1BhkUf1UP+HD8bVe7jum6OgiwHS6oD2xwHeZvo
7Hir7hVqOVzrJB6Dd0d43B6o6X9OWL96IBySE4PCQoAJ9/kmTyiKMGNqOX4JTXti
e0TwmyfZbGcJ901mIrBBQYskNRUUuWGjzdpTCdIUOwIKoXM7HItIKNgemhxc2Jwm
XMciToGgo8AUh9ODDBBKTn9qxBegjtOAcCW1Vn5teJTAUgYjwKsIqxcRVUoz44ic
xxQDC2PxnEvezOvQ0y2F+ZefgtHSQXn8izimAvFuLmhoC94tgR0/7kgqD/6Rl3Jt
N/ZGZo0N8XhdTj+WQB23B8LxGoDHkFh9NH7VGbjmQpXMcUBs7H9KSc4lLYOyFpJO
xInfHyR//uU8SeUE/e7DuT9qbjEUua88VHM4bPkSfXrPazt2cji2pWyjeqdDk9fs
YtfE1Xgx+vNkcgdDkOqHZMlE5Tpf0nANnBiVvcHyeiTJ4U/bHAP9wPJ2gLUbQCd/
UWLVrbm4E6xXdFrc8Oxgl1go436eE73J9wF9Fvl1h3Q9pK0YYHRaGxSUflG44avd
dP4I+4WtMwnLbHscRs0KVVnjXorBFo9r/BDV2Eldl2aSBdl7v1aJupA98R6D1MPf
ZUaJoaIaAy4Fz5NbURcN
=3wRI
-----END PGP SIGNATURE-----

--yXdx2PgqPL1MLrudAEBLX59tWfm75jcld--

