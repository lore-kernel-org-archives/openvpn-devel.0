Date: Sun, 8 Dec 2024 15:17:23 +0100 (CET)
Message-Id: <202412081417.4B8EHNHr024475@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
References: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix IPv6 in port-share journal
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
To: corubba <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

I have not actually tested this (beyond "GHA run" passed) because I have
no current test setup for incoming port share with journal files - but
the code change is "obviously correct" and our picky compilers do not
object either.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit dbc0491f20c34cf3b7ab8fe2a55442ea93007ddd (master)
commit f966e67c24af681cdd8c3905f4da07e616a123c5 (release/2.6)
Author: corubba
Date:   Sun Dec 8 00:17:05 2024 +0100

     Fix IPv6 in port-share journal

     Signed-off-by: corubba <corubba@...68...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <8de5660b-d917-4092-8871-250495d8c7a4@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30035.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


