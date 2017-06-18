Date: Sun, 18 Jun 2017 15:20:58 +0200 (CEST)
Message-Id: <201706181320.v5IDKw53098561@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170612134330.20971-6-logout@...260...>
References: <20170612134330.20971-6-logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of EVP_MD_CTX
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

I have removed the extra #include lines again, as suggested by Steffan,
and they do not seem to be missing - if they are part of a larger 
cleanup (like "move all the <openssl/foo.h> includes into a central
place") please re-send as an additional patch.

commit c481ef002803f360743c72727ae3ca971ce59a5d (master)
commit 87a392369d812d8c2ac81174bb2d6fad17544408 (release/2.4)
Author: Emmanuel Deloget
Date:   Mon Jun 12 15:43:27 2017 +0200

     OpenSSL: don't use direct access to the internal of EVP_MD_CTX

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170612134330.20971-6-logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14793.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


