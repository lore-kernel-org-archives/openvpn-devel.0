References: <1475613736-1529-1-git-send-email-lstipakov@...277...>
	<842a27b1-8ce3-db91-2c76-71cfc705e1eb@...1435...>
	<20161005123444.GS78279@...1296...>
	<CAGyAFMUvHvgFTH4=M2OrcpnZFKuXq3r6Rb4DcL4KHXS353wcGg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b27f550d-4bd1-1362-897e-1f10a4a6b576@...2080...>
Date: Wed, 5 Oct 2016 20:25:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAGyAFMUvHvgFTH4=M2OrcpnZFKuXq3r6Rb4DcL4KHXS353wcGg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2.3] Fix compilation in pedantic mode
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/10/16 17:29, Lev Stipakov wrote:
> Hi,
>=20
>=20
> I am, and the first version is what we do in (most?) other places,=20
> so I'll change that on the fly.
>=20
>=20
> Got it.
>=20
>=20
> Also, the patch introduces spurious tab<->whitespace changes "close
> to comments" in a few places - will undo those, too.
>=20
>=20
> I noticed that in few places indentation is a bit off - like 8=20
> whitespaces instead of tab so I decided to "fix" it.
>=20
> Should I just ignore those things or do it in separate PR?

Currently I think we can leave them.  Before the release of 2.4-RC we
will do a lot of coding style fixes to the whole source tree, so that
we have one unified coding style over the whole code base in both the
new releases/2.4 and master branch.

The Hackathon in Munich 2014 [1] decided on the the Allmann style [2].
 The only thing I'm not sure we agreed upon is the indent size (4 or 8
spaces), in addition to the line length which is not that explicitly
agreed upon.

[1] <https://community.openvpn.net/openvpn/wiki/MunichHackathon2014>
[2] <https://en.wikipedia.org/wiki/Indent_style#Allman_style>


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX9UWvAAoJEIbPlEyWcf3ytj4P/iuXf+htHtFjQfE9/QSWY/Ui
+jpF1kqlAKac6eS1t0cN1OYVUmXZwNkZjGNKYl8vi9zVSciZf2rFslTAhaaRLuWW
LMtL1MxGJbADvLpKkHPfvSNk3ITXxhnMKjgXqzxnPY2WeyV7f48jKOUeBma3RY1R
m4hT8Hg0Im2cqVmU9XRDvEc3u0EqTKzA/NP6sKO1dWut05ZwKlIyUknsJfLoZyEx
OPghZaTgFmz0YZKQqam0cenkL2g3cYuz60GQw8Lpio6GFLQMMbjV9fRpdIJ4d36W
qIdulNh+idXDvuSe3bFFQqYItdUIIgaBvz8dUDCubz47OR6vkTD+/+KR0f4F5C/9
HHt1CW4GAs5AEvFpF9BhPoxajQHNjoZsrWOL+YgumVKcTUclgd/iUoRTBusSF87H
fYp/b7XjLO1cr1QPprK0szzNQB4HMFx3aVxZlvhC8WePN+uO8a6X55g08pnuy7kS
PQ5nrfOywwQsqhl9p9E5lFV2HoeIfxGkwjoq4xztGI9xyV3jFroaqn4cN9314+aF
RREgmCYInDEZzVXjqFCC/0isgEXOYdC/p6Hpy6EWzCecFf8fm1Gs4CQnhodR7Min
QyKZhhC/yAXgOKuEKCPw+NY+eulE1VwRmIBEJujKgeVBNVIoaQc43wEARIYhTdcO
SrffianKpvhWJiPjLRUd
=3DTF/Z
-----END PGP SIGNATURE-----

