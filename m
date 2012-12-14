Date: Fri, 14 Dec 2012 19:14:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121214181427.GP22465@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sFNR5OHn/l1pSZHT"
Content-Disposition: inline
Subject: [Openvpn-devel] coverity issue 1 - MF_EXTERNAL_KEY
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--sFNR5OHn/l1pSZHT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

coverity scanned our source tree, found 201 false positives (they do not
like msg(M_ERR, ...), msg(M_WARN, ...) or msg(M_FATAL, ...)), and 3
actual code confusions.

I'm now going to post them here, to elicit comments on whether we want=20
to fix 'em, just ignore 'em, or throw out all the source and go drink
a beer.

Issue #1:  "logical dead code", in options.c, line 2277:

          else
            {
              notnull (options->cert_file, "certificate file (--cert) or PK=
CS#12 file (--pkcs12)");
#ifdef MANAGMENT_EXTERNAL_KEY
          if (!options->management_flags & MF_EXTERNAL_KEY)
#endif
              notnull (options->priv_key_file, "private key file (--key) or=
 PKCS#12 file (--pkcs12)");
            }

... if I read this right, this is "operator precedence again", and there
need to be brackets=20

#ifdef MANAGMENT_EXTERNAL_KEY
          if (! (options->management_flags & MF_EXTERNAL_KEY) )
#endif


... Arne?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sFNR5OHn/l1pSZHT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUMtsg6kuBuNlUUl1AQI7xAQAvRayrQsa05T53DtAanigcC3WIVMesHUk
+Wo5RmHnpDRV2V5u3jDBASoLqUCwB25RlEeEgnTN9smfOo5C4pEaI6U6mCPZrNM0
JnreZdZqM+9VwTjrHQAL8368KQusdh+RFZg3hkerNRh9OZeovdpd1zH5zq8nNYMv
Hht8NqHyXr0=
=YPuX
-----END PGP SIGNATURE-----

--sFNR5OHn/l1pSZHT--

