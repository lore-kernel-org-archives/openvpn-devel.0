Date: Tue, 18 Jul 2023 15:04:26 +0200 (CEST)
Message-Id: <202307181304.36ID4QVb013409@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230524132424.3098475-1-arne@...1227...>
References: <20230524132424.3098475-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Revert commit 423ced962d
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

This is unfortunate, but the only option if we want to get on with the
license change.  Not tested individually, but tested together with
2/2, and "everything works as before".

Your patch has been applied to the master and release/2.6 branch.

commit 370334828659e205941eecd1c90f085a64ca539d (master)
commit e376a00c2884c7cc3f965cdd08a8b66537264999 (release/2.6)
Author: Arne Schwabe
Date:   Wed May 24 15:24:23 2023 +0200

     Revert commit 423ced962d

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230524132424.3098475-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26722.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


