Date: Thu, 16 Jul 2020 20:06:26 +0200 (CEST)
Message-Id: <202007161806.06GI6QKV093624@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-6-arne@...1227...>
References: <20200711093655.23686-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Refactor
 client-connect handling to calling a bunch of hooks in a loop
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have *not* reformatted the multi_client_connect_handler block - this is 
stuff that goes away in 08/14 again, so reformatting now is doubly futile.

(Speaking of patch granularity: the combination of 05+06+08 is causing 
three times work for something which is basically one change - as the result 
of 05 goes away in 06, and 06 gets rewritten in 08 again.  This makes 
review and testing significantly more work than just doing the change)

commit 07a69fd2ca934c0521b0ee25f72e7f2385279a71
Author: Fabian Knittel
Date:   Sat Jul 11 11:36:47 2020 +0200

     client-connect: Refactor client-connect handling to calling a bunch of hooks in a loop

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200711093655.23686-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20293.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


