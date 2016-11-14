Date: Mon, 14 Nov 2016 19:56:38 +0100 (CET)
Message-Id: <201611141856.uAEIucMH078657@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1478636302-9678-4-git-send-email-steffan.karger@...1435...>
References: <1478636302-9678-4-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing includes in error.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(I had to massage it a bit because "someone" added an <assert.h> include
to the context below this patch, and git am failed - not very hard to
do, just pointing this out)

commit b7e51b137929e325e2ac3c14f751c3f642063cd5
Author: Steffan Karger
Date:   Tue Nov 8 21:18:20 2016 +0100

     Add missing includes in error.h

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...1347...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1478636302-9678-4-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12972.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


