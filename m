Date: Wed, 24 Oct 2018 17:55:08 +0200 (CEST)
Message-Id: <201810241555.w9OFt8Y1068024@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1540306288-23847-1-git-send-email-lstipakov@...277...>
References: <1540306288-23847-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Wrap openvpn_swprintf into
 Windows define
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

Make OpenBSD great^w green again!  (Tested before pushing :) )

(I have amended the comments according to the discussion)

commit 4ce1a9b6b3ae0be32a3d999c5bc93731c64d7bbb
Author: Lev Stipakov
Date:   Tue Oct 23 17:51:28 2018 +0300

     Wrap openvpn_swprintf into Windows define

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <1540306288-23847-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17799.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


