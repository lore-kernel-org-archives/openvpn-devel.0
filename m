Date: Sun, 19 Mar 2017 19:14:57 +0100 (CET)
Message-Id: <201703191814.v2JIEvwC034357@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170127142120.10492-1-davids@...515...>
References: <20170127142120.10492-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: plugin: Improve the handling of
	default plug-in directory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  The code change is straightforward enough :-) and makes sense.

(And it brings LOTS of documentation, which is always welcome).

As a side note: the behaviour on Windows is different from the behaviour
on Unix now (actually, since the introduction of PLUGIN_LIBDIR), so this
might warrant revisiting.

Your patch has been applied to the master and release/2.4 branch.

commit f9609f1df9d8c070245b7c008dc54ac9ccdbe231 (master)
commit d21bed998bca21ab44e769896b0e9a8b4bfc0be1 (release/2.4)

Author: David Sommerseth
Date:   Fri Jan 27 15:21:20 2017 +0100

     plugin: Improve the handling of default plug-in directory

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170127142120.10492-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13970.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


