Date: Sun, 19 Jul 2020 20:40:36 +0200 (CEST)
Message-Id: <202007191840.06JIeah2068901@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200719173436.16431-1-arne@...1227...>
References: <20200719173436.16431-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove CAS_PARTIAL state
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

Reviewed, change makes sense.  Even better, it makes my torture test
setup (client-connect script, client-connect plugin, client-connect-v2
plugin) which can inject arbitrary "FAIL" or "disable" at any of these
points work as requested - while not breaking other tests.

  Test sets succeeded: 5 5v 5w1 5w2 5y 5z.

(These are the interesting tests, that test "the server instance with
client-connect script *and* plugins, and the 5-with-letter are "dear
server, please fail my connection *here* and *there*" :-) - the other
instances have no plugins, just basic client-connect files or "nothing
at all", but I've tested them anyway - success)

Your patch has been applied to the master branch.

commit 82241468cb631e7a06a213198a3a13734c6a091e
Author: Arne Schwabe
Date:   Sun Jul 19 19:34:32 2020 +0200

     Remove CAS_PARTIAL state

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200719173436.16431-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20482.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


