Date: Fri, 2 Oct 2020 17:59:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201002155941.GF976@...1296...>
References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lYVfafuUkPqz/tKz"
Content-Disposition: inline
In-Reply-To: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
Subject: Re: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--lYVfafuUkPqz/tKz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 02, 2020 at 03:26:29PM +0200, Fran=E7ois Kooman wrote:
> After testing connecting over native IPv6 to the VPN server, it turns=20
> out the IPv4 traffic is not routed over the VPN. This worked in older=20
> versions of OpenVPN (2.4.x) but no longer in OpenVPN 2.5rc2. I am=20
> testing with Windows 8.1, but the same was reported on Windows 10.

I can reproduce this on FreeBSD.

2020-10-02 17:53:07 NOTE: unable to redirect IPv4 default gateway -- Cannot=
 obtain current remote host address

Apologies for not *testing* this case - I need to improve my client side
test rig to better cover the 4 possible "default-gateway" combinations
(v4/v6, default-gateway for ipv4/ipv6).=20=20

As an explanation why this was overlooked - *these* client tests run
on my desktop machine and basement server, and they run without redirecting
gateway to avoid breaking my "normal work" networking.=20=20

The buildslaves run on VMs and have little other network activity, so=20
could very well test this (AND SHOULD), but their config is basically=20
a "slimmed down to the most important system-specific variants" of=20
the client tests on my desktop - we run less tests there because=20
everything takes ages, and the focus is on "this was broken on Solaris
at some point, so have test for it" (etc.) - but here, *more* tests,
at least on some of the buildslaves, would certainly be better (or
twisting some of the existing variants a bit).

Now, the server side tests also run between VMs, and the client side
for those has about 3 times the number of tests my workstation has -=20
but these are all focused on torturing server code paths (like, "if
I do this setenv, the client-connect plugin on the server will stall
for 20 seconds, and then FAIL - is this seen on the client?")...


Yeah, I'm annoyed at myself, and very happy that Francois found this :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--lYVfafuUkPqz/tKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfd05sAAoJEB2Cnv7KVigSYRwL/j0wMQ6d1kiSn9ad7j48YarT
R98VDsm45dBSRp6v7hGrLc8teAFIC00d9cjWFeAGCR6ve8YQyatqMIQ+XEsaBEdO
mkcTlM2XWcJEJC8lsy01Nrr3a3N9EhCp+u0zC+j9Y3dmMrVNRHor/T6IUogZi5mh
R2gyPZswqRBPZsSRLw1ixV1nUb4kFf6XozeRTCrAAcq06CPhD3zHsLiXvb3QcxR7
Hl7+zCM1doC7rSlefrzS3cUPZZRT3JaVuEiysik6Te94G6hSVVF3Q1/+PqcJLDew
J3AT4ZoWQckrNck2+xa7elJQQ2v5D8mrX1XweEsoIdgj6oAdHj96Wlc/87zgSOAs
7OxU4/P/HQIHG5Q1bUCyjh4ld8vODSc8bcAJROtqCySZRCDLVRWxdqoNfKXwwBy9
iXmrxh59T6sFhC7rZqNLmZ2AJH+IKgUFftpZHchDBOBdwtBlTSkCNpMIrqWfjvvN
WH8cQ3AvqWebEMFb9QYMHOWAFYH+NZiFEzFUh/ICgA==
=j0q0
-----END PGP SIGNATURE-----

--lYVfafuUkPqz/tKz--

