Date: Wed, 26 Oct 2022 20:48:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y1mA4wCWNjdPWWqu@...1296...>
References: <20221019224642.11178-1-selva.nair@...277...>
 <Y1kr4zYWRP29K2G2@...1296...>
 <CAKuzo_iRT5SHQUq2jMnBsY6W+wmpVGS2y9d+saVX4dT7D=udiQ@...278...>
 <Y1lKC+75SJEpCYXB@...1296...>
 <CAKuzo_h0CC43=n-PydjH7qcVk5G1XjVZtSqMHmZSgqiJUPRMnA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PseDdMH2Nf95F07d"
Content-Disposition: inline
In-Reply-To: <CAKuzo_h0CC43=n-PydjH7qcVk5G1XjVZtSqMHmZSgqiJUPRMnA@...278...>
Subject: Re: [Openvpn-devel] [PATCH for 2.5/2.6] Purge auth-token as well
 while purging passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--PseDdMH2Nf95F07d
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 26, 2022 at 11:54:57AM -0400, Selva Nair wrote:
> > I'm not sure I understand what the intended use of
> > --management-forget-disconnect *is* - if it's "disconnected by a button
> > press", the GUI can send "forget-passwords", and we do not need this
> > option in the first place.
> >
> > If it's "disconnected by a network hickup", why would one want to
> > flush the token here, which is intended to seamlessly reconnect
> > after the hickup?
>=20
> Here "disconnect" does not mean disconnect from the server, but disconnect
> the management client from the daemon. I like to refer to it as "detach"
> from the management interface. When the client detaches it allows another
> "client" (may be an interactive  telnet session) to connect.

Ah!  I was misunderstanding this option.  Yes, in that case, "forget
everything, including tokens" seems reasonable.

> Still not convincing?

Now it is, thanks :-) - wrong "disconnect".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PseDdMH2Nf95F07d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjWYDjAAoJEB2Cnv7KVigSO24L/14h7ksQUfigBIAKCkURNJmq
LTCCRSuK++PZpX1wHZC01dlMMfaLQMCx++Z+5MpBJCWvKrV8VjYWVd/+GqJHGTPW
P/DQ/TDLkdzI8yK/rcxUduXvT4TwCd8H2G0uJCg5VwMtqouPdgzzjTohR5d3B/qH
I4qmDyNHuQTpBplkn3pg7CtmEcfVhd6NFGtkkK9NLrMXUBnvO/vbNzXtjtKtTPPN
yAMSxi64L4CIRQhw5G1TYll30jIEXof51SqFOS+F0amOEfVcXwJwwRx7I7EiqxBW
BdZ75BZobzlQygPnr4SXjxF6cNUeuLgtm4AiRyVHhsRrxvVySs359HqtupALq2eU
s2UJ+yDV8ETk3UHqQ7qWPY1+pNkYXMcRcDkK2Z8y3EDeRtsaGUNjBHxiZNy/B1mJ
tgOmx15kNTj6DrYIndhmKhdRMlvrbHX8n91n8ro+HH8c7t4U6gArmgwTIZwha+30
9n1y8Lseo8PF1ufHHmLpX6eL3LmwkIvmCWBMW9Vczw==
=Szd4
-----END PGP SIGNATURE-----

--PseDdMH2Nf95F07d--

