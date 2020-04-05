Date: Sun, 5 Apr 2020 10:26:06 +0200 (CEST)
Message-Id: <202004050826.0358Q6bS095025@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1585963064-10311-1-git-send-email-selva.nair@...277...>
References: <1585963064-10311-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move querying username/password
 from management interface to a function
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

Thanks.  Verified that it's indeed the same change with an extra #ifdef
ENABLE_CLIENT_CR - "diffing the diffs" wasn't straightforward here.

Your patch has been applied to the release/2.4 branch.

commit 908eae5ce4b0b696fc335b6244b2e85c4d49c22a
Author: Selva Nair
Date:   Fri Apr 3 21:17:43 2020 -0400

     Move querying username/password from management interface to a function

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1585963064-10311-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19697.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


