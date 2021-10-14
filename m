Date: Thu, 14 Oct 2021 16:34:18 +0200 (CEST)
Message-Id: <202110141434.19EEYIi5060168@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211013230442.305-1-lstipakov@...277...>
References: <20211013230442.305-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: config-msvc.h: fix
 OpenSSL-related defines
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for diving into this.  I expect we'll need to do a cleanup of
config-msvc.h for master as well - but the file is different enough that
this patch does not apply.

Your patch has been applied to the release/2.5 branch.

commit c93fcb75782f44a3feb9dba2292a891e579adac4
Author: Lev Stipakov
Date:   Thu Oct 14 02:04:42 2021 +0300

     config-msvc.h: fix OpenSSL-related defines

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211013230442.305-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22933.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


