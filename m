Date: Sat, 28 Sep 2024 22:12:09 +0200 (CEST)
Message-Id: <202409282012.48SKC9UH091013@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240928200508.23747-1-gert@...1296...>
References: <20240928200508.23747-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh: conditionally skip
 ifconfig+route check
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Tested (quite a bit :-) ) in the testing phase of the AF_UNIX patch set...

Patch has been applied to the master branch.

commit 5ccaa49e0323ce468b156b3fa0930f7840050387
Author: Gert Doering
Date:   Sat Sep 28 22:05:08 2024 +0200

     t_client.sh: conditionally skip ifconfig+route check

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240928200508.23747-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29473.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


