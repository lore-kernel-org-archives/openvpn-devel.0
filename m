Date: Tue, 8 Jul 2025 09:54:34 +0200 (CEST)
Message-Id: <202507080754.5687sY1P068703@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250708073359.32549-1-gert@...1296...>
References: <20250708073359.32549-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_server_null: add multi-socket
 testing
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
To: samuli.seppanen@...277...
Cc: openvpn-devel@lists.sourceforge.net

The buildbots have tested this very thoroughly, I just figured out why
it fails on NetBSD and OpenBSD - these systems, by default, have a limit
of 4 tun devices and the BBs use one of them for the community VPN, 
so when starting 4 server instances, we run out.

 Fix: # cd /dev ; ./MAKEDEV tun4

yes, nothing dynamic there...

Also, we agreed that we should fix the number mapping "client instance 
number -> server number" so that it's easier to maintain because we
know "all client tests 4<x> go to server instance <4>" while it's a bit
unorderly right now.  But this will be a different patch as it affects
existing instances that are unrelated to *this* new feature.

Your patch has been applied to the master branch.

commit fd6d0f3cf67622c3ae052c5f94abd5fd70ee7995
Author: Samuli Seppänen
Date:   Tue Jul 8 09:33:51 2025 +0200

     t_server_null: add multi-socket testing

     Signed-off-by: Samuli Seppänen <sasepp@...2705...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250708073359.32549-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32061.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


