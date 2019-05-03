Date: Fri, 3 May 2019 20:42:46 +0200 (CEST)
Message-Id: <201905031842.x43IgkRP014865@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190417203015.1903-1-davids@...515...>
References: <20190417203015.1903-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: build: Package missing
 mock_msg.h
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

Your patch has been applied to the master branch.

I think the functionality makes sense in 2.4 as well (we do have a
mock-msg.h there as well) but the patch resists application...

commit 19a22ac5a8673e87157a516b936ce008bacb44ea
Author: David Sommerseth
Date:   Wed Apr 17 22:30:15 2019 +0200

     build: Package missing mock_msg.h

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20190417203015.1903-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18380.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


