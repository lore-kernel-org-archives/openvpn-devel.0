Date: Fri, 6 Mar 2026 17:24:45 +0100 (CET)
Message-Id: <202603061624.626GOjx3008993@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260305065952.24348-1-gert@...1296...>
References: <20260305065952.24348-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use USER_PASS_LEN for private
 key password buffer size
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

Well spotted... change makes sense, getting rid of magic numbers is
good, ensuring all "use this for a password" arrays have the same
size is even better ;-)

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 5f7b1c548b69e0ba0c54bfb63c94243c4ffaea97 (master)
commit 6a1ae7f24d3179146bb7464bd8dc8a36f18353fb (release/2.7)
Author: Selva Nair
Date:   Thu Mar 5 07:59:45 2026 +0100

     Use USER_PASS_LEN for private key password buffer size

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1553
     Message-Id: <20260305065952.24348-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35914.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


