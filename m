Date: Sun, 29 Dec 2024 13:24:27 +0100 (CET)
Message-Id: <202412291224.4BTCORMA008038@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241118142019.31045-1-shujifurukawa1213@...277...>
References: <20241118142019.31045-1-shujifurukawa1213@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve shuffling algorithm of
 connection list
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
To: Hurukawa2121 <shujifurukawa1213@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for your patch.

I have reformatted the comment section (line length was too long) and
brought back the word "possibly" ("possibly randomize", it's not always
randomized).  I have not done any detailed tests on randomness and
distribution of permutations, though :-)

Your patch has been applied to the master branch.

commit 9502e5257c59bfd23b9afcdb28f7994470591430 (master)
Author: Shuji Furukawa
Date:   Mon Nov 18 23:20:20 2024 +0900

     Improve shuffling algorithm of connection list

     Signed-off-by: Shuji Furukawa <shujifurukawa1213@...277...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20241118142019.31045-1-shujifurukawa1213@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29837.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


