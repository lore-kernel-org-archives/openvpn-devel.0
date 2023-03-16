Date: Thu, 16 Mar 2023 14:11:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBMVnkkebh+e1bN2@...1296...>
References: <20230315013516.1256700-2-selva.nair@...277...>
 <202303160927.32G9RIoZ066276@...2054...>
 <CAKuzo_isnor9ZsohVH__n-JGnFi6tqqLwSfT07GMU6pVJZYHwg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0j23Q8xBSVOQREWN"
Content-Disposition: inline
In-Reply-To: <CAKuzo_isnor9ZsohVH__n-JGnFi6tqqLwSfT07GMU6pVJZYHwg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Import some sample
 certificates into Windows store for testing
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

--0j23Q8xBSVOQREWN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 16, 2023 at 07:59:42AM -0400, Selva Nair wrote:
> > I have tried testing this on a "real" Win10 VM, but I am missing some
> > intricacies with the cert store - I wanted to see if certs are properly
> > cleaned up, but I can't even see my own .p12 I have imported, so I am
> > doing something wrong...
>=20
> This works for me:
> Run "certmgr" from a user command prompt. The UI that opens up will show
> the "Certificates - Current User" snapin. Under it select
> "Personal->Certificates", and a list of all imported certificates will op=
en
> up. This will not include any Root certificates that may have been
> imported. Those go to "Trusted Root Certificates" listed below "Personal".

THAT was the clue I needed.  When you type "certificates" into the
search box, you are presented the same snap-in, but it will only do=20
"Certificates / Local Computer" (after an UAC confirmation).

So, cmd -> certmgr -> "current user \ personal certificates \ certificates"
will show what I imported from .p12

(And it does *not* show any of the test certificates, so I assume that
cleanup() worked correctly.  I might try a test run that skips cleanup()
("core dumped"), just to see what happens, but as far as I understand
the code, the *next* run will run the cleanup, so this is not of major
importance)

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

--0j23Q8xBSVOQREWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkExWeAAoJEB2Cnv7KVigSjBoL/1LJSXjQCEUMxfeoHEV3/YwW
9qOOG44E7WTI7rhzFSTb3Z6oI/tLN7L3Bel+IXJ2K0nlM2kUpwF5P/TuCdRdPqwf
EVmrTxKkaSXedR1pJijnERop67nI18h/+vy4DC6t48CyBfLYQ38cEJ5OPvugRJf7
TDWsspxaE0QFlymnRv0QPN4DBGO6UC2Xu+OfZPWzOCcNyO9oMkRFv3mZsfXBbj2x
e9ZmQ3h+i1ek/YdYvHzk08M1U12j+9YX5oQZpyB+AKBH4ro+w3Bfw1YlMpUoFjZN
VFdNjcQbtnS69KwP0TsAk+4chvhS4fODGwnzmbTRHeHLH/xNhlojq+O/+faZYNpC
d5WCUxNC0owfn+H8iRYSNjfIpdNOZEl4kWBW3gtYc/qJg/c/lcIyCLiD08VSub8E
jUBADynS2zIdSQr0BlqQvnIXEvMY8k9wk67ImRuINDEwU5a355RhyMW+7HVZmSuX
dIVAlZqnS52T3STcWIq27aUCvhqUYzUADXbWZxUHrQ==
=IaxH
-----END PGP SIGNATURE-----

--0j23Q8xBSVOQREWN--

