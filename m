Date: Tue, 15 Sep 2015 12:13:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150915101355.GN34798@...1296...>
References: <1442309019-7586-1-git-send-email-arne@...1227...>
	<1442309019-7586-2-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JjpRhe3EFs1LrwYV"
Content-Disposition: inline
In-Reply-To: <1442309019-7586-2-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/8] Add support for requesting the fd
 again to rebind to the next interface.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--JjpRhe3EFs1LrwYV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 15, 2015 at 11:23:32AM +0200, Arne Schwabe wrote:
> This not done via android_control since calling management from managemen=
t leads to an infinitive loop

I'm all willing to ACK it, but...

> +#ifdef TARGET_ANDROID
> +int
> +managmenet_callback_network_change (void *arg)
       ^^^
... the typo police is not letting me.

> @@ -3173,6 +3204,9 @@ init_management_callback_p2p (struct context *c)
>        cb.show_net =3D management_show_net_callback;
>        cb.proxy_cmd =3D management_callback_proxy_cmd;
>        cb.remote_cmd =3D management_callback_remote_cmd;
> +#ifdef TARGET_ANDROID
> +      cb.network_change =3D managmenet_callback_network_change;
> +#endif

As the typo is here as well, it *works*, but we should still fix it :)

All the rest looks good, as in "only touches Android anyway, but even
there, pointer accesses are checked, in line with the rest, etc."

Shall I just fix the typo, ACK and commit, or do you want to re-send?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JjpRhe3EFs1LrwYV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVffvYqkuBuNlUUl1AQKg7wP+KgEJ8xJe6lYikKaQpCwqDQxnkfUe1r82
TI0QpQU3NN43FiJEXLRySeVlDAGCFLDUoXnimoO33lWA1YkhWmDqNQ6MNtUdio7a
1YMXnGawIFpdTQc4DyzGJrG+W55Bml8OOp3NC0VHBjcDnKrWA/sh7tHmCRKCDFMm
sro0y3ejUA0=
=XHP7
-----END PGP SIGNATURE-----

--JjpRhe3EFs1LrwYV--

