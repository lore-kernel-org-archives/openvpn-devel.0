Date: Sun, 11 Oct 2020 18:02:20 +0200 (CEST)
Message-Id: <202010111602.09BG2K7j012945@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201005091805.17260-1-arne@...1227...>
References: <20201005091805.17260-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore deprecation warning for
 daemon on macOS
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"unavoidable warnings are less useful than no warnings at all" -
so as a temporary measure, this makes sense.  Longterm, one could
see whether a "platform_daemon()" call makes sense...  

(From how I read the posix_spawn(3) manpage, it latter is more intended 
to replace fork()/exec() combos... not sure how that would help with
daemonizing [controlling tty and that]... daemon(3) suggests that Apple 
does not want people to start daemons by hand at all, using launchd(8)
instead...  and I agree that *that* would need a totally different
approach to "start openvpn")

Tested on Mojave: fixes the warnings in init.c and down-root.c.

Your patch has been applied to the master branch.

commit a480eaae1d32a6c3970911a561a64c1019944f92
Author: Arne Schwabe
Date:   Mon Oct 5 11:18:05 2020 +0200

     Ignore deprecation warning for daemon on macOS

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201005091805.17260-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21171.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


