Date: Sat, 28 May 2022 11:27:15 +0200 (CEST)
Message-Id: <202205280927.24S9RFVV069582@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220511121038.1002898-1-heiko@...2662...>
References: <20220511121038.1002898-1-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc: fix literal block in
 tls-options.rst
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

Acked-by: Gert Doering <gert@...1296...>

I think this was duly discussed, fixed a real formatting issue (blank
line missing), and whether or not "::" should be on a separate line
or not can be clarified separately.  For now, fix the issue.

(I have no idea about .rst, but the explanation + URL given sounds
reasonable)

Your patch has been applied to the master branch.

commit ceeb37a6c728dc9bf4ae19637aa320f02806b6ff
Author: Heiko Hund
Date:   Wed May 11 14:10:38 2022 +0200

     doc: fix literal block in tls-options.rst

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220511121038.1002898-1-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24320.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


