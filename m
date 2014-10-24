Message-ID: <544A5AC5.4060808@...1114...>
Date: Fri, 24 Oct 2014 15:57:25 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>	<53B03B43.2040009@...1227...>
	<53BD10EB.9010509@...1227...>	<alpine.DEB.2.02.1408121108120.3669@...1831...>	<CAGyAFMVzDaygh1d-jtZSRXYqq+hm5qphmtEQE8f7eyhpD8Am_w@...278...>	<5436E6E5.8060002@...1856...>	<CAGyAFMUQnZYLNAeLeAw4SR7zJgmqc1k+mgEwBKwL+TXLAOU2ZA@...278...>	<5448B3C9.4010403@...1435...>	<CAGyAFMWNSP25mqjNLW0w=fjHNWwZjrLnY7uc7LMhw1Ds+Z5kmA@...278...>	<CAGyAFMU5VN1xwx1r1xEqHVHS5NjPqTDcP1P_o_HuvgO6q=MwiA@...278...>
	<20141024132041.GB396@...1296...>
In-Reply-To: <20141024132041.GB396@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vViQeIcojdxNm1QwBbnH90S10BNsuhlgJ"
Subject: Re: [Openvpn-devel] session-id implementation
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vViQeIcojdxNm1QwBbnH90S10BNsuhlgJ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 24/10/14 15:20, Gert Doering wrote:
[...snip...]
> ... please don't do whitespace changes in places where no code changes
> (as it makes it harder to see where changes happened)
[...snip...]
> Here's an escaped tab-to-space conversion or so, but "just whitespace=20
> change" nonetheless.
[...snip...]
> Whitespace...

As there were a lot of "whitespace" issues here, I'd recommend you to
enable colours in git.  This will highlight many of the whitespace
issues here.  Just add this section to either your global git config
(~/.gitconfig) or directly your git tree config (.git/config):

[color]
        branch =3D auto
        diff =3D auto
        log =3D auto
        interactive =3D auto
        status =3D auto
        pager =3D true

Some might find it useful to also have this:

[core]
        pager =3D less -X -R -F


When the patch is "complete", it would also help us maintainers if you
do 'git add' on the files you've changed (see git status) and then do a
commit (git commit -s) with a describing commit message (describe the
patch in a non-technical manner [1]).  Then you can use 'git
format-patch HEAD~1' to get the last commit as patch.  See our quick git
crash course [2] for more things you can do with git, like sending mails
directly from gi.

[1] <http://who-t.blogspot.no/2009/12/on-commit-messages.html>
[2] <https://community.openvpn.net/openvpn/wiki/GitCrashCourse>


--=20
kind regards,

David Sommerseth


--vViQeIcojdxNm1QwBbnH90S10BNsuhlgJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlRKWskACgkQDC186MBRfrq6MACgmWqUYcMdS6QGV2MROADk0SQf
kTQAoJWUW60CopsX9CmyNBqwo6ItzxX0
=5D+p
-----END PGP SIGNATURE-----

--vViQeIcojdxNm1QwBbnH90S10BNsuhlgJ--

