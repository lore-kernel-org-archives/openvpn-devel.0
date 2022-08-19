Date: Fri, 19 Aug 2022 12:59:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv9tHvsCjJ7PsM9z@...1296...>
References: <20220813204224.22576-1-a@...2181...>
 <20220813204224.22576-4-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="urVnoWpmrRLU61WT"
Content-Disposition: inline
In-Reply-To: <20220813204224.22576-4-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v101 4/7] dco-win: add documentation to
 README.dco.md
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--urVnoWpmrRLU61WT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this looks good to me - will apply as soon as 3/7 goes in (to avoid
having documentation that says "it's in" while it isn't).

Acked-By: Gert Doering <gert@...1296...>

On Sat, Aug 13, 2022 at 10:42:21PM +0200, Antonio Quartulli wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> Changes from v100:
> * add URL to windows installer (openvpn+dco) and modify text
> ---
>  README.dco.md | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/README.dco.md b/README.dco.md
> index c38d3de3..aa93d667 100644
> --- a/README.dco.md
> +++ b/README.dco.md
> @@ -57,6 +57,13 @@ see a message like
>  in your log.
>=20=20
>=20=20
> +Getting started (Windows)
> +-------------------------
> +The simplest way to test DCO under Windows is to download the latest ins=
taller
> +from https://build.openvpn.net/downloads/snapshots/github-actions/openvp=
n2/ .
> +This installer contains the latest OpenVPN code and the ovpn-dco-win dri=
ver.
> +
> +
>  DCO and P2P mode
>  ----------------
>  DCO is also available when running OpenVPN in P2P mode without `--pull` /
> @@ -111,7 +118,9 @@ Limitations by design
>    - older versions are missing support for the AEAD ciphers;
>  - topology subnet is the only supported `--topology` for servers;
>  - iroute directives install routes on the host operating system, see also
> -  Routing with ovpn-dco.
> +  Routing with ovpn-dco;
> +- (ovpn-dco-win) client and p2p mode only;
> +- (ovpn-dco-win) Chacha20-Poly1305 support available starting with Windo=
ws 11.
>=20=20
>=20=20
>  Current implementation limitations
> --=20
> 2.35.1
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--urVnoWpmrRLU61WT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/20eAAoJEB2Cnv7KVigSgVAL/0jRDYVQaBCVQcVqyakwo4UQ
zEkOGktu7Iiem3m03L/Op3BoeNDypNTThxc+1T4RvNiEgdal9gBK246ZJmldCS/N
bMs1tM7POCQ18RDU6KPC4ADXZ5LH9YgTeyLJgYgJ2IXLF70P3X8A7TJS7w3TXTdA
fgrQrq6ZUvU0cgMudMNJUE6rTHNV+bwXaznOiL8ku2tuESPboArOu8mcQqNxwfp/
/E7qVmfO0T4WYJd/yNXIl3/wLhPvFLzB18I4OWKaewF10jeCmT00fNZPUc4X0OIR
RYVcFfgyg8ub8nUVRPjZqz4g89YbdfKUAkslg1bHVSYnz3G8rwnzL46H63Ai/xag
yslsXkWO7s8EsCJS7Lix8nixuFi6ExuE7jPSnUggrCFK/NEn6vrLhRwB+mpw97VK
xvEKNnirIBQAU7OKHNaP31yPvxTJQaUjzGs54zLuIRJdV043M9p+557t/D787JLp
H0aHB4jUc/zIHcqfQrDD/CLnKEf4OnZgwAmcN9a+bg==
=RFii
-----END PGP SIGNATURE-----

--urVnoWpmrRLU61WT--

