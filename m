Date: Fri, 10 Feb 2023 19:59:03 +0100 (CET)
Message-Id: <202302101859.31AIx3Y8031056@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230204004512.250271-1-selva.nair@...277...>
References: <20230204004512.250271-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Conditionally add
 subdir-objects option to automake
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

This warning has been quite an annoyance for some time - thanks for
taking care of it, and also figuring out what caveats apply.  I do
not understand autoconf intricacies, but I have fed this to github and
to the buildbots, and they all seem to agree "things still build fine" :-)
(the oldest buildbot is FreeBSD 7.4 with automake-1.11, and then there's
the OpenIndiana buildbot with automake-1.15.1, so we have everything
in the mix... the "current" OSes in the zoo all have 1.16.2 or later)

Your patch has been applied to the master and release/2.6 branch.

commit 8b915c48252da81b96041de66847272b0902c755 (master)
commit 7f72abcf8a56bb35a510a3409e03a4e2aaba50da (release/2.6)
Author: Selva Nair
Date:   Fri Feb 3 19:45:10 2023 -0500

     Conditionally add subdir-objects option to automake

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230204004512.250271-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26147.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


