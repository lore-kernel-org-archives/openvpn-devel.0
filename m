Date: Mon, 16 Jan 2023 10:45:31 +0100 (CET)
Message-Id: <202301160945.30G9jVX7036452@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230115164818.1973210-1-selva.nair@...277...>
References: <20230115164818.1973210-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Define and use macros for route
 addition status code
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for this.  I think it makes the code easier to read and understand,
and having "the same constructs" used everywhere also helps with this
(and thus, hopefully, less platform specific confusion in future ;-) ).

I have stared at the code, manually double-checked "0 -> ERR, 1 -> SUCCESS,
2 -> EEXIST" etc., and then fed the patch to github actions (which will
do MacOS, Windows and Linux builds) and to buildbot, which will cover the
more exotic platforms (FreeBSD, NetBSD, OpenBSD, OpenSolaris).  AIX, I
compile-tested myself :-)

WRT uncrustify, my local version (0.72.0_f) says "this is all fine".
Unfortunately, different versions of uncrustify produce slightly different
output (and the most recent versions seem broken for OpenVPN source
code).  A problem to be solved, but not this week.

Your patch has been applied to the master and release/2.6 branch.

commit 328cc40c8368a9e1f9abc92eb4d34687470e3a92 (master)
commit 39dd79d865daac679497d705b4bc18170d0746dc (release/2.6)
Author: Selva Nair
Date:   Sun Jan 15 11:48:18 2023 -0500

     Define and use macros for route addition status code

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230115164818.1973210-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26041.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


