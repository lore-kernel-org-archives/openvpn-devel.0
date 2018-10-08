Date: Mon, 8 Oct 2018 19:31:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181008173150.GR962@...1296...>
References: <1539016554-23503-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MPRXw8klpfH35tNR"
Content-Disposition: inline
In-Reply-To: <1539016554-23503-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] interactive.c: fix usage of potentially
 uninitialized variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--MPRXw8klpfH35tNR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 08, 2018 at 07:35:54PM +0300, Lev Stipakov wrote:
>  out:
> -    free(cmdline);
> +    if (cmdline)
> +    {
> +        free(cmdline);
> +    }

Do we have something in our styleguides related to these constructs?

Since free(NULL) is well-defined and valid(!), the if() check is not
needed at all and just adding extra lines on screen.

I'm sure we had this discussion before, but couldn't find something
where we wrote down how and why we do things.  We do have parts of=20
the code that *does* "if(ptr) { free(ptr); }" checks, and others that
don't...  for example, AsyncPipeOp() on failure to malloc() "handles".

(Of course cmdline needs to be initialized with NULL - not argueing
*that* part)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--MPRXw8klpfH35tNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbu5SGAAoJEB2Cnv7KVigSZIYMAKDUTRMJ4B+3ZFXxAY1tfVTU
6L18kFuNPNEBfo5D2YOZlr1l50rue8sM28Eq63AGjmtyityahrWoDuzxuzM7RWjS
Wlt2JjicoCYnANEPQf3Y5VEWftO8nce1JHCpbTvaijUgTIDlyfAiLcy9ZY81+tJC
nHbKXBA7yre8yqIhFpxIHU78l48dHGQDZBjbQRRnNhqBDp2RCyd6z3054V+80Uin
IDFlML4SQlM7YTiBu+aG4a1LWhpi1gNhzzHikSdu5hdp41ziVP3vTF1k+6LLoBBf
lbtzXGUPJYQnyHzCnLDs718yUatibk8A2njK1Qq9/tSTHv3q98H1YcxGfCoA99Xs
ybzgQ/4SeJuCoUT2OKL3FLlNucHJU46hwf3tJVzzbxmXGcNczGVNlbUmfulIFkHD
0hM2fnX8Wy2t0750e0yDRJEbvo9UVPcANqg80buTQthk+o2ee/jv2uycJxwp/K4G
GVx00XDJ7CeXJyA869ExvtCmW3utspJdfzZWb/qNfQ==
=ZI0g
-----END PGP SIGNATURE-----

--MPRXw8klpfH35tNR--

