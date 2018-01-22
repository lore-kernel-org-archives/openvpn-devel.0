Date: Mon, 22 Jan 2018 17:21:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180122162121.GV69387@...1296...>
References: <CAKuzo_jF_fHfcEPUXeo6WKWQ4tw7T72-cexEUda=USGd9Ref7g@...278...>
 <e09e95cd-a6d1-e1c0-9c05-738362207278@...2080...>
 <98ce7083179e0a097b35953a9ef3879c.squirrel@...2257...>
 <91ffd543-3f5a-e08d-ac89-379770b46b96@...2080...>
 <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="n8d7KAgWmJ23Ts4y"
Content-Disposition: inline
In-Reply-To: <1f480b84-a0f8-a0a0-7bf7-0081e44d1c06@...1435...>
Subject: Re: [Openvpn-devel] On testing with openssl 0.9.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--n8d7KAgWmJ23Ts4y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 22, 2018 at 05:05:35PM +0100, Steffan Karger wrote:
> > So if we don't have really strong arguments keeping support for
> > this old version, we should carefully consider our options.
>=20
> We already removed support for < 1.0.1 in the master branch.  Maybe
> just make sure we can get 2.5 out, and move forward that way :)

So, what's missing for 2.5?  :-)

I can see "tls crypt v2", "refactor route.c and tun.c", "netlink"=20
here - what else?

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--n8d7KAgWmJ23Ts4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaZg+AAAoJEB2Cnv7KVigSHi4MAKjrrEY3Ndy9U98qh1UfLYKQ
NNlIO6qbCZKKeyrwIywoKqF9FfWDup4mpRw6i1UfTNez3EEXzeqea+44ETwkvKJT
TyVNggpN8xQovmfx/yhhX1iCPa2Q6wwqWvNXH9ueo9PTYk+VVInTm75T+Y5Y1B5j
oDiryalTOCz1guKy5Y7beUu5OxrVbzAKvm6G4cE3O5leBDIYzFdXBH5JkKgwqZPa
ejkgxI7kOSnHgzkjzM6ONNXk5XdkTdnsFCpbU8RSADh3lDUfIdQhOM6Xuugp5L+c
gtlaoO8oeqngvCxRzi04poZh9mhfsAEG2pDh+Ad+TgmtNJhRbZQ/cobp8kjzmSPa
7xkV8QR+y5wLd0/lKYms4zh3ZwkfqHoFPhWBQDl3bxo61/oCaYgtru+LzS/ZswCq
rLqTckX2fl8DKgMEP/7ZfSAfwLDwYT+cVEOydE8ojcdyJVqpaS0Vp6NKSUZorQ7F
7fbe1zFVDpexio7pQnjKWnAl05vv623ytXNJf+ulDA==
=gLzI
-----END PGP SIGNATURE-----

--n8d7KAgWmJ23Ts4y--

