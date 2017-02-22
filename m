Date: Wed, 22 Feb 2017 22:13:59 +0100 (CET)
Message-Id: <201702222113.v1MLDxUP050718@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
References: <a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
	access to the internal of SSL_CTX
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

commit 6554ac9fed9c5680f22aa4722e6e07ebf3aa3441 (master)
commit b936ddfb631e3a4b219bd035f7110da5679b2d12 (release/2.4)
Author: Emmanuel Deloget
Date:   Fri Feb 17 23:00:40 2017 +0100

     OpenSSL: don't use direct access to the internal of SSL_CTX

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14088.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


