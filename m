Date: Mon, 14 Sep 2020 12:21:36 +0200 (CEST)
Message-Id: <202009141021.08EALaba065309@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200909183012.7504-1-davids@...515...>
References: <20200909183012.7504-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: man: Improve --remote entry
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I've compared this to the 2.4 man page, and it is indeed easier
to read and less unclear this way.

As written already, one day we need to go through the man pages
and throw out all NOTEs that refer to --secret mode, or clarify
what "running without --remote" really means...

Your patch has been applied to the master and release/2.5 branch.

commit 97ff64360745d27004e97043507ac788db23799c (master)
commit d1a7d83fe691d0cb4cfcc35085bfb8ded0396141 (release/2.5)
Author: David Sommerseth
Date:   Wed Sep 9 20:30:12 2020 +0200

     man: Improve --remote entry

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200909183012.7504-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20935.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


