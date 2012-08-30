Date: Thu, 30 Aug 2012 22:41:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120830204155.GC18296@...1296...>
References: <1344938249-5885-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DheUW4aQn8WJk6WR"
Content-Disposition: inline
In-Reply-To: <1344938249-5885-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] [RFC] Add a warning if
	--client-config-dir related config file cannot be opened
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--DheUW4aQn8WJk6WR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 14, 2012 at 11:57:29AM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> This will cause a warning in the log file if --client-config-dir
> is configured but OpenVPN could not find or open the config file
> for the connecting client.
>=20
> OpenVPN will also look for a file named 'DEFAULT' if a file named
> as the client's TLS Common Name cannot be found.  To hide this
> warning above, create an empty 'DEFAULT' file inside the
>  --client-config-dir.

I'm not sure I'm happy with that...

> +              else
> +                {
> +                  msg (M_WARN, "[CCD] Failed to import client config for=
 '%s'",
> +                       tls_common_name (mi->context.c2.tls_multi, false)=
);
> +                }

I find the actual message confusing - what does "fail to *import*" mean?

Naive interpretation is "the file could be found, but there's something
broken with it, like 'syntax errors' or such, but we won't tell you!".

So the message should be more along the lines of:

    msg (M_WARN, "[CCD] client config file for '%s' not found (or unreadabl=
e), and no DEFAULT file either",


(while it would be even more nice to show *why* it fails, I can see that
this is a bit tricky to get done without quite some extra code to remember
test results, etc.)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DheUW4aQn8WJk6WR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCUAwUBUD/QE6kuBuNlUUl1AQIXOgP4sXXTvSmQdsA9bYWlbDU+E6iMhfkUQFHQ
98PMKBtvZpzkq3HmSQOjtw+5Iy+uayXb2BFk9Ca+7HD7JFnHPPKnF3aaNl35ZfQ6
nzzYFqyFMvPOfsbAXks1Q62F1pn3rN5MfrgKu1XkreshyFEb/VB5pUcrrtY83cXM
N0k87VxTyw==
=abOY
-----END PGP SIGNATURE-----

--DheUW4aQn8WJk6WR--

