Date: Sat, 13 Aug 2022 10:18:58 +0200 (CEST)
Message-Id: <202208130818.27D8Iw1u036676@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220812130657.29899-2-a@...2181...>
References: <20220812130657.29899-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: do_open_tun: restyle 'can
 preserve TUN' check
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

This one really needs "git show -w"... and indeed, the old one was
amazingly ugly, including "confusing uncrustify enough so the 'else'
with no indent happened"...

Client-tested on Linux.

Your patch has been applied to the master branch.

commit bd139689a4d2f813081aaf93149eabee8d941731
Author: Antonio Quartulli
Date:   Fri Aug 12 15:06:48 2022 +0200

     do_open_tun: restyle 'can preserve TUN' check

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220812130657.29899-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24884.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


