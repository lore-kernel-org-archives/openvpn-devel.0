Date: Wed, 10 Jun 2020 12:36:23 +0200 (CEST)
Message-Id: <202006101036.05AAaNEg026888@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200610084549.4028-1-a@...2181...>
References: <20200610084549.4028-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: skip IPv4 logic in
 multi_select_virtual_addr() if no pool is configured
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

The patch is quite trivial - if seen with "git show -w" :-) - it basically
just encapsulates the whole "the pool has returned something, how does
it need to be wrapped for pushing out?" into "is there an IPv4 pool at all?".

Tested on the t_server setup - warnings are gone, and ccd/ifconfig-push still
works (which it should, on no-v4-pool or no-pool-at-all setups).

Your patch has been applied to the master branch.

commit 9002885bd8a10d9375dc4f0baf2df05395c86f1a
Author: Antonio Quartulli
Date:   Wed Jun 10 10:45:49 2020 +0200

     multi: skip IPv4 logic in multi_select_virtual_addr() if no pool is configured

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200610084549.4028-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20012.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


