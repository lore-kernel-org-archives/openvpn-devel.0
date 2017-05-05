Date: Fri, 5 May 2017 21:11:55 +0200 (CEST)
Message-Id: <201705051911.v45JBtcT020111@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1494006291-3522-1-git-send-email-steffan.karger@...1435...>
References: <1494006291-3522-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: cleanup: merge
	packet_id_alloc_outgoing() into packet_id_write()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks, plus

20:39 <@dazo> cron2: you can add ACK on me too on that one, I believe it is the 
              same we've already reviewed

"Stared at code", plus "passed all my client tests" plus "adds cmocka 
tests which are really useful for that stuff" (and they pass :) ).

.. and this is a real improvement to the code - it just removes lines,
and intermediate variables.  Too much magic, that is not needed.


Your patch has been applied to the master and release/2.4 branch.

Backporting to release/2.3 is not a trivial matter of "there is whitespace",
but it seems infrastructure is missing (CRYPT_ERROR()), and the grand
unified reformatting is too much for git to grok the differences in 
context.  It should be fairly easy to do by hand, though.

commit a87e1431baccd49a9344cfc63ab7446c4317fa2f (master)
commit 653d39192297880b4fbc6a53cce6f8692782e1b7 (release/2.4)
Author: Steffan Karger
Date:   Fri May 5 19:44:51 2017 +0200

     cleanup: merge packet_id_alloc_outgoing() into packet_id_write()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494006291-3522-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14541.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


