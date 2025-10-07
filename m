Date: Tue, 7 Oct 2025 22:11:49 +0200 (CEST)
Message-Id: <202510072011.597KBnbA052205@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251007185110.19267-1-gert@...1296...>
References: <20251007185110.19267-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Factor out parsing
 code to separate options_parse.c
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

"Because it makes sense" :-) - "git show --color-moved" also shows that
this is really just moved code, and a few "static"s removed here and
there.  Tests pass.

Your patch has been applied to the master branch.

commit ebf781b8a15932ff7b7911ce41bdcedf70d0eb06
Author: Frank Lichtenheld
Date:   Tue Oct 7 20:51:04 2025 +0200

     options: Factor out parsing code to separate options_parse.c

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1242
     Message-Id: <20251007185110.19267-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243506/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


