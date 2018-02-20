Date: Tue, 20 Feb 2018 22:31:14 +0100 (CET)
Message-Id: <201802202131.w1KLVEoF072292@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1516982732-24145-1-git-send-email-selva.nair@...277...>
References: <1516982732-24145-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move code to free cd to a
 function CAPI_DATA_free()
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

Your patch has been applied to the master branch.

(I took the ACK from Steffan for v1, and verified that v2 is really idential
except for the extra empty line - so line numbers differ, but code is the
same.  Adding an extra ACK from me for staring-at-the-code - trivial
enough in this case)

commit 29a475c6ce0fa51b173121033cbd0f280948e06c
Author: Selva Nair
Date:   Fri Jan 26 11:05:32 2018 -0500

     Move code to free cd to a function CAPI_DATA_free()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1516982732-24145-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16383.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


