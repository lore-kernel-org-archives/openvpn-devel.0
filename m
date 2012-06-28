Message-ID: <4FECB181.4070105@...1114...>
Date: Thu, 28 Jun 2012 21:33:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FEC9804.2070805@...1227...>
In-Reply-To: <4FEC9804.2070805@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0FFD7A5067FE8E03982AC677"
Subject: Re: [Openvpn-devel] [PATCH] Fix --management-external-key in
	2.3alpha
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FFD7A5067FE8E03982AC677
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 28/06/12 19:44, Arne Schwabe wrote:
>=20
> Just a quick patch which fixes  --management-external-key, which I need
> for a cleaner way to access Android key store.
>=20

(please, don't attach the patches as attachments - rather send them as plai=
n text mail, easier to review and far easier for me to process these patche=
s afterwards when including them - git send-email is easy to set up, which =
does everything correct instantly)

I think I found a bug in your patch ...

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 367c1bc..a5f323d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2709,6 +2709,9 @@ options_postprocess_filechecks (struct options *optio=
ns)
   errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_fi=
le, R_OK, "--cert");
   errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_c=
erts_file, R_OK,
                              "--extra-certs");
+#ifdef MANAGMENT_EXTERNAL_KEY
+	if(!(options->management_flags | MF_EXTERNAL_KEY))
                                      ^^^
I believe this should the '|' should be '&' instead.  At least, it doesn't =
work so well when I don't change it.
What do you think?

My tests are:

   ./src/openvpn/openvpn --dev tun --tls-client --ca sample/sample-keys/ca.=
crt --cert sample/sample-keys/client.crt  --management 127.0.0.1 1234 --rem=
ote 127.0.0.1 --key non-existing-file
        (this should fail with a "file not found" error)

and

  ./src/openvpn/openvpn --dev tun --tls-client --ca sample/sample-keys/ca.c=
rt --cert sample/sample-keys/client.crt  --management 127.0.0.1 1234 --remo=
te 127.0.0.1 --key non-existing-file --management-external-key

But ... is it expected to pass --key if you use --management-external-key? =
  I probably don't know enough about this --management-external-key feature=
, so I might be wrong.


kind regards,

David Sommerseth


--------------enig0FFD7A5067FE8E03982AC677
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/ssYQACgkQDC186MBRfrqQEQCdGvsLz9jV5eU95W+Za036Xs+w
qnsAoIpnAor/w10jPgEYoosYa4InqGqt
=E/LC
-----END PGP SIGNATURE-----

--------------enig0FFD7A5067FE8E03982AC677--

