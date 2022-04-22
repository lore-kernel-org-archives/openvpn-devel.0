Date: Fri, 22 Apr 2022 18:25:48 +0200 (CEST)
Message-Id: <202204221625.23MGPmeJ094436@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-10-arne@...1227...>
References: <20220422134038.3801239-10-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove inc_pid argument from
 reliable_mark_deleted that is always true
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Trivial enough.  Single caller, constant argument ("true"), away it goes.

Only lightly tested.

Your patch has been applied to the master branch.

commit 911224dbac0f11bb22e007db0ae424e864489ef8
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:38 2022 +0200

     Remove inc_pid argument from reliable_mark_deleted that is always true

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220422134038.3801239-10-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20220422134038.3801239-10-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


