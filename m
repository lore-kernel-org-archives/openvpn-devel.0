Date: Tue, 4 Nov 2025 09:12:44 +0100 (CET)
Message-Id: <202511040812.5A48CiUe039692@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251103212523.31409-1-gert@...1296...>
References: <20251103212523.31409-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use correct undo_list when
 clearing DNS addresses
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.  I do wonder how this could have worked so long without anyone
noticing...

Your patch has been applied to the master and release/2.6 branch (bugfix).

The patch would apply to release/2.5 as well, but since we don't provide
windows installer releases for 2.5.x anymore I'm not sure it's worth it.

commit 59fed2ad127bda2986f4c70d128453740ca63d34 (master)
commit 21d6b663d3a4370348d5cd071ba2207dc63f0c9f (release/2.6)
Author: Selva Nair
Date:   Mon Nov 3 22:25:17 2025 +0100

     Use correct undo_list when clearing DNS addresses

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1344
     Message-Id: <20251103212523.31409-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34171.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


