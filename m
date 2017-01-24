References: <e6deb9e1-bc10-9085-4ebe-31e8e34b8b6b@...2080...>
	<20170124143947.27385-1-list@...1798...>
	<20170124143947.27385-2-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <96ca252f-f676-154e-1df4-0f97951e1f4e@...2080...>
Date: Tue, 24 Jan 2017 16:15:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170124143947.27385-2-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ROsD8G23n63BEmm5bP5wpS9UwJenlD7Wi"
Subject: Re: [Openvpn-devel] [PATCH 2/2] do not race on RuntimeDirectory
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ROsD8G23n63BEmm5bP5wpS9UwJenlD7Wi
Content-Type: multipart/mixed; boundary="3LcbN26xgck4rJ3CEdGE3bQMoNKXfPlh8";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>
Message-ID: <96ca252f-f676-154e-1df4-0f97951e1f4e@...2080...>
Subject: Re: [PATCH 2/2] do not race on RuntimeDirectory
References: <e6deb9e1-bc10-9085-4ebe-31e8e34b8b6b@...2080...>
	<20170124143947.27385-1-list@...1798...>
	<20170124143947.27385-2-list@...1798...>
In-Reply-To: <20170124143947.27385-2-list@...1798...>

--3LcbN26xgck4rJ3CEdGE3bQMoNKXfPlh8
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


Just a very quick comment before I review and test the rest.

On 24/01/17 15:39, Christian Hesse wrote:
[...snip...]
> @@ -20,6 +21,11 @@ if ENABLE_SYSTEMD
>  systemdunit_DATA =3D \
>  	openvpn-client@...1685... \
>  	openvpn-server@...1685...
> +tmpfiles_DATA =3D \
> +	tmpfiles-openvpn.conf
> +
> +install-data-hook:
> +	mv $(DESTDIR)$(tmpfilesdir)/tmpfiles-openvpn.conf $(DESTDIR)$(tmpfilesd=
ir)/openvpn.conf
>  endif

Disregard my earlier comment about subdir.  I think this is reasonable
enough in this case.  It was not as hacky as I feared.  And this
Makefile.am is so small and isolated it is good enough for me.

If we regret it later on, it's an easy move into a tmpfiles.d subdir.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--3LcbN26xgck4rJ3CEdGE3bQMoNKXfPlh8--

--ROsD8G23n63BEmm5bP5wpS9UwJenlD7Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYh2+TAAoJEIbPlEyWcf3y4gIP/jFz4fTDlhPcPXOsK+BSW2Qw
RpXzkvq/coh6CZUvlPfBcUFbMpzJkcaObG0EN6OfdCYNB0KfbN1pqrOIJoa/X13K
y7e0E9vbHzekj4um6BnS8GVqtNw23mUVvElQXcdXhGdVUzWBxTsNxViha0dfPyGw
XY00ai9p3+4RKxq/8CdPXy13IsO1gPCwLgTbiXkiUmxP02Z7p4vDtuLYpDFLcLNy
WXArXawZQN2u0iVVlXH2znMDCFMe8o73bAcSd4i2oB2Hy2KRxqPhIqS3fR8elPwo
7/nvJVgkArV3tuUcFX+OuZqHCOh9N1LwJGZSdS2di2rLFkAbZ2wNJkgR61tLElK+
+3UstTddDR9RLv13szuHecyEg7omEmzhCVtHP5FWRp1uKa07rksEYFO2OW3EI867
F7fvWL+YNh6kkFWB6SyeOsSueJRLNjoNtdHVxNvzE2UKgWtMWkDN02Awt8lKERRP
qq798TkJnwPoRf2X6XjBPJ2aTyDKgBwaRjMCEzM7YFPhjJR+ZRvoTHh5QvaDK0/A
U5HUCkYSQO5CcUraJAZ7DLiZ5JGrxJkIy9+SRnoIRR3iobUiyU+OJJkn8sMORm7p
Fqer9UhcGaGQET9wzkqsw3josKCjYL9Vz3FEh1bTh6oOa9tB8wtl7dV2KnUb/PAd
R5JL71xG0Sa3xOPYU+Ln
=1JmW
-----END PGP SIGNATURE-----

--ROsD8G23n63BEmm5bP5wpS9UwJenlD7Wi--

