Date: Mon, 27 Sep 2021 10:23:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YVF/e864QZw0Yu5x@...1296...>
References: <20210827144807.27004-1-a@...2181...>
 <202109131003.18DA3WwQ023112@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dhoJXvz2JoQ2Br/s"
Content-Disposition: inline
In-Reply-To: <202109131003.18DA3WwQ023112@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: configure: search also for
 rst2{man, html}.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--dhoJXvz2JoQ2Br/s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 13, 2021 at 12:03:32PM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> Tested on my gentoo system, which had symlinks rst2html -> rst2html.py
> (etc) previously, to work around our configure inflexibility.  This=20
> now becomes...
[..]
> Your patch has been applied to the master branch.
>=20
> commit b61d1988582feb2e1ed1cf9e62700f484e0bc150

As discussed at the last community meeting, this is non-intrusive and
useful to have in the upcoming 2.5 release.

commit 55f83c9448bf4c36d0b4801e0ef6277952b4a605 (HEAD -> release/2.5)
Author: Antonio Quartulli <a@...2181...>
Date:   Fri Aug 27 16:48:07 2021 +0200

    configure: search also for rst2{man, html}.py
...
    (cherry picked from commit b61d1988582feb2e1ed1cf9e62700f484e0bc150)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dhoJXvz2JoQ2Br/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhUX97AAoJEB2Cnv7KVigSe94L/03zlOUZA02ni8NF7GfIhVEM
k7wrE5YLDSGyOmopbPJC/VnAo6V9fu76yP1tO0BW7pB9WcYFtqD6wTZYCh41FBjM
O6MRubo/gdldq5HObLJ8Miky6PG1eUMUBAe3k9jz7bO21VoRuCCfi3mtImr/KGx9
OhBmitNwwig+Q3qkh4WZD8eLiqxw0E2VDZHCd6bxG5luGnlEMo3u8E/u9Dm8S3Sv
L86/5I+tfPoDSsKMqHic/2Y7WvRrjnaivlpgUF0lk6m6xV3gUwSvoj2EcNmpJo2F
gw+qmgLrvlhlJO5/vwNVC6ALW7NBXR7NHgEZ5jp2yqGCz8cuU1Rq+qfQtYn/ww/o
rdNE5EWlwebRQ+BruvP+7XCqr90QoT9EDrY4V41C4BpxTKrPUxyJRSBp08v4mCok
rZKVOsXvohGEcjDNw1tYY1BsLe1VuYV2Sm+lvvqaR1JuZeTuxsjN6yp46TZW/P0A
g6xxOCMRG4SqY6H8aWUBqoTJKfOhLkjqaTUhefBrIQ==
=Ffwm
-----END PGP SIGNATURE-----

--dhoJXvz2JoQ2Br/s--

