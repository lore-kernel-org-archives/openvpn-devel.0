Date: Wed, 22 Feb 2017 17:07:29 +0100 (CET)
Message-Id: <201702221607.v1MG7T23033426@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <11477a0a3cf636572c84e0110a6f1b726bc60c2c.1487368114.git.logout@...260...>
References: <11477a0a3cf636572c84e0110a6f1b726bc60c2c.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
	access to the internal of X509_STORE_CTX
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

commit 88046ad9e8e333259ae6fb4a295a9931a1a0e47f (master)
commit 58efba5013f6dae4136cc038af9ffd23796cbc0d (release/2.4)
Author: Emmanuel Deloget
Date:   Fri Feb 17 23:00:48 2017 +0100

     OpenSSL: don't use direct access to the internal of X509_STORE_CTX

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <11477a0a3cf636572c84e0110a6f1b726bc60c2c.1487368114.git.logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14085.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


