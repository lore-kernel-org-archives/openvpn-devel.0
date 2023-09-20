Date: Wed, 20 Sep 2023 22:35:45 +0200 (CEST)
Message-Id: <202309202035.38KKZjNE092635@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230920121519.177949-1-frank@...2641...>
References: <20230920121519.177949-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: fix broken daemonization
 and syslog functionality
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

I have not tested it further, given that it has plenty of ACKs (and
only affects cmake build system).

Two observations, though - the cmake changes look incomplete, there
is still many "#undef HAVE_something" left.  Shouldn't they all be
completed to "#cmakedefine" for this to make sense?

Second, while not really relevant on Linux or *BSD, erroring-out
in daemon() on chdir("/") fail is not what either manpage documents -
and I do not think chdir("/") (as root) can ever fail.  So changing the
code flow just to silence the compiler feels a bit meh - doing a (void)
there would have silenced it just fine.  But as I said it's not 
truly relevant.

What OS were you building anyway that you hit an error in compat-daemon.c
(aka "are we missing a cmake test for daemon()")?

commit 8ae6c48d5d52dec8ec6e47cc1cfe89de9f2ffbcd (master)
Author: Lev Stipakov
Date:   Wed Sep 20 14:15:19 2023 +0200

     CMake: fix broken daemonization and syslog functionality

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230920121519.177949-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27045.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


