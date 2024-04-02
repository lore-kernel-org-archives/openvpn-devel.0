Date: Tue, 2 Apr 2024 11:55:36 +0200 (CEST)
Message-Id: <202404020955.4329tahu020656@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240402063646.25490-1-gert@...1296...>
References: <20240402063646.25490-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Match ifdef for get_sigtype
 function with if ifdef of caller
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

ACK, verified that it fixes the GHA build fails we've seen since the
recent LibreSSL upgrade on the MacOS builders.

Your patch has been applied to the master branch.

Not applicable to release/2.6 as the offending code is not in there.

commit ff402c7c2fbc49ff6d352ebdc3cdc4c27c2bbcbb (master)
Author: Arne Schwabe
Date:   Tue Apr 2 08:36:46 2024 +0200

     Match ifdef for get_sigtype function with if ifdef of caller

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240402063646.25490-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28512.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


