Date: Thu, 19 Dec 2019 20:40:32 +0100 (CET)
Message-Id: <201912191940.xBJJeWiQ033380@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191113104216.1545-1-lstipakov@...277...>
References: <20191113104216.1545-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: refactor open_tun()
 implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have test built on Ubuntu 1604/mingw (works).  No further tests.

Thanks for the refactoring.  It's a good basis for further cleanup.

I have *not* tried to follow this in full detail, trusting Simon 
on this.   What I did do is verify it's all inside WIN32, so it
won't affect other platforms.

What we *will* need to do when you're done with your tun.c-massacre is 
to run a full set of IPv4/IPv6/dual-stack test with all then-supported 
--ip-win32 methods for tap6 and wintun to see if we broke something
in an unexpected way - like "ipv6-only no longer working for default
configs", etc. - this will be an interesting test matrix for Samuli's
windows test rig to set up...  IPv4/IPv6/dual-stack, topology p2p vs.
topology subnet, tap6/tun vs. tap6/tap vs. wintun (= 18 combinations
for each --ip-win32 method).  Yay.

Also, it might be a good excercise to give the resulting tun.c a more
thorough review (when done) - independent of the individual patches
that move "bits from here to there", try to grok the logical flow for
each method, and see if it's logical at all...


Code-wise, I think we should factor out the "flush_neighbors_message"
bit of tuntap_set_ip_addr() - all other iservice functions are really
isolated "fill the structure, do the message handling", not integrated
into a larger function.  This is not new code, but reading through it,
I found it causes itching :-)


commit 509c45f6e6885f4c2d413aa8e0189513098b3dcc
Author: Lev Stipakov
Date:   Wed Nov 13 12:42:16 2019 +0200

     tun.c: refactor open_tun() implementation

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20191113104216.1545-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19137.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


