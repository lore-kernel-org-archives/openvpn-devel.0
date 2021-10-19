Date: Tue, 19 Oct 2021 17:47:35 +0200 (CEST)
Message-Id: <202110191547.19JFlZlp091520@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019034118.28987-3-selva.nair@...277...>
References: <20211019034118.28987-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Require EC key support in
 Windows builds
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Now this one is straightforward, even I can ACK it :-) - this change is
good as it will avoid compile mishaps, and since we control what SSL 
build we want to use on Windows, we can enforce "always EC!".  Not sure
about other platforms (maybe the Software Museum has OpenSSL versions
compiled without EC...).

I'd love to have that in 2.5 as well, given that this bit us with the
2.5.4 release - but of course it needs 1/3 as a prerequisite, which I
find a bit intrusive for "right in the middle of the 2.5 series".

Can you resend just this one for 2.5?

Your patch has been applied to the master branch.

commit ec9f698d3bac29b50094b23a8ff63e523e6a3787
Author: Selva Nair
Date:   Mon Oct 18 23:41:18 2021 -0400

     Require EC key support in Windows builds

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211019034118.28987-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22952.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


