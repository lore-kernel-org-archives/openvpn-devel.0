Date: Mon, 12 Sep 2022 14:55:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yx8sSIICV0jmFbPk@...1296...>
References: <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
 <YvVwcBtzGagtUgOA@...1296...>
 <8E0AADE4-350B-46A5-B4BD-5E97ADA642F4@...2661...>
 <YveWP9xh9XwsjwPY@...1296...> <Yve0gy+SuH+7unUj@...1296...>
 <7CB2FF09-EE1D-427E-BBD1-4128EAE1ED4A@...2661...>
 <Yx8hkCs4tOK5+dBl@...1296...>
 <F65A9C36-1FA7-44E2-8A13-8573DD3FEAA7@...2661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OZmD3CrT2NQsvwl4"
Content-Disposition: inline
In-Reply-To: <F65A9C36-1FA7-44E2-8A13-8573DD3FEAA7@...2661...>
Subject: Re: [Openvpn-devel] big packet loss with FreeBSD DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kprovost@...2661...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--OZmD3CrT2NQsvwl4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 12, 2022 at 02:43:09PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> > it *does* bump the outside packet length up by +16 bytes ("bad length 1=
512" ->
> > "1528").  Smells cipher algorithm padding or so - but why 16?  And why =
pad
> > at all (AES-256-GCM used, so I think we should not pad)?
> >
> I would still expect padding. AES will operate on 16 byte blocks, so no m=
atter the block chaining mode we???re going to have that multiple-of-16-byt=
es thing.

Asking the expert again :-)

14:51 <@plaisthos> aes-ctr generates a multiple of 16 bytes as stream
14:52 <@plaisthos> then you xor the message to that and just use the len of=
 the=20
                   message

so yes, 16 byte block, but the message length does not increase.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OZmD3CrT2NQsvwl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjHyxIAAoJEB2Cnv7KVigSnoEL/R97ZM5zi3aT2X1ggfCEp1Ra
BAPVwjfiq/BLf6psy1OAT8hEAn3WZbrbzcRsbf5Nqm81vyVouui0/Pr+TOo1IvtN
BS861+4UZwgFkCH4YULk1xzpMQD83EEdiiphQ2KeTXFkt//Yz2BgD1f9hNn/7b4+
jxwFJylLDD/PwJ+N/e+7yK5H4jj+WQfL6v1XDV0+TkwBMbluG4hu2ez9wHhTB/ZO
ADGHddEMVdwT6nM4pAhk4+JsV8P1ihmjG2rgg46dsmcfuYXQMaqh6xQDAmJAJYFs
2LqiFQRhrn/6otzWlBo/qcQrojMcEtUK06WsLx46QVmGQEQi4Y+SiAak2IxqVYYA
fiyfAGczRLhtaW+WbbYKGvvHomtHl9rKUhQ520A2bDqdZizXDMP+GXyThga5KN8E
HMOnkyyvd6kiJl7ylk9CUZ1i5xfcRdbcqh2Aq/iW+fayhKZTEjbnVQdJY+2BWgJp
Udx6ituCbHOiXbqoa9oxTD589DEOFGayMRm5okwpvA==
=kAuG
-----END PGP SIGNATURE-----

--OZmD3CrT2NQsvwl4--

