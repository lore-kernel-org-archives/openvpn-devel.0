MIME-Version: 1.0
Date: Sun, 8 Apr 2012 13:43:12 +0300
Message-ID: <CAOazyz1Uy_SxZCjdQ5oA1SAS+yjNC3i23BgMPDBr_gSFD+h_Rg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] [RFC] tun cleanups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello,

I started to work on the syshead cleanups, then found my-self
evaluating the tun.c complexity, and prioritize it.

So basically we have two branches:
https://github.com/alonbl/openvpn/compare/master...syshead
https://github.com/alonbl/openvpn/compare/master...tun

The tun branch is based on the syshead branch.

---
    cleanup: tun: tun_engine interface

    Platform independent interface for tun provider.

    Split the long tun.c into platform specific files using
    tun_engine interface.

    There is more to be done in order to clean up the code,
    however this is a good starting point.

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---

What I am asking is for people that wishes to work with me on this
(not the ACK/NACK approach) to allow perfecting this *BEFORE* merge.

Even if you build and test on various of platforms and report back the
result it would be great, of course, code review will be welcome, it
is a huge change, so review this as a whole would be simpler.

You can see the majority of the work in tun.h, tun.c, tun-engine*.

Is anyone interested in helping?
Alon.

