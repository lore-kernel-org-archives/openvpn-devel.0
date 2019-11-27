Date: Wed, 27 Nov 2019 20:49:50 +0100 (CET)
Message-Id: <201911271949.xARJnoAQ072480@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1574183023-6136-1-git-send-email-selva.nair@...277...>
References: <1574183023-6136-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix ACL_CHECK_ADD_COMPILE_FLAGS
 to work with clang
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

Your patch has been applied to the master branch.  Thanks :-)

I have fixed the "come compilers" typo on the fly.

Very lightly tested (Linux/gcc 8.3.0, and FreeBSD/clang 6.0.0).

commit acc18e8842570e66ef12ffee591968777ed5be6a
Author: Selva Nair
Date:   Tue Nov 19 12:03:43 2019 -0500

     Fix ACL_CHECK_ADD_COMPILE_FLAGS to work with clang

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1574183023-6136-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19170.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


