Date: Wed, 1 Jul 2020 16:33:19 +0200 (CEST)
Message-Id: <202007011433.061EXJMZ033636@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200701140517.11176-1-a@...2181...>
References: <20200701140517.11176-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi.c: use mi->cc_config
 instead of config variable
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

Test compiled.  Stared at code.  Grumbled.  Ran a small t_server test
("just to be sure").

Your patch has been applied to the master branch.

commit 712f2629c8406c017931a082cd996b439b5dfdc9
Author: Antonio Quartulli
Date:   Wed Jul 1 16:05:17 2020 +0200

     multi.c: use mi->cc_config instead of config variable

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200701140517.11176-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20180.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


