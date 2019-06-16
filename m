Date: Sun, 16 Jun 2019 10:28:27 +0200 (CEST)
Message-Id: <201906160828.x5G8SRWD087627@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190615230213.14888-1-a@...2181...>
References: <20190615230213.14888-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_net.sh: make bash dep
 explicit and run only if SITNL is compiled
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

Does what it says and fixes "make check" errors on platforms that either
have a non-bash in /bin/sh, or are not compiled with SITNL.  (As a side note,
the claim "this is fine on most distros" is one of the aspects that annoys
me very much as a sysadmin - it is *never* fine to call /bin/sh and assume
you can get any sort of functionality that is more than POSIX sh that way.
Even if it works on your Linux system and that of your friend, it is still
not *fine*, it will just cause annoyance for other people)

Your patch has been applied to the master branch.

commit af7d6d78ad5db7d538d908df42e03a8d1baa1708
Author: Antonio Quartulli
Date:   Sun Jun 16 01:02:12 2019 +0200

     t_net.sh: make bash dep explicit and run only if SITNL is compiled

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190615230213.14888-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18547.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


