Date: Wed, 22 Apr 2020 12:04:26 +0200 (CEST)
Message-Id: <202004221004.03MA4QH7080809@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200421101122.24284-1-arne@...1227...>
References: <20200421101122.24284-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix tls_ctx_client/server_new
 leaving error on OpenSSL error stack
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

"Explanation and Code make sense, Debian testing confirmed it fixes
the problem observed" (which was a user error in the end, but led to an 
unexpected error in openvpn).

Basic client test run with openssl 1.1.1 on Linux/Gentoo.

Your patch has been applied to the master and release/2.4 branch.

commit 75aa88af774abaa168bf72e43e1dbb57be14c044 (master)
commit 125654bfa6f99a251b581522182e85748dd8043a (release/2.4)
Author: Arne Schwabe
Date:   Tue Apr 21 12:11:22 2020 +0200

     Fix tls_ctx_client/server_new leaving error on OpenSSL error stack

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200421101122.24284-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19802.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


