Date: Sun, 18 Jun 2017 12:38:23 +0200 (CEST)
Message-Id: <201706181038.v5IAcNRw071389@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170612134330.20971-5-logout@...260...>
References: <20170612134330.20971-5-logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of DSA
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
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit c07c0358b553c519ed9d80e2e0a9ba48ca8850e4 (master)
commit 6f5aa04456f29d7084e004c980e219a21a954fa9 (master)
Author: Emmanuel Deloget
Date:   Mon Jun 12 15:43:26 2017 +0200

     OpenSSL: don't use direct access to the internal of DSA

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170612134330.20971-5-logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14791.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


