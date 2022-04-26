Date: Tue, 26 Apr 2022 15:40:19 +0200 (CEST)
Message-Id: <202204261340.23QDeJjL098492@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220426132324.76517-1-arne@...1227...>
References: <20220426132324.76517-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change FULL_SYNC macro to
 no_pending_reliable_packets function
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

As discussed on IRC, this is "13/28 v2, first half" (accidentially squashed).

Un-squashing these makes this one much clearer - only FULL_SYNC, and 
it does what it says on the lid.

Quick compile and client test passed.

Your patch has been applied to the master branch.

commit 04c3779922aed541755a20f415e7cb9d717ee7ed
Author: Arne Schwabe
Date:   Tue Apr 26 15:23:23 2022 +0200

     Change FULL_SYNC macro to no_pending_reliable_packets function

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220426132324.76517-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24213.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


