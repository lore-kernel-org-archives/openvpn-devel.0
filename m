Date: Fri, 17 Jul 2020 10:22:25 +0200 (CEST)
Message-Id: <202007170822.06H8MPCx006942@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200716225338.611-5-davids@...515...>
References: <20200716225338.611-5-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc/man: Complete openvpn.8.rst
 splitting
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

"And then all the new and huge file is gone again".  I'd really like to 
squash 01, 03 and 04 - no good to have 230k openvpn.rst file in our git 
repo forever (even if compression helps) if we never actually need or
want it as "one single file".  So make this "introduce split-up files
right away".

Your patch has been applied to the master branch.

commit a44d0ab612796e73c48f204e6663113520775f2a
Author: David Sommerseth
Date:   Fri Jul 17 00:53:34 2020 +0200

     doc/man: Complete openvpn.8.rst splitting

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200716225338.611-5-davids@...515...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/37063377/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


