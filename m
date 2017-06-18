Date: Sun, 18 Jun 2017 15:21:08 +0200 (CEST)
Message-Id: <201706181321.v5IDL8W8098574@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170612134330.20971-8-logout@...260...>
References: <20170612134330.20971-8-logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of HMAC_CTX
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

I have not changed anything wrt _init()/reset() to not delay getting
this in-tree before the upcoming v2.4.3 release - but if you agree to
Steffan's comment on that, please send a followup patch which can then
go in later.

(Thanks for all your work!)

commit aba98e9050eb54d72d921e70bcd422cb892b9c6c (master)
commit 2bf4aee4b043151bd2abe7101421fd74763f1230 (release/2.4)
Author: Emmanuel Deloget
Date:   Mon Jun 12 15:43:29 2017 +0200

     OpenSSL: don't use direct access to the internal of HMAC_CTX

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170612134330.20971-8-logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14797.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


