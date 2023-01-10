Date: Tue, 10 Jan 2023 16:50:11 +0100 (CET)
Message-Id: <202301101550.30AFoBxG045336@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230110151901.998479-1-arne@...1227...>
References: <20230110151901.998479-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log peer-id if loglevel is
 D_DCO_DEBUG and dco is enabled
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

Acked-by: Gert Doering <gert@...1296...>

Works and helps with DCO debugging.

Some of the messages look a bit stupid now... so we might want to go
and polish :-)

.. gremlin14943/194.97.140.21:12404 peer-id=9 dco_update_keys: peer_id=9
.. gremlin14833/194.97.140.21:11036 peer-id=11 dco_update_keys: peer_id=11
.. gremlin14340/194.97.140.21:29500 peer-id=12 dco_update_keys: peer_id=12


Your patch has been applied to the master and release/2.6 branch.

commit 533c170fb60882547152e3b3222c8f7788d6b80f (master)
commit d04c2110a006c204b5753113cdbed2866b9641ed (release/2.6)
Author: Arne Schwabe
Date:   Tue Jan 10 16:19:01 2023 +0100

     Log peer-id if loglevel is D_DCO_DEBUG and dco is enabled

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230110151901.998479-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25946.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


