Date: Tue, 10 Jan 2023 15:06:50 +0100 (CET)
Message-Id: <202301101406.30AE6oGl043585@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230109200011.2525342-1-gert@...1296...>
References: <20230109200011.2525342-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reduce logspam about
 'dco_update_keys: peer_id=-1' in p2p server mode
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

Antonio, thanks for the review.  Fixed the whitespace.  (Uncrustify
did not see it since the patch was ad-hoc written on a system that
does not have the hook - but my pre-merge hook would have caught it).

Patch has been applied to the master and release/2.6 branch.

commit 85e0df6b493396d9d1d9030c4018f67037d2f12b (master)
commit 9bc2dfea0e1f643b2a02b61455e1845ae83f7518 (release/2.6)
Author: Gert Doering
Date:   Mon Jan 9 21:00:11 2023 +0100

     Reduce logspam about 'dco_update_keys: peer_id=-1' in p2p server mode

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230109200011.2525342-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25935.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


