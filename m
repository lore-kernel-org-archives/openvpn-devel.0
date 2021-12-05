Date: Sun, 5 Dec 2021 12:40:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YaylGFdqxlCPwJNc@...1296...>
References: <20211202125455.2593763-1-arne@...1227...>
 <2116536034.296245.1638548339523@...2642...>
 <eeacddfd-0819-0afb-4767-0dcc011f8c11@...1227...>
 <YaySTbKDclfC6PWL@...1296...>
 <1302542561.460963.1638703016633@...2642...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Z0GcCKu7NYMsdAaE"
Content-Disposition: inline
In-Reply-To: <1302542561.460963.1638703016633@...2642...>
Subject: Re: [Openvpn-devel] [PATCH] Make --nobind default for --pull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--Z0GcCKu7NYMsdAaE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 05, 2021 at 12:16:56PM +0100, Frank Lichtenheld wrote:
> > I need to think a bit more into "what conditions is this checking, exac=
tly,
> > and why?" - but with refactoring, I'd have to do that thinking twice :-)
>=20
> I disagree. If you had one patch that does refactoring but does not inten=
d any functional change,
> and one patch that just adds "|| o->pull", the general understanding of e=
ach patch would require
> much less time and thinking.=20

True, but the second patch would not be correct, then :-) - as it
actually adds more conditions than just "o->pull".  The original code
does not check for socks.

I am not exactly happy with the *new* code, as it is still too convoluted
for my coffee level ("if (!bind_needed && conditions) set bind_local=3Dfals=
e",
what are these conditions?  why?) but I do not think an intermediate=20
patch will make these particular conditional contortions easier...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Z0GcCKu7NYMsdAaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhrKUYAAoJEB2Cnv7KVigSq4cMAJFNMZYWgfA4/SIoQ3BWJV4F
1Pf26ic816YLI82IH0HGl9169PV3hZARgZ69ja1vSWLhl+DnRWAMF0jmt7ePZQua
3sfYnKT43FI67lfRsCBepWYVZCbTe2EgniN9oNEdFZuzT3xdtkRLoCjpYAS0wcQW
aw+dYy9znggtbKf1vvWYquJzBhLNRvtXUKEDlZdQN8G5WLM9Kzs3uKTYP5ywrxNU
0T0aqhyGm6NcUwKdzWSX3y5BUDIFG4ekzjRH8QRbJtDat9eaXTlKr8lhlkpCq+sn
KmvkF5Sd6hqsF8gR4SXfvrgeOLQc+MORaGycr4kNVn2diQLKmdN/a+P6thQ4PvYq
Y0sTb58AHEZmQrqWdTn1erf0CcShF577yacBpdM8BdPq0bF7ppVE7jWFfa+v3BPj
TjUYWuqoVe8FjxDH2WPL76eTr9V8UsHFdCr8N5NxUy/63RNqJN0yVqzZgY6cuyXr
WvfTakAhsxhZxCq54EtLXIfQFAw78jUhDdVoYSZ3Lg==
=CL+2
-----END PGP SIGNATURE-----

--Z0GcCKu7NYMsdAaE--

