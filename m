Date: Tue, 3 Jul 2018 21:30:26 +0200 (CEST)
Message-Id: <201807031930.w63JUQWC033030@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180703161751.7680-1-arne@...1227...>
References: <20180703161751.7680-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add MTU to Android IFCONFIG6
 control command
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

Acked-by: Gert Doering <gert@...1296...>

"I guessed that something interesting might happen here" - nothing
much to review, though, as it's Android specific and does not touch
anything else (and no obvious issues with it).

Your patch has been applied to the master branch.

commit e050bdfe9489ae9d0a15cb000360b73c7c748b59
Author: Arne Schwabe
Date:   Tue Jul 3 18:17:51 2018 +0200

     Add MTU to Android IFCONFIG6 control command

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180703161751.7680-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17186.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


