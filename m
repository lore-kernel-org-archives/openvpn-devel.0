Date: Thu, 18 May 2017 17:36:18 +0200 (CEST)
Message-Id: <201705181536.v4IFaII0087453@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <143540d4-e8ea-b533-ad1a-8ae33bfd1133@...1856...>
References: <143540d4-e8ea-b533-ad1a-8ae33bfd1133@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid a 1 byte overcopy in
	x509_get_subject (ssl_verify_openssl.c)
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK (since it's the 2.3 patch from Guido, reformatted for 2.4/master)

Slightly modified the commit message to refer to the 2.3 patch and
to trac #890.

Your patch has been applied to the master and release/2.4 branch.

commit 3fbc9d2b1b1e75b227107057b92ce6b786b5bea1 (master)
commit a91c54de67312f4026db61fd2b0e98cbd11e5323 (release/2.4)
Author: Steffan Karger
Date:   Sun May 14 21:00:41 2017 +0200

     Avoid a 1 byte overcopy in x509_get_subject (ssl_verify_openssl.c)

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <143540d4-e8ea-b533-ad1a-8ae33bfd1133@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14653.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


