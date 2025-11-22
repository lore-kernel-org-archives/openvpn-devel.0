Date: Sat, 22 Nov 2025 22:41:46 +0100 (CET)
Message-Id: <202511222141.5AMLfkm2053216@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251122185239.26312-1-gert@...1296...>
References: <20251122185239.26312-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi-socket: remove
 duplicated/dead code
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for working on the cleanup - I can see where this came from
(the multisocket patch, and the remodelling of the event info that
came with it).  Especially the ASYNC_PUSH stuff got duplicated
(FILE_CLOSED in the other patch) and I can see the other handler
for incoming TCP sockets.

I have run this through the server side testbeds on Linux with and
without DCO, and everything still works (and this does excercise the
TCP listening code and also the async file stuff).

Your patch has been applied to the master branch.

commit 779ab39d88c8ac83c67b69741d80b79a4587ad25
Author: Gianmarco De Gregori
Date:   Sat Nov 22 19:52:33 2025 +0100

     multi-socket: remove duplicated/dead code

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1384
     Message-Id: <20251122185239.26312-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34593.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


