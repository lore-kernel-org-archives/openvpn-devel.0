Message-ID: <5390E0F0.5000808@...1114...>
Date: Thu, 05 Jun 2014 23:28:16 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20140526132551.GA9011@...1915...>
In-Reply-To: <20140526132551.GA9011@...1915...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5q0fG39dnDUJI8IfUW0sTEwN2J5q0RjHJ"
Subject: Re: [Openvpn-devel] [PATCH] Add support for Keying Material
 Exporter [RFC 5705]
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel Kubec <niel@...1898...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5q0fG39dnDUJI8IfUW0sTEwN2J5q0RjHJ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 26/05/14 15:25, Daniel Kubec wrote:
> Add support for TLS Keying Material Exporters [RFC 5705].
>=20=20=20=20=20
> Keying Material Exporter allow additional keying material to be derived f=
rom existing TLS channel.=20
> This exported keying material can then be used for a variety of purposes.
>=20

I've finally had some time to compile and test this patch, as well as
done code review of it.  First of all, this is a good piece of work!  So
I'm looking forward to see this arrive in OpenVPN.  It will surely help
develop more advanced authentication methods.

The patch does indeed work quite well.  It provides a tls_binding_key
environment variable to plugins which supports OPENVPN_PLUGIN_TLS_FINAL.

Here's my comments, thoughts and questions ...

a) Is the intention that this tls_binding_key variable should only be
   available when the OPENVPN_PLUGIN_TLS_FINAL plugin call happens?

   Currently tls_binding_key is available to all plugin *and* script
   calls happening after OPENVPN_PLUGIN_TLS_FINAL has been called.  But
   *only* after a plugin which supports this hook has run.  This smells
   like a bug.

   I think I would recommend this variable only to available for the
   OPENVPN_PLUGIN_TLS_FINAL call.  Which means you would need to add a
   setenv_del() in ssl.c:key_method_2_read() after plugin_call().

   I spotted tls_binding_key in the following hooks (using a slightly
   modified sample-plugin/log/log.c)

   Client side: PLUGIN_IPCHANGE, PLUGIN_UP, PLUGIN_ROUTE_UP
                and PLUGIN_ROUTE_DOWN

   Server side: PLUGIN_IPCHANGE, PLUGIN_CLIENT_CONNECT_V2*,
                PLUGIN_LEARN_ADDRESS and PLUGIN_CLIENT_DISCONNECT

                * Most likely PLUGIN_CLIENT_CONNECT too

   I also tried to use a --client-connect script which dumps 'printenv'
   to a file.  When this log.so plug-in was used, I saw tls_binding_key
   in the printenv dump.  It was not present when log.so was not loaded.


b) Should there be a script-hook available for this as well?

   This could make it possible to make authentication methods using
   scripts as an addition to plug-ins written in C.  Just thinking
   aloud, not saying it's a requirement.


c) The format is currently like this:
             0f3d5a7a 8b78fe1a 8a7fce61 58b89142
   Is this format the preferred formatting?

   Other formats are available through format_hex_ex().  I would
   probably recommend another separator than space, if a separator is
   needed at all.


d) This patch breaks building with PolarSSL.

   ssl.o: In function `key_method_2_read':
   ~/openvpn.git/src/openvpn/ssl.c:2129: undefined reference to
   `key_state_export_keying_material'
   collect2: error: ld returned 1 exit status

   I would recommend to add a kind of wrapper function in
   ssl_polarssl.c which adds this function.  Not sure if it would
   be appropriate to do an ASSERT(0) or do something else.  Maybe it
   should not set anything, just return without adding the
   tls_binding_key.  When plug-ins expecting to see this fails to find
   this variable, it will the plug-in's responsibility to not explode.


e) Has this patch been tested with OpenSSL < 1.0.1?

   Is it really needed with the #else ASSERT(0); ?


f) It should be stated better in the man page that this feature depends
   on a plug-in supporting OPENVPN_PLUGIN_TLS_FINAL.


--=20
kind regards,

David Sommerseth


--5q0fG39dnDUJI8IfUW0sTEwN2J5q0RjHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOQ4PAACgkQDC186MBRfrp5HQCfafQb7jLAM8zq9U1LxXLPEEUR
vZ0An0eqZlZ5LZZVSSDXjHwHUT397Xqa
=4aTz
-----END PGP SIGNATURE-----

--5q0fG39dnDUJI8IfUW0sTEwN2J5q0RjHJ--

