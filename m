Date: Sat, 20 Jun 2020 12:45:18 +0200 (CEST)
Message-Id: <202006201045.05KAjIY0098195@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200519220004.25136-6-arne@...1227...>
References: <20200519220004.25136-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement forwarding client
 CR_RESPONSE messages to management
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

Your patch has been applied to the master branch.

Fixed a typo in doc/management-notes.txt ("sequentiality" was meant to be
exactly this, not "sequentially").

Stared a bit at the code and ran basic t_client tests, but no real testing
and no real review.

commit 06498f21cdf051b0643606efda96b27b3c358e0c
Author: Arne Schwabe
Date:   Wed May 20 00:00:04 2020 +0200

     Implement forwarding client CR_RESPONSE messages to management

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20200519220004.25136-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19910.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


