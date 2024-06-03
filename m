From: Franco Fichtner <franco@...2219...>
Date: Mon, 3 Jun 2024 07:17:17 +0000
Message-ID: <584A0CC6-37B0-4816-8F86-A3027D9D7290@...2219...>
References: <AE20A784-506C-488B-9302-2D3AE775B168@...2219...>
 <202406021550.452FoU3I061198@...2054...>
In-Reply-To: <202406021550.452FoU3I061198@...2054...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Allow to set ifmode for
 existing DCO interfaces in FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-ID: <D84E975E3FA64143AC0A0B3B68E55BA4@...2802...>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Gert,

> On 2. Jun 2024, at 17:50, Gert Doering <gert@...1296...> wrote:
>=20
> work correctly (without it, p2p ifconfig claims to work but ipv6 route
> addition fails as well).

I did not notice but all the better.

> There is a slight catch - if the interface (ovpn3) has already been
> brought "up", the dco_set_ifmode() call fails with=20
>=20
>  2024-06-02 14:54:06 dco_set_ifmode: failed to set ifmode=3D00008002: Dev=
ice busy (errno=3D16)
>=20
> .. so it will not work properly in all cases.

I mentioned this in the original work patch on our end:

https://github.com/opnsense/ports/commit/2dc9273a03577

However, I believe something on the OpenVPN end changed in 2.6
for DCO related changes prior as we ran into these integration
bugs:

https://github.com/opnsense/core/commit/c22f74a786

Which indicate the daemon stops working properly in these cases
anyway. This appeared to be a general problem, not directly related to
DCO as we weren't using it / lacked support on FreeBSD 13 at the
time. Did not dive too much into the OpenVPN code but it did verify
the suspicion and this needs to be addressed from the user side now
which is more than reasonable.

> The patch got badly whitespace mangled in transit (empty lines got
> turned into extra indent in the following line, and thus).  As I said
> on IRC, I'm happy to fix that for occasional submitters, but generally
> recommend "git send-email" or pushing to gerrit to avoid outlook induced
> garbage.

I'll improve my process for the next one. Thanks!


Cheers,
Franco

