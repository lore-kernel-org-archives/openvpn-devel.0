Date: Sun, 5 Apr 2020 10:31:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200405083121.GO1431@...1296...>
References: <1585591527-23734-1-git-send-email-selva.nair@...277...>
 <1585963064-10311-1-git-send-email-selva.nair@...277...>
 <1585963064-10311-2-git-send-email-selva.nair@...277...>
 <20200405082556.GN1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="coI8Uo1OCn5IOJ+M"
Content-Disposition: inline
In-Reply-To: <20200405082556.GN1431@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password query the management interface (if available).
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

--coI8Uo1OCn5IOJ+M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 05, 2020 at 10:25:56AM +0200, Gert Doering wrote:
> On Fri, Apr 03, 2020 at 09:17:44PM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >=20
> > When only username is found in the file, redirect the auth-user-pass
> > query to the management interface if management-query-passwords is
> > enabled.  Otherwise the user is prompted on console, if available,
> > as before.
> [..]
> > ---
> > This may be cherry-picked from 57578310992d1fbe8eff97049087c5308089acb5
> > in master without conflicts.
>=20
> And this is what I've done.  So we have:
>=20
> Acked-by: Gert Doering <gert@...1296...>
>=20
> commit 2fe84732d19243df6c7713c185998507419155cd (HEAD -> release/2.4)
> Author: Selva Nair <selva.nair@...277...>
> Date:   Mon Mar 30 14:05:27 2020 -0400

Shouldn't do early sunday morning merges - one of the main points of
asking for a 2.4-specific commit was "Changes.rst", which needs to be
updated to document changed behaviour...  which I had forgotten again.

I'll do this on the "prepare for 2.4.9 release" commit now, but would
really prefer to have it in the commit that contains the actual change
(if feasible).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--coI8Uo1OCn5IOJ+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeiZdYAAoJEB2Cnv7KVigSrpQL/AhJzpu+wHi92H2gG3buP8Z5
hoQTguVW2c5S7IxiPk45ZyctQi3sEl4QqRjWsVS+PrZLN9JDRX2HHCR8UfjPmNCC
865dbD00PULoFicd5GPeQasamCxArFCFVUiZwWOxyjb0GsU+ca3vVu1Ze/pgMPlm
yxs7afM+d9wLTUKYV69WCux3Rd0rrn7pwzV8UZ3pQYr+luZTZiipXNXWMBbURfIm
g88cqFuh2Xhm47d8I9erVAhNvXQHTbnDdq35C70wctJqM8ekQnZeispsjFo3A5h/
iuP48C30KN96hsHah7M3XkD6iZiHldfQ2CWUBXn6Fc7ZdzDe006RZ45Du9tHWNRF
9SXX8DwFdcVeTSabDlFqOWOg9uA1PXY37C0uGBuhp+eMdaaNWymDfSDBm4jDYjv2
z3oI4BO1h8pPefcJMBanm5aRzBXPfDdnb8jFWN1SIEVEPYGn48W+Je/SyzlVyV03
5b6SIZVvRr42BnYQ1Nj6XKQP2zMiLP6PfLcbyRa4Nw==
=9if+
-----END PGP SIGNATURE-----

--coI8Uo1OCn5IOJ+M--

