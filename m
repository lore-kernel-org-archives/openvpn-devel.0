Date: Mon, 1 Nov 2021 20:30:57 +0100 (CET)
Message-Id: <202111011930.1A1JUvD7075317@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211029111109.2003101-2-arne@...1227...>
References: <20211029111109.2003101-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use EVP_PKEY_get_group_name to
 query group name
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Stared a bit at the code (verified that "curve" is never used out
of scope, since it's now a local array), die minimum test run vs.
1.1.1 and 3.0.0 - no surprises (t_lpback.sh still fails due to
the FETCH parts missing, but they can now go in).

Your patch has been applied to the master branch.

commit 4b3c1e76d747d0e7e6aec280680777aef356a940
Author: Arne Schwabe
Date:   Fri Oct 29 13:11:09 2021 +0200

     Use EVP_PKEY_get_group_name to query group name

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20211029111109.2003101-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23077.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


