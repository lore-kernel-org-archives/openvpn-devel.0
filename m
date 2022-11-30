Date: Wed, 30 Nov 2022 08:54:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4cMNNyutpyu48/1@...1296...>
References: <20221129180534.657529-1-selva.nair@...277...>
 <20221129183756.657793-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SssuZHjnB1/0K1Cp"
Content-Disposition: inline
In-Reply-To: <20221129183756.657793-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] pull-filter: ignore leading "spaces"
 in option names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--SssuZHjnB1/0K1Cp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 29, 2022 at 01:37:56PM -0500, selva.nair@...277... wrote:
> +    /* skip leading spaces matching the behaviour of parse_line */
> +    while(*line && space(*line))

I would actually prefer to use isspace(*line) here.  space() is one
of our special magic functions which returns true on 0-byte *or* isspace(),
which won't have an effect (as *line checks for the 0 already), but will
just confuse readers wrt "how is space() different from isspace()?".

Can you send a v3?  ACK on that :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SssuZHjnB1/0K1Cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhww0AAoJEB2Cnv7KVigSXxEMAJvc2DeowuK5KtCayNiCZpqa
sppxMzgfBOdTMO9pDwtfOGC02BAWVDAqaQ934lvvSs90iOnMZmGBp0zEhOe3laHU
yVpfZNQbvFSGzGJSoO0oL/LBzDAlbxLt3JFbSe0zhVw1IFEB9cj/ytXvFMHBBBKe
GCqLJiUhJmSqgjKHJiALgDw4mGMpwEbevwY5XqZGQKNxrGT4zKqaYax4neHYjxJG
x4nYIS+carKIPHmq4gsSYtA43SNoOzOqYUglr/PyJBb1yyZyo5vn+nRXqlaOsjWP
a/7sLDeLpX8xmLkeFBJtw/PmPeKMu9s66TVIa/97en+cfB8DX66v9d5HE68ETlj+
70WQ3NHihxVTiPcM7p0BE6Pvo2/lJIFCndX65Fu6gYAQtT3zbKh/X1ZxFl6lNVKl
LEsOQDSZumGljj7kbRQI1QXP4Qk6JsMvC2xvtNJLI8gPXUgQhAtyr1M8e0nqt59m
CSEGjmAXdDCtR9hAXwFQNZNlNER+BcqYd0Ub0QBadQ==
=pYdH
-----END PGP SIGNATURE-----

--SssuZHjnB1/0K1Cp--

