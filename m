Date: Tue, 28 Jun 2022 22:52:47 +0200 (CEST)
Message-Id: <202206282052.25SKqlla051396@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220628185623.1734-1-a@...2181...>
References: <20220628185623.1734-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: use specific metric when
 installing routes
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Arne has already ACKed the functionality (and I'm fine with that), and
I ACK the extra comments.  We could spend days on perfect wordsmithing
here, but I think they are good enough.

Please do not forget to include the metric thing in the "overall
documentation" patch that was mentioned :-)

Your patch has been applied to the master branch.

commit 90d9c38b116b8c816596d71a5cf6db7fd068d61a
Author: Antonio Quartulli
Date:   Tue Jun 28 20:56:23 2022 +0200

     dco: use specific metric when installing routes

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220628185623.1734-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24599.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


