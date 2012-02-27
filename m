Message-ID: <4F4B4B44.4070502@...1114...>
Date: Mon, 27 Feb 2012 10:22:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-14-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-14-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 13/35] Remove tap-win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 02:22, Alon Bar-Lev wrote:
> Introduce tap-win32.h which is modified tap-win32/common.h. Except of
> function rename, it is the same without the tap_id. This file should
> be provided as part of tap-win32 MSI. For now we hold a copy.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- Makefile.am
> |    3 +- configure.ac                   |   14 +- tap-win32/MAKEFILE
> |    6 - tap-win32/SOURCES.in           |   64 - tap-win32/common.h
> |   82 -- tap-win32/constants.h          |   52 - tap-win32/dhcp.c
> |  599 -------- tap-win32/dhcp.h               |  164 --- 
> tap-win32/endian.h             |   35 - tap-win32/error.c
> |  378 ----- tap-win32/error.h              |   88 -- 
> tap-win32/hexdump.c            |   69 - tap-win32/hexdump.h
> |   63 - tap-win32/i386/OemWin2k.inf.in |  195 --- 
> tap-win32/instance.c           |  241 --- tap-win32/lock.h
> |   75 - tap-win32/macinfo.c            |  154 -- tap-win32/macinfo.h
> |   38 - tap-win32/mem.c                |  186 --- tap-win32/proto.h
> |  224 --- tap-win32/prototypes.h         |  260 ---- 
> tap-win32/resource.rc          |   58 - tap-win32/tapdrvr.c
> | 3146 ---------------------------------------- tap-win32/types.h
> |  178 --- tap-windows.h                  |   68 + tun.h
> |    2 +- win/autodefs.h.in              |    2 +- 27 files changed,
> 78 insertions(+), 6366 deletions(-) delete mode 100755
> tap-win32/MAKEFILE delete mode 100755 tap-win32/SOURCES.in delete mode
> 100755 tap-win32/common.h delete mode 100755 tap-win32/constants.h 
> delete mode 100755 tap-win32/dhcp.c delete mode 100755
> tap-win32/dhcp.h delete mode 100755 tap-win32/endian.h delete mode
> 100755 tap-win32/error.c delete mode 100755 tap-win32/error.h delete
> mode 100755 tap-win32/hexdump.c delete mode 100755
> tap-win32/hexdump.h delete mode 100755 tap-win32/i386/OemWin2k.inf.in 
> delete mode 100755 tap-win32/instance.c delete mode 100755
> tap-win32/lock.h delete mode 100755 tap-win32/macinfo.c delete mode
> 100755 tap-win32/macinfo.h delete mode 100755 tap-win32/mem.c delete
> mode 100755 tap-win32/proto.h delete mode 100755
> tap-win32/prototypes.h delete mode 100755 tap-win32/resource.rc delete
> mode 100755 tap-win32/tapdrvr.c delete mode 100755 tap-win32/types.h 
> create mode 100644 tap-windows.h


ACK.  The Windows TAP driver will be moved to a separate git repository,
so this again makes a lot of sense.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LS0IACgkQDC186MBRfrqvOgCgrk42BkzoFKemGFCW/tXZtdti
IwkAn2FiVqsYdK59F1C4hqxq39AfR58T
=ODEe
-----END PGP SIGNATURE-----

