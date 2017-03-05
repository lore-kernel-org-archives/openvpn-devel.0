Date: Sun, 5 Mar 2017 13:21:09 +0100 (CET)
Message-Id: <201703051221.v25CL9lL069378@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <2faff7647151d7fe362c1c5db9f97e520444d09b.1487600539.git.logout@...260...>
References: <2faff7647151d7fe362c1c5db9f97e520444d09b.1487600539.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: use
	EVP_CipherInit_ex() instead of EVP_CipherInit()
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

commit 8d00afae88b626c9cf14170a943b33a7ed378070 (master)
commit 0fa3df510c10820d00b8f5c77a8730f90189f30d (release/2.4)
Author: Emmanuel Deloget
Date:   Mon Feb 20 15:32:34 2017 +0100

     OpenSSL: use EVP_CipherInit_ex() instead of EVP_CipherInit()

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <2faff7647151d7fe362c1c5db9f97e520444d09b.1487600539.git.logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14120.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


