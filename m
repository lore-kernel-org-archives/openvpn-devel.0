Date: Sun, 25 Feb 2018 18:49:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180225174901.GM69387@...1296...>
References: <CAKuzo_g8HrdHNM666wqtPTsw6M8++=k7zYZN-XdaCNfonDnawA@...278...>
 <20180225082228.GK69387@...1296...>
 <CAKuzo_ihbV4ah4vhV+SFSpMw1h+5QKVuPrz3aOeKR_gtWwB+kg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/rpqzglUoB70AQHl"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ihbV4ah4vhV+SFSpMw1h+5QKVuPrz3aOeKR_gtWwB+kg@...278...>
Subject: Re: [Openvpn-devel] patch emails to the list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/rpqzglUoB70AQHl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 25, 2018 at 11:24:16AM -0500, Selva Nair wrote:
> It turns out their spam filter is scoring based on my residential IP
> (that of the MUA) instead of using the MTA IP (gmail.com). As if I
> relayed the mail. My home IP is in some RBL but that's unavoidable as
> every residential IP blocks are in some black list or other these
> days. If this continues it will become impossible to send patches
> using git-send-email.

Oh the fun of anti-spam rules breaking normal list usage.

Right now, the list is totally broken anyway... most of the day, their
MXes returned "user unknown" in response to "RCPT TO: <openvpn-devel@...2380...=
...>",
not we're at

<openvpn-devel@lists.sourceforge.net>... Connecting to mx.sourceforge.net. =
via esmtp...
<openvpn-devel@lists.sourceforge.net>... Deferred: Connection reset by mx.s=
ourceforge.net.
Closing connection to mx.sourceforge.net.


(mailed their support around noon, no reply yet - will have to remember
which mails I sent to the list today so I can re-send them when they're
back to normal.  Yay)

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--/rpqzglUoB70AQHl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJakvcNAAoJEB2Cnv7KVigSkkcL/1+gnepgn/R066z04kdHuSFN
ULwvJw5HdZmMbAKbEl6+5+WDBbkmnHKzUTicOn4u2XJ3vooFs321IUw/sgoBl1gD
mk0+wcc3UnixZWy1P0x04LU+tY2B7RONYpt4OQ79Jm9BjLrD1eosBiylNuQi9VwE
yq4QUa556A9L5i9V5l8oQ8fwV1msL+4aCJ9oYTG1X9iZl/RhIRu7SZHrzLXi6MJK
pmEJgo74EkzoyWCwcUa3Rq25zT6t0OXTFJNo1Sl8e03LuqfPZ2pxVtLzBwahqSQJ
gsrp2xXs5pLaAWqLBafKk+DOiGKuU5Yk6qwQ2QpkgO+3jAsP4p6A11pUDKM8iqv5
HhHgFNwmNaTD6lprAMf2XceAKl1BTG34171pi1u94zN7PFVl1yYVO7YcXZyBw5fZ
dcmT6jHEY73Tx+S+bJy7oU6WjIAzlRuFeMvk/1rLN8j0zql5cQ7NLwzWUzF11PNl
NREQmEFc/JuZd2jsBSwp6Btne9BNHKi5DlW6o7RF0Q==
=z1Ct
-----END PGP SIGNATURE-----

--/rpqzglUoB70AQHl--


