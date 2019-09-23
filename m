Date: Mon, 23 Sep 2019 21:12:27 +0200 (CEST)
Message-Id: <201909231912.x8NJCR7v074961@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1564346061-5683-1-git-send-email-selva.nair@...277...>
References: <1564346061-5683-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Handle PSS padding in
 cryptoapicert
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

Sorry for slacking.  

I have stared at the patch a bit, compared to the master patch, and built 
with mingw & openssl 1.0.2n & openssl 1.1.0j on ubuntu 16 (which went fine),
didn't test 1.1.1 as my build system was a bit less than cooperative 
today :-/

This is not a "full review" and I haven't actually *tested* the resulting 
binary, but since the changes are close enough to the two joined commits 
in master and those have been reviewed and tested, "this should be good 
enough".

Your patch has been applied to the release/2.4 branch.

commit 1ed687e72cc1cc46ed1f5f8d9d825db6693e4b3e
Author: Selva Nair
Date:   Sun Jul 28 16:34:21 2019 -0400

     Handle PSS padding in cryptoapicert

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1564346061-5683-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18715.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


