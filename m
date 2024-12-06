Date: Fri, 6 Dec 2024 08:16:45 +0100 (CET)
Message-Id: <202412060716.4B67Gj9c021810@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241205214158.23542-1-gert@...1296...>
References: <20241205214158.23542-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix some formatting related to
 if/else and macros
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

.. because it makes sense, and is correct according to style guide
(even if uncrustify cannot see it across the #ifdef maze).  Thanks.

Stared-at-code, especially for the init.c change (removing the #ifdef
makes sense, as "management_flags" is always available).  BB agrees
that there are no compile-breaking typos etc.

Your patch has been applied to the master branch.

commit 91b6e288a49ee57a4eeeff3f22f2440c94594a1d
Author: Frank Lichtenheld
Date:   Thu Dec 5 22:41:58 2024 +0100

     Fix some formatting related to if/else and macros

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20241205214158.23542-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30027.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


