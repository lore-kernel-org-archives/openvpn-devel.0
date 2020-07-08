References: <20200707121615.15736-1-arne@...1227...>
 <20200707121615.15736-4-arne@...1227...>
 <20200708111510.GV1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4c73c51d-6828-57d0-ad24-78b86ecea07d@...1227...>
Date: Wed, 8 Jul 2020 15:15:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200708111510.GV1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qq1ZEhwirfVT4WTgPpGsWxc2qf44Pd9lo"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Cleanup: Remove unused code of old
 poor man's NCP.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qq1ZEhwirfVT4WTgPpGsWxc2qf44Pd9lo
Content-Type: multipart/mixed; boundary="qQilxkWa1yM6j88cKlhYGjLHtgaLOULb5"

--qQilxkWa1yM6j88cKlhYGjLHtgaLOULb5
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 08.07.20 um 13:15 schrieb Gert Doering:
> Hi,
>=20
> On Tue, Jul 07, 2020 at 02:16:14PM +0200, Arne Schwabe wrote:
>> Ever since the NCPv2 the ncp_get_best_cipher uses the global
>> options->ncp_enabled option and ignore the tls_session->ncp_enabled
>> option.
>=20
> For the record, this breaks "poor man's NCP" for big packets - tested
> with 2.3 client and 2.4 with "--ncp-disable".    Session is negotiated
> fine, key material is generated perfectly fine, both sides agree on
> ciphers, but if I do the "ping 3000 byte test" I get this on the
> server:
>=20
> 13:00 <@cron2> Jul  8 12:59:19 gentoo tun-udp-p2mp[30281]: cron2-freebsd-=
tc-amd64-23/2001:608:0:814::f000:21 TCP/UDP packet too large on write to [A=
F_INET6]2001:608:0:814::f000:21:35389 (tried=3D1544,max=3D1542)
>=20
> so it seems to get confused about frame size values.
>=20
> No --mtu-disc involved, no --anything-mtu configured on the server (=3D a=
ll
> on defaults).
>=20
> I do remember that this is scary stuff all intertwined...

Looks like our frame calculation for NCP is somewhat broken and this
change just exposed this bug better. This "fix" might work:


--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1986,6 +1986,12 @@ tls_session_update_crypto_params(struct
tls_session *session,
             options->keysize =3D 0;
         }
     }
+    else
+    {
+      /* Very hacky workaround and quick fix for our calculation
+       * not correct to avoid a regression */
+        return tls_session_generate_data_channel_keys(session);
+    }

     init_key_type(&session->opt->key_type, options->ciphername,
                   options->authname, options->keysize, true, true);


--qQilxkWa1yM6j88cKlhYGjLHtgaLOULb5--

--qq1ZEhwirfVT4WTgPpGsWxc2qf44Pd9lo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8FxwUACgkQFRhsZwKx
RFSEsw//ZJUXJVjxp5o1EInKO5s1OFVOTzggZhYi/UBGop2+fjhAringHZF91ABq
pgrcwyLjz7YLyLzd+zCEg6sgzuRCuPiSKaav1SWUWe3VuaFctsp1nsAh0SfhPnX3
IeXUTE9gNvBuwXFfMoqav6e5Vi6TxfkMltC6+Rl69zF98tmOXoOTiZmwmGLa/n4N
mx2vch60TYFc1mWVN33yTaZsZRNWhaRPYkxCirSFmNauxanWHwPVICCP96JHB1BC
PqmnJkJMDD3rkCLuULi2jMYmnCDqpiY4qKgahMn7M8cKKJHfghKY1cON3l5oo7t4
voNMdbWwHiL7ng8DJ0cm9H7MPDUnlYo62b76f7ekpMXwR6UBcFxDtov7j+xmDfon
pScMkYzbYPDLfs62oe0fVmppJdBy84SZnd8GqgTo9kTB7odYeJmZOCgXxenCXYC6
+bBFxvphFs9U4FENtLQ5SlJAhox0wy/gXy3RwcdvXKMlTuWsdsUMdecQKteGLWm8
WDIPfpJSpB6EtT1FnSb5MJ+7sJ0/MacQHP/FeMA/l9nUoq9gZrHnecMIbI0/ybk2
w0zTXeFkQiIQzwhFuUH0NSwBloUgyHoT6Vp6TJLVivzP33qWnkeEJ3JoXF1TXFib
VanGdq+4g9q2Tot9t1MaCAbGdum6FR8ld8xGtCeNxuQF/r3SK5k=
=iwZ0
-----END PGP SIGNATURE-----

--qq1ZEhwirfVT4WTgPpGsWxc2qf44Pd9lo--

