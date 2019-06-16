Date: Sun, 16 Jun 2019 10:35:30 +0200 (CEST)
Message-Id: <201906160835.x5G8ZUxu088510@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190615230213.14888-2-a@...2181...>
References: <20190615230213.14888-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_net.sh: properly perform sudo
 check and print test steps
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"because it makes sense" :-) - for added point, the declarations of
KILL_EXEC= and CC= could also be removed.  And the comment about 
Solaris...  dead code...

Your patch has been applied to the master branch.

commit 6f89dac0ed8b84bc581ceda710c506be2287f2b5
Author: Antonio Quartulli
Date:   Sun Jun 16 01:02:13 2019 +0200

     t_net.sh: properly perform sudo check and print test steps

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190615230213.14888-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18548.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


