Date: Thu, 14 Dec 2017 16:44:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171214154408.GA69387@...1296...>
References: <1513246897-28171-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MTFjS3R2zZZVGaSB"
Content-Disposition: inline
In-Reply-To: <1513246897-28171-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] ssl_openssl: fix compiler warning by
 removing getbio() wrapper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--MTFjS3R2zZZVGaSB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 14, 2017 at 11:21:37AM +0100, Steffan Karger wrote:
> -    if (!ret)
> -    {
> -        crypto_msg(M_FATAL, "Error creating %s BIO", desc);
> -    }

I'm not sure how likely these are going to fail, but the crypto_msg()
had the benefit of actually telling us what the underlying library
returned as error code...

If this won't ever happen except under very exceptional conditions, it
won't matter much, though.

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--MTFjS3R2zZZVGaSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaMpxIAAoJEB2Cnv7KVigSWcwL/3Lem+T1cyTm2rglgY+N41gE
IT5c1fLGpz4/97OwqMEKPiCoXynzz4c2m1wYE+g6y6Unm4yGwzA0o7n+vse25eyH
mupZPqNOI4HN4DTptxio0Ulzvg3npGJtQGDRtBdv00QQq/jpPzOu3a97r1lHwLKG
+mPc8vMMQMPQZVvxPpidS0dIBLEe5CwtZQRYmV/sVgk1LKjJS82fuw3mDBJPVPHV
xSlI04cNt7fx5lSrWZu5utEWAUWSx6MqrDSpKmJaLdOSnWKiMbkppUtAAIwrIr+L
JQ47vzQAvnhdP0n0u6rHnDTtpq8fj8JRrCuHoHMXjL/g/To1sIQb/x+GRNi25qDV
/ww4JlkEOY6W3fcqpcgzEjJMswZuOMHeinzEPhKhzWFFU+OeMi5UvS8j0eI2/Pfh
/+P0TkFaV93463LrxJuwLswdZTYO9D32fQam1Cuts0MBSWdxs8HC3UnIut4zpacH
enjQakNbShbFuB3fuNPfV3MPVEZZEP2hZ9LvBZLtQA==
=JBKA
-----END PGP SIGNATURE-----

--MTFjS3R2zZZVGaSB--

