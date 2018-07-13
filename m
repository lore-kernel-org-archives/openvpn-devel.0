Date: Fri, 13 Jul 2018 12:19:09 +0200 (CEST)
Message-Id: <201807131019.w6DAJ9Un047014@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180712012955.24050-1-a@...2181...>
References: <20180712012955.24050-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: make stream_buf_*
 functions static
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

"Having local code self-contained is good" - visually tested, and 
t_client test runs.  Thanks for bearing with me :)

Your patch has been applied to the master branch.

commit 62c0455e0fd48b4640251dc879c25d4f66ae3ed2
Author: Antonio Quartulli
Date:   Thu Jul 12 09:29:55 2018 +0800

     socket: make stream_buf_* functions static

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180712012955.24050-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17246.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


