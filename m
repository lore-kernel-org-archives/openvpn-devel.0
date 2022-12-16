Message-Id: <1671184804470.774255658.1294140792@...68...>
From: Marc Becker <becm@...68...>
Date: Fri, 16 Dec 2022 10:19:20 +0000
In-Reply-To: <20221216090717.1082-1-lstipakov@...277...>
References: <20221216090717.1082-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] git-version.py: use tag as branch name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> From: Lev Stipakov <lev@...515...>
>=20
> Git magic to get branch name
>=20
>   git rev-parse --symbolic-full-name HEAD
>=20
> doesn't work when we're on tag, which is the case when
> we build releases. In this case, use tag name as branch name
> with another git magic:
>=20
>   git describe --tags
>=20
> This fixes https://github.com/OpenVPN/openvpn/issues/199.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---


For me, reason for "rev-parse" failing is detached HEAD (not clear from com=
mit message).
Likely, builder creates checkout for commit-ID without local branches.

For stability purposes, I'd throw in an "--exact-match" to increase "none" =
fallback conditions,
so things like "v2.6_beta1-22-g73cab722/g73c=E2=80=A6" will not end up in t=
he version string.


Kind Regards,
Marc Becker

