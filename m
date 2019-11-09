Date: Sat, 9 Nov 2019 15:49:51 +0100 (CET)
Message-Id: <201911091449.xA9Enpkt081718@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1573234655-905-1-git-send-email-lstipakov@...277...>
References: <1573234655-905-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: add --windows-driver
 config option
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(It needed a bit of manual massaging as the context in options.c:851
changed due to the merge of the VLAN patches)

I'm not totally happy with introducing a new function (parse_windows_driver())
to effectively map two constant strings to a boolan variable... but since 
this got ACKed already, in it goes...

commit c0658271be5b45a201eb6aba1e4bdc5a729285be
Author: Lev Stipakov
Date:   Fri Nov 8 19:37:35 2019 +0200

     wintun: add --windows-driver config option

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <1573234655-905-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19046.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


