Date: Wed, 25 Dec 2024 16:31:25 +0100 (CET)
Message-Id: <202412251531.4BPFVPa2029332@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241225142131.12543-1-gert@...1296...>
References: <20241225142131.12543-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change internal id of packet id
 to uint64
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at the code, took the initial review (+1) from Lev into account,
ran on the server/client test bed.  Everything looks reasonable, all
tests still pass.

Your patch has been applied to the master branch.

commit 5aa7ce4effb58e927945b5162970fa719978658c
Author: Arne Schwabe
Date:   Wed Dec 25 15:21:31 2024 +0100

     Change internal id of packet id to uint64

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241225142131.12543-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30199.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


