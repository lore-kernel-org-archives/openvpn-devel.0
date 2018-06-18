Date: Mon, 18 Jun 2018 22:59:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180618205916.GJ57262@...1296...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eeg465crObqkzWj4"
Content-Disposition: inline
In-Reply-To: <20180618205610.GI57262@...1296...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Kunkee <jkunkee@...2393...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--eeg465crObqkzWj4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

silly me

On Mon, Jun 18, 2018 at 10:56:10PM +0200, Gert Doering wrote:
> On Mon, Jun 18, 2018 at 08:27:31PM +0000, Jon Kunkee wrote:
[..]
> > Is there a chance the ARM64 changes (NDIS 6.30+build+installer) will
> > make it in? (Are we trying to get the MSI changes in for this release?)

Didn't have time to look at the MSI stuff yet, and haven't heard from
others.

Most likely this release will be "get things out with compromises" -=20
that is, have one attestation signed driver for Win10+Server 2016
and one driver for "Win7 + 8 + 8.1", and two .exe installers.  Win10
is still waiting for bugfixed + signed tap drivers for the fix in
commit 7d6a1335bfe7a...

Then, focus on make nicer installers - .msi for the tap driver, .msi
for openvpn proper, return to *one* driver that has proper signatures
for everything.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--eeg465crObqkzWj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbKB0jAAoJEB2Cnv7KVigSoywL/R/1N+hUcXmk+SNjhrJnFybj
NCejxWexA9XE0vZyTRYHJi6tWH2+5oZaStaLVCtxHzmgwI1vz2RwgNdZlN1C1l9d
nrWOKR/7U5qMBVxbjhaxuT+T6EWOXt06tE8sLDnCYPhNdaUL6EYQn/0u1TxmQVil
Svvvn40Qg2XqkijWDCtFN+CHCxShjO0JCImV6v5UEVnZEJtB/k0HQFgC3yA7eYD4
5wA4GZwl7thonrHnRVUKTkfUKbZpINYG/lbgKSKQX5OaImJOjUqmHE6adCLHjUrH
WkbvsSfX6lNld87TH5n9e/coCjJYHC/eig0a6af08Nb1dcQSPdXk1CilOOx46Phw
8WLv+s1BDIxjJS9dueNnt662JPm4jDYcBfIGjN0j/r27+oRgqEUAHUrsVmDxeXJE
Xf5NAFbu2AAJr+Q3xCqg3BAsxzo4/+N1VUsOjlhhUDEbGn89TM6p5lrgZye9ZX27
c6HbvY6hh+mq08OFXVPUBQBA2EDHVXLZQApYJqeDAA==
=DP/p
-----END PGP SIGNATURE-----

--eeg465crObqkzWj4--

