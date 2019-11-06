Date: Wed, 6 Nov 2019 23:12:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191106221219.GO40538@...1296...>
References: <20191009143422.9419-4-a@...2181...>
 <201911062111.xA6LBwGQ010924@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+hZIELbchok2+JHy"
Content-Disposition: inline
In-Reply-To: <201911062111.xA6LBwGQ010924@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: maddr: export VLAN ID from
 client context to maddr object
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

--+hZIELbchok2+JHy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 06, 2019 at 10:11:58PM +0100, Gert Doering wrote:
> As a side note: it seems that whoever did the IPv6 payload patches was
> a bit sloppy (it was me, so I am allowed to say that).  MAC learning is=20
> only done on IPv4 and ARP packets, but not on IPv6 packets - so I expect=
=20
> "ipv6 only mode on tap" to be a bit wacky...  this needs re-testing
> before we can declare "ipv6-only works reliably".

I was wrong here.  This part is only for the extraction of the "inner"
addresses in an tap/ethernet packet, which are then subsequently used
for ENABLE_PF filtering.

Since *that* only has IPv4 (because nobody reviewed and ACKed Antonio's
"make PF support IPv6" patches yet) it makes sense that the code only
extract IPv4 addresses.

Now, I see a slight merge conflict with the PF/IPv6 patch set... :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+hZIELbchok2+JHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdw0VDAAoJEB2Cnv7KVigSTSUMAJRLIsSsGFBJfLIQ3Z+doWnl
z78LTHxH1hY5hJSbSR/YcrdyuhOMrPg4i/suzIo6CPFK13krN96fVGpV0fLMxYi3
qa9dJ6X+vL4rGpq9++vexgvRBvd3qP0Fb4Uvi/bikkFAxwkpHeLx9eZBFj3ULfy4
a5r5wRRH3RAcj5dEzpJaeohXcxs+cclS2rUUSKe5Z1wOpvsE+e5hlFaDEYWTEBWC
G6EU+GpQsoaBYvb7B7DI+P+0L9YQGhkrVrcbCOr25vY+HLQeXJO69GD2PIs50+lR
KbPnemteVe9nkZwiP9Lqg0stVtUCxbLTj2sqhI0tFptYV0Db6oZYTuT2lSF38X2y
qjD8bB188EvRXH98S33ndldvFvrw+soxTyI0l51D4iMl8Hmw8ZPh1iTHmjxO6XDK
rIn+rtd4HnYYqyfw8X01j1SHR+0OdQx2+o+ztAsGTLTPSTHAgbFWZmidDp2X7TyQ
n2YEJ4TF7DWrlSoxlzQWRPjRNm4Jx6TdrJ/TkT6YCg==
=75uT
-----END PGP SIGNATURE-----

--+hZIELbchok2+JHy--

