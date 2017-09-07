Date: Thu, 7 Sep 2017 08:16:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170907061646.GD70062@...1296...>
References: <20170906235202.26551-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3x4RsK4fNlfzJGUz"
Content-Disposition: inline
In-Reply-To: <20170906235202.26551-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--3x4RsK4fNlfzJGUz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 01:52:02AM +0200, David Sommerseth wrote:
> @@ -18,6 +18,8 @@ DeviceAllow=3D/dev/net/tun rw
>  ProtectSystem=3Dtrue
>  ProtectHome=3Dtrue
>  KillMode=3Dprocess
> +RestartSec=3D5s
> +Restart=3Don-failure

Is there a way to get exponential backoff on restart?

Restarting is good, but if there is something faulty that leads to
"the process always dies right away", this can lead to very quickly
filling disks with not-so-useful logging...

(Otherwise, yes, restarting is good :-) )

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3x4RsK4fNlfzJGUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZsOROAAoJEB2Cnv7KVigSsrcL/0nAqPas+DxRqyi9XP1WDrPL
qLQT7xqsVQe4NITEi4uewBdmQF6pG4/45kTuy0eUCLHLjobMSVqDkRAN9r4E0i/j
8nfMabzPzZMhDxSaoAkhSe9v3RnQVFMPNCwJQY8zQVQ5gXlC2OFq5aFzepvo/ziw
sRE2pj2AIm9AcWl3CRcKMgy/u0UmPVKwTN8a+LqwtKozfHFjw7riEgMDZv3eofDI
WtNGQT6bmpNYxLgZeLCVSC6Pjc55cuvsu4Fy8ZvGghVPucmek1wNEAW2a0wzw/nh
5paF9t3E3seNhNjzyFaGiEHsbaGo8KIkMteKUgkDix6NiUPeM0bYKS2w7yh/kLjx
USMhtp4yb2/frj2EVHAIIUZt37QMZqmG4kr/nuX+3jv7TpysxUFO4ZhaWXf/3yBS
A11BA1R23awkv575m5DOuxYqfUi9i5WrlEdoSgk1YY/v1aB+2Wf5L0BaJJwVN6ZK
dBr84sOd3UjgDQF3wRQfb1ygP5Vrmug/bWc7Gt/9iA==
=URxc
-----END PGP SIGNATURE-----

--3x4RsK4fNlfzJGUz--

