Date: Wed, 18 Sep 2019 15:13:50 +0200 (CEST)
Message-Id: <201909181313.x8IDDo8i018945@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1568019436-28527-1-git-send-email-lstipakov@...277...>
References: <1568019436-28527-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.h: remove TUN_PASS_BUFFER
 define
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Not sure if it increades readability very much, given that the 
functions are still called "..._buffered()", and what they really do is
"..._win32_special_asyncio_using_packet_buffer_from_event_loop()"
(if I read tun.h/tun.c right).  

But it's certainly not making things worse :-)

commit daaa43941c7fa3b7689a5abcbd4e8e30f63856d2
Author: Lev Stipakov
Date:   Mon Sep 9 11:57:16 2019 +0300

     tun.h: remove TUN_PASS_BUFFER define

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1568019436-28527-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18808.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


