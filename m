Date: Mon, 13 Jul 2020 20:03:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713180354.GG1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-13-arne@...1227...>
 <20200713154047.GF1431@...1296...>
 <ce539842-b9d1-5cb1-eb56-f4a85533bbac@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fWbCzqdhbLvOF42u"
Content-Disposition: inline
In-Reply-To: <ce539842-b9d1-5cb1-eb56-f4a85533bbac@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 13/14] client-connect: Implement
 deferred connect support for plugin API v2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--fWbCzqdhbLvOF42u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 13, 2020 at 06:08:04PM +0200, Arne Schwabe wrote:
> >> The V2 API is simpler than the V1 API since there is no passing of
> >> data via files. This also means that with the current API the V2 API
> >> cannot support async notify via files. Adding a file just for async
> >> notify seems very hacky and when needed we should implement a better
> >> option when async is needed for the plugin V2 API.
> >=20
> > I'm not sure I understand a word of this.
> >=20
> > If we want async cc, we should do it in the V2 API - and since v2 plugin
> > async auth works just fine (with file), I wonder why it is hard for=20
> > async cc?  Because we cannot pass back the returned config data?
>=20
> Not async cc. That works fine. But async notification via file notify
> does not work without a file being involved.
>=20
> v1 API returns config and status via files.
>=20
> v2 returns status as return value (OPENVPN_PLUGIN_FUNC_SUCCESS,
> OPENVPN_PLUGIN_FUNC_DEFERRED...) and the config file via memory in
> plugin_return. So no file involved and no way to use inotify

For the record, I'm all confused between lowercase and uppercase
v1, v2, v3 - there is "openvpn_plugin_func_v1()"... "openvpn_plugin_func_v3=
",
and for CLIENT_CONNECT - *only!* - there is also CLIENT_CONNECT_V2,
but not for, like, async auth.

So, I withdraw what I said here, and need to read this stuff up in
more detail.  Look at existing client-connect plugins... (if there
are any).  Etc.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fWbCzqdhbLvOF42u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDKIKAAoJEB2Cnv7KVigSAa0L/0t49CS4Qy1Fk2oW6VurCwyo
squqxzoBMHx+LTheGo9qdYQkdq4uXYbzcPWXYVcHXfWdvkoYBaRVAeC9WyZnDqyK
D85WuiDt3TxtxlpC+FGdnoxPNWrqcFlJH6jeE8tZ7tLRq7EU1j/4e8CzCkb0LOd9
z+7tGPFPR5s+4kwmRz+MLyMzse3ym+fh+w2vurZ5uT9wtpHImeNUASs8QWnMOVra
Lwdx6+1dmvPoPDcyIzz4LN/ztX9bU2FbXV0/QppxkGCwCV4KfOqdcuZ/piJDtNGC
7jmzM+rK777nmv+NnKxuAPsSUy5hDVZzZYhF2dA1ENe6ouc5uNuS86d/xf/3hYFm
ImwvlpyKsq5YziGMRYFC3gHUu8FMUP0SZZrqTmCLEZEriScBV15kjyxmPwZk+ha5
xUdWvaFb3emPnM052AmdmmE2s7SjYEw64kC/YOtXWF7lzOlt3HV5WCj3fT60DbRw
yQkYu5XXEzVy2CYH7jKSuwosYFWZ5SJ7Ir5VRGfbTg==
=aT3B
-----END PGP SIGNATURE-----

--fWbCzqdhbLvOF42u--

