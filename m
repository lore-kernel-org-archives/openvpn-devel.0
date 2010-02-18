References: <1266515908-24807-1-git-send-email-kop@...1304...>
	<1266515908-24807-2-git-send-email-kop@...1304...>
In-Reply-To: <1266515908-24807-2-git-send-email-kop@...1304...>
Mime-Version: 1.0 (Apple Message framework v1077)
Message-Id: <45787FBA-CA1E-421B-A360-CEDF09411EEE@...1286...>
From: Eric F Crist <ecrist@...1286...>
Date: Thu, 18 Feb 2010 13:33:38 -0600
Subject: Re: [Openvpn-devel] [PATCH] Change verify-cn so cn is no longer
	hardcoded in openvpn's config file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.


On Feb 18, 2010, at 11:58:28, Karl O. Pinc wrote:

> ---
> sample-scripts/verify-cn |   42 +++++++++++++++++++++++++++---------------
> 1 files changed, 27 insertions(+), 15 deletions(-)
>=20
> diff --git a/sample-scripts/verify-cn b/sample-scripts/verify-cn
> index 5d56d95..f9fea0f 100755
> --- a/sample-scripts/verify-cn
> +++ b/sample-scripts/verify-cn
> @@ -7,24 +7,28 @@
> #
> # For example in OpenVPN, you could use the directive:
> #
> -#   tls-verify "./verify-cn Test-Client"
> +#   tls-verify "./verify-cn /etc/openvpn/allowed_clients"
> #
> # This would cause the connection to be dropped unless
> -# the client common name is "Test-Client"
> +# the client common name is listed on a line in the
> +# allowed_clients file.
>=20
> -die "usage: verify-cn cn certificate_depth X509_NAME_oneline" if (@ARGV =
!=3D 3);
> +die "usage: verify-cn cnfile certificate_depth X509_NAME_oneline" if (@A=
RGV !=3D 3);
>=20
> # Parse out arguments:
> -#   cn    -- The common name which the client is required to have,
> -#            taken from the argument to the tls-verify directive
> -#            in the OpenVPN config file.
> -#   depth -- The current certificate chain depth.  In a typical
> -#            bi-level chain, the root certificate will be at level
> -#            1 and the client certificate will be at level 0.
> -#            This script will be called separately for each level.
> -#   x509  -- the X509 subject string as extracted by OpenVPN from
> -#            the client's provided certificate.
> -($cn, $depth, $x509) =3D @ARGV;
> +#   cnfile -- The file containing the list of common names, one per
> +#             line, which the client is required to have,
> +#             taken from the argument to the tls-verify directive
> +#             in the OpenVPN config file.
> +#             The file can have blank lines and comment lines that begin
> +#             with the # character.
> +#   depth  -- The current certificate chain depth.  In a typical
> +#             bi-level chain, the root certificate will be at level
> +#             1 and the client certificate will be at level 0.
> +#             This script will be called separately for each level.
> +#   x509   -- the X509 subject string as extracted by OpenVPN from
> +#             the client's provided certificate.
> +($cnfile, $depth, $x509) =3D @ARGV;
>=20
> if ($depth =3D=3D 0) {
>     # If depth is zero, we know that this is the final
> @@ -34,11 +38,19 @@ if ($depth =3D=3D 0) {
>     # the X509 subject string.
>=20
>     if ($x509 =3D~ /\/CN=3D([^\/]+)/) {
> +        $cn =3D $1;
> 	# Accept the connection if the X509 common name
> 	# string matches the passed cn argument.
> -	if ($cn eq $1) {
> -	    exit 0;
> +	open(FH, '<', $cnfile) or exit 1; # can't open, nobody authenticates!
> +        while (defined($line =3D <FH>)) {
> +	    if ($line !~ /^[[:space:]]*(#|$)/o) {
> +		chop($line);
> +		if ($line eq $cn) {
> +		    exit 0;
> +		}
> +	    }
> 	}
> +	close(FH);
>     }
>=20
>     # Authentication failed -- Either we could not parse
> --=20
> 1.5.6.5
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

---
Eric Crist





