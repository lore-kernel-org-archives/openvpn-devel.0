Date: Sun, 18 Jun 2017 12:38:16 +0200 (CEST)
Message-Id: <201706181038.v5IAcGX9071359@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170612134330.20971-3-logout@...260...>
References: <20170612134330.20971-3-logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of EVP_PKEY
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

commit b8ca5bc3593e539d0735a74b55ed41a792e55033 (master)
commit cc7c9122dc1d9e87d3f9b953b7d3b3db9166c540 (release/2.4)
Author: Emmanuel Deloget
Date:   Mon Jun 12 15:43:24 2017 +0200

     OpenSSL: don't use direct access to the internal of EVP_PKEY

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170612134330.20971-3-logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14795.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


