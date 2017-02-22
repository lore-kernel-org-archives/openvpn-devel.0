Date: Wed, 22 Feb 2017 22:14:08 +0100 (CET)
Message-Id: <201702222114.v1MLE8xR050727@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <c849c9778d2b2faa4eb4d31367b37d993da5eb85.1487368114.git.logout@...260...>
References: <c849c9778d2b2faa4eb4d31367b37d993da5eb85.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
	access to the internal of X509_OBJECT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

commit 47191f49890ee5c53fa78a8ce9bf96b9c8d27a82 (master)
commit d782597ede843266fd2c7854a6f90ec7ce4bb92b (release/2.4)
Author: Emmanuel Deloget
Date:   Fri Feb 17 23:00:42 2017 +0100

     OpenSSL: don't use direct access to the internal of X509_OBJECT

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <c849c9778d2b2faa4eb4d31367b37d993da5eb85.1487368114.git.logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14080.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


