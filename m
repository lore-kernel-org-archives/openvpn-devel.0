Date: Sun, 18 Jun 2017 12:38:13 +0200 (CEST)
Message-Id: <201706181038.v5IAcD4k071315@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170612134330.20971-2-logout@...260...>
References: <20170612134330.20971-2-logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of X509
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

I have changed the two occurences of "wierd" in comments to "weird",
as requested.   

commit 17d1ab90c228b1efbe774357bd3265b2af006899 (master)
commit e78934adade51f79c847dcf0fee26905ebb9044d (release/2.4)
Author: Emmanuel Deloget
Date:   Mon Jun 12 15:43:23 2017 +0200

     OpenSSL: don't use direct access to the internal of X509

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170612134330.20971-2-logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14792.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


