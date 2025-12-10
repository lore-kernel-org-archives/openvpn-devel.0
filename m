Date: Wed, 10 Dec 2025 10:17:00 +0100 (CET)
Message-Id: <202512100917.5BA9H04l007272@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251210075906.27693-1-gert@...1296...>
References: <20251210075906.27693-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: set IPv4 address
 temporary on Windows
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

Arguably this is a bug, but it's a bug in a dark corner of a niche use
case - *if* running OpenVPN on windows with privileges, *and* not using
DHCP but "ip-win32 netsh", *and* still using IPv4, then we install the
IPv4 address using no explicit "store=<nnn>" command - which defaults to
"permanent" (unlike "ip address add ..." on a unixoid system, which is
never persistent) - so the IPv4 address sticks across reboots.

First mistake... and then, on session end, we try to remove it with
"store=active" - which makes it go away *up to the next reboot*, and
then it's back, possibly interfering with future uses.

So this patch adds the "store=active" to the netsh.exe call inside
openvpn.exe for IPv4.  This will fix it for all future assignments, but
not for "existing leftovers" - these will need to be fixed manually (once).

(One of the grand plans for 2.8 is "rip out all this from openvpn, only
support a single method, which is IPAPI via interactive service" - but
for 2.7 and 2.6, this is a bug that needs to be fixed short term)

The backport to 2.6 is trivial, though "cherrypick" does not work out of
the box due to the clang-reformat of the function call.


This said, I have not actually *tested* it, beyond "does it compile" - the
issue is clearly understood, the fix is clear, and it's just a string
change (as far as openvpn is concerned).


Your patch has been applied to the master and release/2.6 branch (bug).

commit 93c9b47cb0916c16ef76e6ecb5bf3f2ba7d267aa (master)
commit 3aacb621b56015f92cc0ae79987fa29c33842a2d (release/2.6)
Author: Lev Stipakov
Date:   Wed Dec 10 08:59:00 2025 +0100

     tun.c: set IPv4 address temporary on Windows

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1430
     Message-Id: <20251210075906.27693-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34975.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


