Date: Thu, 10 Feb 2022 08:54:18 +0100 (CET)
Message-Id: <202202100754.21A7sIP5055216@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211209171138.8589-1-frank@...2641...>
References: <20211209171138.8589-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc/Makefile: rebuild rst docs
 if input files change
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

Your patch has been applied to the master branch.

I think it makes sense for release/2.5 as well, but the Makefile looks
a bit different there (no examples-fingerprint.rst at least, did not
look into it more in detail).

commit 529cc6a52fc45a1a67abb5c91819ba4fb2f631e3
Author: Frank Lichtenheld
Date:   Thu Dec 9 18:11:36 2021 +0100

     doc/Makefile: rebuild rst docs if input files change

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20211209171138.8589-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23369.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


