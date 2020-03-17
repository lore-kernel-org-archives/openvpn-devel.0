Date: Tue, 17 Mar 2020 11:25:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200317102500.GP1431@...1296...>
References: <20200313130133.19045-1-samuli@...515...>
 <285d114f-89b4-992d-f8b1-5cec175994ca@...2080...>
 <CAKuzo_gDkHGy0j78hH33zeXKnsi=7NF8PvFNJQQpq7kf2-=Gbg@...278...>
 <31ca48e1-deb8-7122-6f77-051b08e1b563@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="c5s4KQzYKKhDo6IA"
Content-Disposition: inline
In-Reply-To: <31ca48e1-deb8-7122-6f77-051b08e1b563@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Document some limitations of
 --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--c5s4KQzYKKhDo6IA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 17, 2020 at 11:06:53AM +0100, David Sommerseth wrote:
> On 16/03/2020 14:48, Selva Nair wrote:
> [...snip...]
> >> I would just rephrase it to say:
> >>
> >>   OpenVPN GUI v11 and newer uses its own internal username/password st=
orage
> >>   independent of the --auth-user-pass file provided.  The file argumen=
t is
> >>   ignored on such installations.
> >=20
> > I wish it behaved  like that. Unfortunately the file argument is not
> > ignored in such cases. If the file has only username, openvpn.exe
> > reads it from the file and then fails to prompt for password as there
> > is no console available.
>=20
> Ouch ... that is a pointless misbehavior.  Lets try to fix that.

Have you recovered from your latest adventures in "password query code
in OpenVPN" already? :-)

Not sure if the management commands permit the "we have a username but
no password" flow today... Arne, Selva?

But yes, this needs to be either a clear error, or "work correctly"

> > I propose to change this behaviour to: if --management-query-passwords
> > is set (which the GUI does), ignore the file given in auth-user-pass
> > and prompt both username and password from management. I think its
> > only logical for a later option (in this case the one set by the GUI)
> > to override a previous one. Anyway we do already ignore it if the file
> > is "stdin".
>=20
> Agreed!

No, as this will break working configs *if* both username + password=20
are in the file (did we ever merge the "inline auth-user-pass" patch?).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--c5s4KQzYKKhDo6IA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJecKV7AAoJEB2Cnv7KVigSCPML/3i7FbZZeS7M7SSRND+/nm6f
fzAM3Ktav95+FpsSSajn8UHCqyYAfM0z+ZXsOhg7CsGhjuiQwu92Y0lLQzY1EGMs
bFnwg22jTBzr3rQ5cC+BQpP/NR3Lwbo3luaOwwpcDgzSa9ylIc/Zdk6Am0jkGJzS
z6U6r1pAh9WOv7+esju6SPPcQ5+jsqFTK8LBFHjplVKtL/xVlNHiSotB5hQsT6EG
cHg2fxzlUtiwPs48LtNduBDAWc4IwiNpYdbNjiw+N5IUmWcSX/g08EpXAz0Rr1u/
jjLs8QU04ExCgxZUEYkN1x02lbkMN1yxorXZzKH5IoZy0zrLtW96xcu2XT0cXVK7
OujhTGC1hgNYGXXp4lX9dlox4upHiC+9zCbXTW1h4Z1dr7PV7sC1RAF6a7BEl0KP
dYNK35JEbziUg532Su9q5fN1ew6MDS7iV6vuOeHLd2lytgNfxyJd0LVz7JjFsjKo
K2gOtq1Na8cHjm9dfZ873PWbyEeNzFJg993OKwRv1Q==
=mY/3
-----END PGP SIGNATURE-----

--c5s4KQzYKKhDo6IA--

