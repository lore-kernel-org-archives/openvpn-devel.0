Date: Sun, 5 Mar 2017 10:53:35 +0100 (CET)
Message-Id: <201703050953.v259rZMs067447@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <79d89580db6fd92c059dabc4f5f4d83b72bb9d3d.1487859361.git.logout@...260...>
References: <79d89580db6fd92c059dabc4f5f4d83b72bb9d3d.1487859361.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
	access to the internal of RSA_METHOD
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

Your patch (v3) has been applied to the master and release/2.4 branch.

Small side note: I assume that RSA_meth_new() can fail and return NULL
in OpenSSL 1.1?  Because for 1.0, the "check_malloc_return(rsa_meth)" call 
isn't necessary, as ALLOC_OBJ_CLEAR() would call ALLOC_OBJ() and that
already checks...  (mentioning this here in case someone wonders and goes
to the list archives).

commit 09776c5b52df13121504e07894a26d5cd1883317 (master)
commit 44bac2926d6b445a7773a24bb7c295b54f4be35e (release/2.4)
Author: Emmanuel Deloget
Date:   Thu Feb 23 15:35:56 2017 +0100

     OpenSSL: don't use direct access to the internal of RSA_METHOD

     Signed-off-by: Emmanuel Deloget <logout@...260...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <79d89580db6fd92c059dabc4f5f4d83b72bb9d3d.1487859361.git.logout@...260...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14175.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


