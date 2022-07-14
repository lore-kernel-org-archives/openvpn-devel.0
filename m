Date: Thu, 14 Jul 2022 20:36:53 +0200 (CEST)
Message-Id: <202207141836.26EIarhM028705@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220701000726.8198-1-selva.nair@...277...>
References: <20220701000726.8198-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove
 management_write_peer_info_file and related code
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

Nobody has spoken up so far "I REALLY NEED THIS!!", and if you say
it hasn't worked anyway, out it goes... less code, less arguments,
less variables...

I have only skimmed the code change and did a quick test build on
FreeBSD.

Your patch has been applied to the master branch.

commit 57d0046e8ab158a055c40a961d71cfe15656b27c
Author: Selva Nair
Date:   Thu Jun 30 20:07:26 2022 -0400

     Remove management_write_peer_info_file and related code

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220701000726.8198-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24624.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


