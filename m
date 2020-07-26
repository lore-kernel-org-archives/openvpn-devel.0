Date: Sun, 26 Jul 2020 18:06:34 +0200 (CEST)
Message-Id: <202007261606.06QG6YsR099847@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200725234803.22058-1-arne@...1227...>
References: <20200725234803.22058-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Simplify calling logic of
 check_connection_established_dowork
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

The change to "check_connection_established(c)" is really trivial and
straight-forward, and best viewed with "git show -w".  Taking away
an effective no-op wrapper function and getting rid of one indentation
level is always good.

Nevertheless I've forced this through the full client/server tests, and
it succeeded nicely :-)

Your patch has been applied to the master branch.

commit 7cadbe24b6e5b583b4e763cd7a3b30d540b1c7a0
Author: Arne Schwabe
Date:   Sun Jul 26 01:48:02 2020 +0200

     Simplify calling logic of check_connection_established_dowork

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200725234803.22058-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20588.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


