Date: Sun, 21 Feb 2010 22:27:07 +0100
From: Bernhard Schmidt <berni@...376...>
Message-ID: <20100221212707.GA2349@...1293...>
References: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
MIME-Version: 1.0
In-Reply-To: <7bb795fd1002211100l760645cfl1a3cfc07ebd91e4@...278...>
Subject: Re: [Openvpn-devel] [PATCH] make ipv6_payload compile under
 windowze ( feat_ipv6_payload branch )
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: JuanJo =?utf-8?B?Q2lhcmxhbnRl4piA?= <jjo@...410...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Feb 21, 2010 at 08:00:27PM +0100, JuanJo Ciarlante=E2=98=80  wrote:

> This patch makes ipv6_payload successfully cross *compile*
> (and just that :) under my mingw32msvc setup on Linux.
>=20
> Because same syshead.h changes are already included in
> feat_ipv6_transport, it may merge-conflict applying it over
> allmerged once the latter includes ipv6_transport.
>=20
> Patch follows
> (also at http://github.com/jjo/openvpn-ipv6/commit/b7e46bd5ebfd4b55146299=
129e8b9813fab91b5e
> ):

Thank you very much, applied to my gert-ipv6 branch (at least I hope
so).

David, please pull gert-ipv6 from git://git.birkenwald.de/openvpn.git to
receive that change.

Bernhard


