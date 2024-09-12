Date: Thu, 12 Sep 2024 17:02:03 +0200 (CEST)
Message-Id: <202409121502.48CF23vC025349@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240710160238.190189-1-frank@...2641...>
References: <20240710160238.190189-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove check for anonymous
 unions from configure and cmake config
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

I have no idea what that stuff does, but less #ifdef is good :-) - and
supposedly no currently supported system needs this.

Your patch has been applied to the master branch.

commit b8b2d17f473e80b1a0b66e49cc1f34ce88d9502d
Author: Arne Schwabe
Date:   Wed Jul 10 18:02:38 2024 +0200

     Remove check for anonymous unions from configure and cmake config

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240710160238.190189-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28914.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


