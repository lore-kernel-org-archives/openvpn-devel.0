Date: Sat, 17 Feb 2024 17:39:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZdDhMBZMGX_zot34@...1296...>
References: <Zczam85nBDgD74kE@...2685...>
 <kiuEvfPhyMr8TQIYBbooBK7BOnaHm4Bi18X2pO0ujjEIrGEPSONav0DnpYy97JLoHgDW5vfjaD4amWbxlodG75qHQqtzjjAfFzRci4gbCh4=@protonmail.com>
 <Zc9vKS0P2eUMswyM@...2685...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="93tMeFdPrjdLGEJK"
Content-Disposition: inline
In-Reply-To: <Zc9vKS0P2eUMswyM@...2685...>
Subject: Re: [Openvpn-devel] IRC community meeting summary (Feb 14th)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: tincantech <tincantech@...2282...>, openvpn-devel@lists.sourceforge.net

--93tMeFdPrjdLGEJK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 16, 2024 at 03:20:25PM +0100, Frank Lichtenheld wrote:
> Note that none of this negates the usefulness of easy-rsa. This
> is specifically about the usefulness of easy-rsa bundled in the
> openvpn Windows installer.

Yeah, this.  I find easy-rsa very useful - but my CAs are not running
on a Windows system (the thought alone makes me shiver) but securely
tucked away on a Unix VM, with easy-rsa, of course.

So, for my environment (various customer deployments plus my own
dabbling) I do not need easy-rsa on Windows, and wouldn't miss it
if you (as in "the installer maintaining folks") decided to drop it.

I seem to remember that we did this split on the unix side some
100 years ago already - so now distributions have "openvpn" and
"easy-rsa" packages, and both can be updated and maintained according
to their own needs...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--93tMeFdPrjdLGEJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJl0OEwAAoJEB2Cnv7KVigSqoML/jpmqo/LOWOirHRmAgvJKEOX
UZfokAjPzp2Uionat0jpVJI/SPNjvxXpUmWwhd0wemM3fYncSfwOn80tfXYrhQhq
ddNeDs96eO0mhm997fgemFAeBKSUd+7xYFc2+EhTIr7kgm3lQ/602aPuEfHoYQJC
atePYKG/wSmsqv8Uh0uTRjeaKndCVGQzxfXoo9lqfQDnMcEb4RLw9r6EaRY3ZEvu
6j0jO0128uoE7niD2E27HONGy68JxmDo53vREutMulI88QkgMaZglQz35Y7FkQCG
x1Zx33BMNawq4ZziJ2FhBnAckH7i4hPIXMmx388uEP5HYXQ7k4VgkwGT/Xs4BmMy
pdBGp5iLVWrTfPY2kBITrNbBiJDuv6UsA6sMPPkKGDYmTnhdNjR6UoN50AyEHH+m
GjtyJQAsT1gXUKWpdExG6e6WOL+h5HPEwND7jtL41YDkj91R7cHyt4akKK/PYndz
KTW6p3yX/STosMbJXbDuOoynyWnqyoEc4DBywi9+5Q==
=V9H4
-----END PGP SIGNATURE-----

--93tMeFdPrjdLGEJK--

