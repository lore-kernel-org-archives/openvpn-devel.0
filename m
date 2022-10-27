Date: Thu, 27 Oct 2022 08:27:52 +0200 (CEST)
Message-Id: <202210270627.29R6RqGY027422@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221026185543.5378-1-selva.nair@...277...>
References: <20221026185543.5378-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Purge auth-token as well while
 purging passwords
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

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Based on our mail thread on v1, this now clears the token on
"management related events" (forget-password, management disconnect)
and does not affect other code paths.  I have not submitted this to
extremely thorough testing, just basic t_client tests for 2.5 and master
(which do not exercise these code paths at all).

Your patch has been applied to the master and release/2.5 branch.

commit ecad4839caf4c2fab9c6627ceeca9b9cb32e8929 (master)
commit 3d792ae9557b959e796710cf903866d205d979da (release/2.5)
Author: Selva Nair
Date:   Wed Oct 26 14:55:43 2022 -0400

     Purge auth-token as well while purging passwords

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221026185543.5378-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25460.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


