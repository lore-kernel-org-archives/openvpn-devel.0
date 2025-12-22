Date: Mon, 22 Dec 2025 22:47:30 +0100 (CET)
Message-Id: <202512222147.5BMLlUUH025415@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251219135110.166468-1-frank@...2641...>
References: <20251219135110.166468-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow test-crypto to work
 without the --secret argument
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

"make check" still passes :-) - not tested beyond, after sufficiently long
and hard review and feedback from Max and Frank.

Your patch has been applied to the master branch.

commit 927b45dde7d75a08150fbe33b49892861f006e7f
Author: Arne Schwabe
Date:   Fri Dec 19 14:51:10 2025 +0100

     Allow test-crypto to work without the --secret argument

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1435
     Message-Id: <20251219135110.166468-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35157.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


