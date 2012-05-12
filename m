MIME-Version: 1.0
In-Reply-To: <1336851105-24172-5-git-send-email-alon.barlev@...277...>
References: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
	<1336851105-24172-5-git-send-email-alon.barlev@...277...>
Date: Sat, 12 May 2012 22:34:21 +0300
Message-ID: <CAOazyz1zC1Lwv6APv9hUiEGSygV3MLEOmN6sVFsFWmEh-aQB-w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [V2.4 4/4] cleanup: tun: tun_engine interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

On Sat, May 12, 2012 at 10:31 PM, Alon Bar-Lev <alon.barlev@...277...> wrot=
e:
> Platform independent interface for tun provider.
>
> Split the long tun.c into platform specific files using
> tun_engine interface.
>
> There is more to be done in order to clean up the code,
> however this is a good starting point.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +
> =C2=A0src/openvpn/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 12 +
> =C2=A0src/openvpn/error.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0src/openvpn/forward.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 28 +-
> =C2=A0src/openvpn/helper.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0src/openvpn/init.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 41 +-
> =C2=A0src/openvpn/multi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0src/openvpn/options.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 20 +-
> =C2=A0src/openvpn/options.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 +-
> =C2=A0src/openvpn/route.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0src/openvpn/sig.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +-
> =C2=A0src/openvpn/syshead.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 56 -
> =C2=A0src/openvpn/tun-engine-common-bsd.c =C2=A0 =C2=A0 =C2=A0| =C2=A0103=
 +
> =C2=A0src/openvpn/tun-engine-common-bsd.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 34=
 +
> =C2=A0src/openvpn/tun-engine-common.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0518 +++
> =C2=A0src/openvpn/tun-engine-common.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 85 +
> =C2=A0src/openvpn/tun-engine-darwin.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0226 ++
> =C2=A0src/openvpn/tun-engine-dragonfly.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0193=
 ++
> =C2=A0src/openvpn/tun-engine-freebsd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0229 ++
> =C2=A0src/openvpn/tun-engine-generic.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 97 +
> =C2=A0src/openvpn/tun-engine-linux-options.h =C2=A0 | =C2=A0 37 +
> =C2=A0src/openvpn/tun-engine-linux.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0515 +++
> =C2=A0src/openvpn/tun-engine-netbsd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0318 ++
> =C2=A0src/openvpn/tun-engine-openbsd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0259 ++
> =C2=A0src/openvpn/tun-engine-options.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 37 +
> =C2=A0src/openvpn/tun-engine-solaris.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0491 +++
> =C2=A0src/openvpn/tun-engine-windows-options.h | =C2=A0 92 +
> =C2=A0src/openvpn/tun-engine-windows-util.h =C2=A0 =C2=A0| =C2=A0 83 +
> =C2=A0src/openvpn/tun-engine-windows.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2757=
 ++++++++++++++++
> =C2=A0src/openvpn/tun-engine.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 95 +
> =C2=A0src/openvpn/tun.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5019 ++----------------------------
> =C2=A0src/openvpn/tun.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0457 +---
> =C2=A032 files changed, 6542 insertions(+), 5282 deletions(-)
> =C2=A0create mode 100644 src/openvpn/tun-engine-common-bsd.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-common-bsd.h
> =C2=A0create mode 100644 src/openvpn/tun-engine-common.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-common.h
> =C2=A0create mode 100644 src/openvpn/tun-engine-darwin.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-dragonfly.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-freebsd.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-generic.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-linux-options.h
> =C2=A0create mode 100644 src/openvpn/tun-engine-linux.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-netbsd.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-openbsd.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-options.h
> =C2=A0create mode 100644 src/openvpn/tun-engine-solaris.c
> =C2=A0create mode 100644 src/openvpn/tun-engine-windows-options.h
> =C2=A0create mode 100644 src/openvpn/tun-engine-windows-util.h
> =C2=A0create mode 100644 src/openvpn/tun-engine-windows.c
> =C2=A0create mode 100644 src/openvpn/tun-engine.h
>

Too large for mailing list.
Please review at[1][2].

Alon.

[1] https://github.com/alonbl/openvpn/commit/c0c64bfa5369fb4abe7045a995fae2=
d33a34570f
[2] https://github.com/alonbl/openvpn/commit/c0c64bfa5369fb4abe7045a995fae2=
d33a34570f.patch

