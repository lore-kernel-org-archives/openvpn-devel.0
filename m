Date: Wed, 28 Dec 2016 19:57:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161228185700.GJ78624@...1296...>
References: <20161228130721.683-1-list@...1798...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jNp2UUAAd0DeWbgM"
Content-Disposition: inline
In-Reply-To: <20161228130721.683-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] fix timeout in non-TLS mode with
 systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--jNp2UUAAd0DeWbgM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 28, 2016 at 02:07:21PM +0100, Christian Hesse wrote:
> @@ -73,6 +77,21 @@ tunnel_point_to_point(struct context *c)
>          return;
>      }
>=20=20
> +#ifdef ENABLE_SYSTEMD
> +    /* In non-TLS configuration we wait for the remote peer to connect
> +     * before issuing "Initialization Sequence Completed". So prevent to
> +     * time out by telling systemd service manager we are ready for now.
> +     * Status will be "Non-TLS mode, ready for now. Waiting for peer..."
> +     * and changes once the remote peer connects. */
> +    if (c->options.tls_client =3D=3D false
> +        && c->options.tls_server =3D=3D false)
> +    {
> +        sd_notifyf(0, "READY=3D1\n"
> +                   "STATUS=3DNon-TLS mode, ready for now. Waiting for pe=
er...\n"
> +                   "MAINPID=3D%lu", (unsigned long) getpid());
> +    }
> +#endif

We definitely need a better approach than "litter ENABLE_SYSTEMD all
over the code".

(Also, this is the wrong check anyway.  p2p mode can go along with
TLS just fine - what you need to check for is --server or --client,
which is something else than --tls-server / --tls-client)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jNp2UUAAd0DeWbgM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYZAr7AAoJEB2Cnv7KVigSyOQL/3lkkVefHHi41tlrlP1xdOSM
iFNMsDBfaLyq3HCGEGetSgLD0vFpx760mRNEm4RgSt6RbvKjrTHLc7+Y9D4CGsV6
XLJloUarf17Q2f1vnoQyjByqe1mcrPL3lFcbb0G8QjE6FmD/2eERJflfr8zTTTHN
tjUiXTSDfQ42haKAruDBxN9t/6jqo9I+YTyF2HiDexYbud84D7c9ZANtaaFSu48N
kRREKbK9c+IZUjd13l7fkVLE/3oPtwPDle9bxWc56Seg0vHiloTh8iHlZJShdph4
pBKjjTp3BtOtta+7LJMwYK2ZlsgxxUxlF0dPFi7LpccypmXNa0Zzg4LBJV9i5YFA
k2PnUzBvbIFvX0GU97GIYDUUGyCEiKERcSev4tdsmoSs7uHS0w/r/kEvF2Mqdx0o
JPM6iYlUJwbigzuIJtCnYxottfa9cyk/q6gwaUXFH0V96KpV9DubTWXEKkCy6NOU
1xmg8s056I9cvGCVppY+3wS6mIfHCyNSFMgmU88RoA==
=yPdN
-----END PGP SIGNATURE-----

--jNp2UUAAd0DeWbgM--

