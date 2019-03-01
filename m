Date: Fri, 1 Mar 2019 20:57:49 +0100 (CET)
Message-Id: <201903011957.x21JvnYd061091@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1551418344-16317-1-git-send-email-selva.nair@...277...>
References: <1551418344-16317-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Better error message when
 script fails due to script-security setting
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

Thanks for doing the work here for 2.4.  Verified that it's the same 
code changes, just in different places (diffing the two patches works
fairly well here) - with the "script_security" difference, according to
the commit message.

Your patch has been applied to the release/2.4 branch.

commit 0ecd321987bde2cebeba9f696d21950649b8ea4d
Author: Selva Nair
Date:   Fri Mar 1 00:32:24 2019 -0500

     Better error message when script fails due to script-security setting

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1551418344-16317-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18259.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


