Message-ID: <4ed6da08-1da4-3c2f-1f66-ddadd5bf209d@...68...>
Date: Sat, 28 Jan 2023 23:38:38 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230127203208.305638-1-matthias.andree@...68...>
 <202301281855.30SItQBc022056@...2054...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <202301281855.30SItQBc022056@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: make dist: Ship
 ovpn_dco_freebsd.h, too
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 28.01.23 um 19:55 schrieb Gert Doering:
> Acked-by: Gert Doering <gert@...1296...>
>
> To see the actual failure, one needs to build a tarball ("make dist"),
> and from that tarball, compile with "configure --enable-dco", on FreeBSD
> - so a pure "make distcheck" did not see it.  Apologies for that oversigh=
t.
>
> Your patch has been applied to the master and release/2.6 branch.

Hi Gert,

Danke.

We could set AM_DISTCHECK_CONFIGURE_FLAGS=3D--enable-dco (and possibly
other --enable-* or -with-*) in the relevant Makefile.am though if you
want a more complete feature set in "make distcheck".

Cheers,
Matthias


