Date: Tue, 23 Jun 2020 20:46:42 +0200 (CEST)
Message-Id: <202006231846.05NIkgiS011355@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1592917531.4768.4.camel@...2316...>
References: <1592917531.4768.4.camel@...2316...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine keys
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
To: James Bottomley <James.Bottomley@...2316...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Looks reasonable, explanation is reasonable, and it passes "make distcheck"
(only tested on Linux, but there should not be a difference here).

Your patch has been applied to the master branch.

Thanks.

commit 21e3e9fc34128d37bd612def2acca29a5a18de77 (HEAD -> master)
Author: James Bottomley <James.Bottomley@...2316...>
Date:   Tue Jun 23 06:05:31 2020 -0700

    Fix make distcheck for new engine key unit test
    
    Signed-off-by: James Bottomley <James.Bottomley@...2316...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1592917531.4768.4.camel@...2316...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20088.html
    Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


