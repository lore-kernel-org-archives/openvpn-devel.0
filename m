Date: Mon, 24 Mar 2025 10:20:05 +0100 (CET)
Message-Id: <202503240920.52O9K5T4076577@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250324083350.4019-1-gert@...1296...>
References: <20250324083350.4019-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: calculate address string
 buffer size
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for future-proofing this part of the code - it's fine today, but
we might bump the number of allowed DNS addresses to "8" one day, and
then the old code was at-risk for overflows...

I haven't actually tested it, just stared at it for a bit, asked mingw
("no warnings") and we have Frank's +2 in gerrit.

Your patch has been applied to the master branch.

commit 8ea5debaea01da5fee56fbad56b50820c1beee92
Author: Heiko Hund
Date:   Mon Mar 24 09:33:44 2025 +0100

     win: calculate address string buffer size

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250324083350.4019-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31196.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


