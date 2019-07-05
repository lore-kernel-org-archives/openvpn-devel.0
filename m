Date: Fri, 5 Jul 2019 12:39:12 +0200 (CEST)
Message-Id: <201907051039.x65AdCnR097124@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190613134834.5709-2-arne@...1227...>
References: <20190613134834.5709-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add generate_ephemeral_key that
 allows a random ephermal key
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
To: Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have adjusted the comment as David suggested.  Not much to test yet,
as the new code is not used yet.

commit fb4e8abca908d90faa98f20125e49a2590bccaa3
Author: Arne Schwabe
Date:   Thu Jun 13 15:48:30 2019 +0200

     Add generate_ephemeral_key that allows a random ephermal key

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20190613134834.5709-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18527.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


