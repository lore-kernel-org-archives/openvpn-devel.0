Date: Mon, 7 Jun 2021 10:27:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210607082729.GY976@...1296...>
References: <20210604143125.4946-1-heiko.wundram@...2614...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6h8SQxV5EfeERWFC"
Content-Disposition: inline
In-Reply-To: <20210604143125.4946-1-heiko.wundram@...2614...>
Subject: Re: [Openvpn-devel] [PATCH] Implement Windows CA template match for
 Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Wundram <heiko.wundram@...2614...>
Cc: openvpn-devel@lists.sourceforge.net

--6h8SQxV5EfeERWFC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 04, 2021 at 04:31:25PM +0200, Heiko Wundram wrote:
> The certificate selection process for the Crypto API certificates
> is currently fixed to match on subject or identifier. Especially
> if certificates that are used for OpenVPN are managed by a Windows CA,
[..]

Just for completeness - I assume that this is a v2 of the patch, and
"something was changed".  Since we're all very lazy^Wbusy people, it
would be good to include a list of v2 changes in the commit message,
like this:

v2:
  - included suggestions about windows dunno things handling
  - code restructuring in some_function()

and please use "git send-email -v2 ..." when sending it, so git can
put a "v2" in the subject line, and patchwork can tell me "ah, this is
the new version".

Re-sending the patch is not needed in this case, but it would be nice if
you could send a quick list of changes in v2.

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6h8SQxV5EfeERWFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgvdhxAAoJEB2Cnv7KVigSqDQL/2c7/KFI1FdjWs/iNBdscijk
TyuEE2RJbP5o4XgFhNLSQnCSG2i2ON407F+GWHmAJ2NGNQ4uaku3Xwc1BB9CVYUW
xsw78dvMaj8vqKNfSLHMp8oufHAJkvBq6YtTW4GeoQlzNSk5K/+f4qd+LJ24t21V
Hh/yhS2BDLRS0vpbG9rHCeZhE4N4yHhPF67br6uP1vndgmls6nol6+I+Son3kfCJ
KscaaikMnW8ci8hj/MUVwn1UppFRdG7pMPi8ayyxYfpx8q3IcjcXWdGTC5Hko9zT
ewkXryDKRFZZWnn4SD9yvCEQ/yTSRksFRrD3uYAX9BOpHruaxG6rV8ow2CGHcJZY
SYCxotM6fsfUxjvsBu+5TWRkU/M94YHELcBlXBJEY8Z1QJSIkDebB+yTTcNCp5yj
X+SFrxaQLoR6aLK1B+Phjz4DztAKtR/A9vrXVU4N7fg6MmqY476ZeudiSXLR9wOa
ghaRb+Afb2wsUiGL4v1W4GQikwBvkehJN0qm/Uf3IA==
=Zn/o
-----END PGP SIGNATURE-----

--6h8SQxV5EfeERWFC--

