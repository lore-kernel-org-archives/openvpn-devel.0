Date: Fri, 13 Jan 2023 14:44:44 +0100 (CET)
Message-Id: <202301131344.30DDiiim049907@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230113080745.82783-1-gert@...1296...>
References: <20230113080745.82783-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix
 OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT breakage on FreeBSD+DCO
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Antonio, thanks for the ACK, and yes, we need a FreeBSD 14 buildbot
(Github Actions has no support for "not yet released" OSes yet, as
far as I'm aware)

Patch has been applied to the master and release/2.6 branch.

commit cf545d603ecd9fbacc6bd519efaa92d60f944287 (master)
commit 480ad2a84e2983e8a1b61d537cf82da5c5141853 (release/2.6)
Author: Gert Doering
Date:   Fri Jan 13 09:07:45 2023 +0100

     Fix OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT breakage on FreeBSD+DCO

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20230113080745.82783-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20230113080745.82783-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


