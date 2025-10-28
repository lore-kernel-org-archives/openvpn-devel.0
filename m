Date: Tue, 28 Oct 2025 10:34:43 +0100 (CET)
Message-Id: <202510280934.59S9YhfK095326@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251027213308.5588-1-gert@...1296...>
References: <20251027213308.5588-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid possible race condition
 that kill OpenVPN itself
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

Amazing find by ZeroPath, and trivially correct fix.

I have completed Joshua's "reported-by:" line (full name) in the
commit message.

Your patch has been applied to the master branch.

commit 18309ff64833523c1ad19e7d56d6f756b53966af
Author: Arne Schwabe
Date:   Mon Oct 27 22:33:02 2025 +0100

     Avoid possible race condition that kill OpenVPN itself

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1319
     Message-Id: <20251027213308.5588-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33910.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


