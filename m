Date: Mon, 29 Jan 2024 16:05:17 +0100 (CET)
Message-Id: <202401291505.40TF5Hmu033827@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240129145756.769-1-gert@...1296...>
References: <20240129145756.769-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: gerrit-send-mail: Make output
 consistent across systems
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

Fixes issues with UTF8 in Files (user_pass UT test).

For added fanciness, could set charset header in resulting mail, so
"git send-email" wouldn't have to ask... but that's less nuisance than
"python explodes because UTF8" :-)

Your patch has been applied to the master branch.

commit e1f8c599aeb840909f5ea8e9ae0bc4dab5bc7deb
Author: Frank Lichtenheld
Date:   Mon Jan 29 15:57:56 2024 +0100

     gerrit-send-mail: Make output consistent across systems

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240129145756.769-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28153.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


