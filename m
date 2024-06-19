Date: Wed, 19 Jun 2024 11:55:10 +0200 (CEST)
Message-Id: <202406190955.45J9tAhk055097@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240315162011.1661139-1-frank@...2641...>
References: <20240315162011.1661139-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement server_poll_timeout
 for socks
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
To: 5andr0 <sandro.trianni@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Took me long enough, but now it's in :-) - thanks, and thanks ValdikSS
for reporting test success.

I've run this on the server side test bed (which will not excercise SOCKS
paths, but to verify that "nothing unrelated got hit") and on the client,
with a few SOCKs proxy tests.  These are all "fast proxies" so do not
excercise the new timeout handling - and I did not find time to build
something with dummynet to make it actually test on a "really slow proxy".

Testing using an unreachable IP didn't yield proper results (because
the TCP connect is still goverened by the "base" timeout), so you
need something which answers TCP/1080, and then "is slow"...

Testing using a "dead" netcat 'socks server' ("nc -k -l 1080") leads to

  - old code: give up after 5 seconds ("TCP port read timeout"), always
  - new code: respect --connect-timeout (shorter or longer than 5s)

Your patch has been applied to the master and release/2.6 branch
(I consider it a bugfix, and while the code touches a few places, it
only really changes very localized socks.c code).

commit b3a68b85a729628ca8b97f9f0c2813f795289cfc (master)
commit 94bfb712366ece1ca3605d18e99580f482f0232b (release/2.6)
Author: 5andr0
Date:   Fri Mar 15 17:20:11 2024 +0100

     Implement server_poll_timeout for socks

     Signed-off-by: 5andr0 <sandro.trianni@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240315162011.1661139-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28408.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


