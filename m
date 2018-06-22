Date: Fri, 22 Jun 2018 20:27:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180622182709.GO57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6oDOB6mVXEStRxH7"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6oDOB6mVXEStRxH7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 22, 2018 at 02:12:24PM -0400, Selva Nair wrote:
> My tap adapter has a link local address (169.254.98.86) on it possibly due
> to a previous dhcp failure. May be I need to get rid of that (how?) to
> activate this code path?

I guess this is related - the branch in question is triggered by
is_on_link(), so maybe in Antonio's case the tap adapter is set to
0.0.0.0 - or it actually tried to install a route related to
redirect-gateway.

Are you connecting to your VPN server over IPv6 or IPv4?  You already
spotted one weirdness with "redirect-gateway !ipv4" which still seems
to setup "something" in the route_list - so maybe it's related to that,
but needs "VPN over IPv4" to trigger.

In other words, no idea - hoping for a log from Antonio that shows the=20
"route.exe ..." call with "IF <ifindex>" so we can see what openvpn
tried to do :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6oDOB6mVXEStRxH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbLT99AAoJEB2Cnv7KVigSEckL/1JEBWh0Mu3BFwuQHr2z5LNW
A1Xof92+weiHxW9Zyxv4R7pp2X/HVysYoZDZB7IKudo60yffXo6pZSBdwLJSosYj
22v5aK+JyvKdyumuoO0WFIyBI3GrqzjvfPzJS6iJqeMpE8LyQNQRUoObghwAQOX1
ywcwlKHSmG+281HTacn7Gxi5H+Rguh9AB+yIeCwltKsqyhZu/GZ+82pm7zl1Ss++
eTxEaQJzoR9Ziwdc63nx/rRR2gJdoiwJqhDfrCzTvg8fzY7+W8mkAtSJP81A/J+b
EXrrzUGsOkVymVwYgImfnfZPDGvIoxHcoPisvQmfDB7SE60pv9WPVj2D1SGXo1vy
wqeK5/TFR2iu5nnCXg8orcxACyCWIrKg5Q4aaoYrSw8mH61rIg1BocD7+r2hAiSJ
qA+90m5e9cBJocxOiAmyFI4fZDOCQDvOM0YjJ2VlsqHPjKX9GZYOcY92b1rAHA64
Rc4/TXd+ddN/F9ZJvbCsLYlqk769AJJ8WHKn6iBHog==
=sKCJ
-----END PGP SIGNATURE-----

--6oDOB6mVXEStRxH7--

