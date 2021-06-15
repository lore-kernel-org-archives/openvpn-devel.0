Date: Tue, 15 Jun 2021 10:44:51 +0200 (CEST)
Message-Id: <202106150844.15F8ip5d024687@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210609213231.22576-1-openvpn@...2080...>
References: <20210609213231.22576-1-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update copyrights
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Patch does what it says on the tin, and yeah, we seem to have
forgotten that before releasing 2.5.0... maybe add a yearly reminder or so.

Your patch has been applied to the master and release/2.5 branch
(housekeeping).

Cherrypicking to 2.5 was fairly straightforward, I just had to ignore
those files that do not exist in 2.5 (git wants to add the file from
"master" in that case).

For some reason unclear to me, the patch did not make it to the
mail-archive.org archives (it did make patchwork, so it was circulated
by the openvpn-devel list).  So the standard URL won't resolve - I have
added a link to the sf.net archive which works.

commit 05271322e7b5f453fe9d85310e500d3460ac8ca4 (master)
commit eaf447d708bde55a6f712e7ddb16a775a451959b (release/2.5)
Author: David Sommerseth
Date:   Wed Jun 9 23:32:30 2021 +0200

     Update copyrights

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210609213231.22576-1-openvpn@...2080...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210609213231.22576-1-openvpn@...2080...
     URL: https://sourceforge.net/p/openvpn/mailman/message/37299719/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


