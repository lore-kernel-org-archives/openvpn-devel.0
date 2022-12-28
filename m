Date: Wed, 28 Dec 2022 22:44:21 +0100 (CET)
Message-Id: <202212282144.2BSLiLgW042202@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221228110752.34060-1-frank@...2641...>
References: <20221228110752.34060-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: options.c: fix format security
 error when compiling without optimization
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Funny code section... why introduce a variable, when it could have called
msg() directly.  But anyway.

Your patch has been applied to the master and release/2.6 branch.

commit 24fc4ce25432a42170477f21133bb0f25a8a860d (master)
commit cdcaebcbdf31cb629e54147d476e6fb9921f7999 (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Dec 28 12:07:52 2022 +0100

     options.c: fix format security error when compiling without optimization

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20221228110752.34060-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25848.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


