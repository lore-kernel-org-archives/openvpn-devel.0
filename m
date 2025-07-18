Date: Fri, 18 Jul 2025 21:07:02 +0200 (CEST)
Message-Id: <202507181907.56IJ72IK022263@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250718185559.4515-1-gert@...1296...>
References: <20250718185559.4515-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Multi-socket: Fix assert
 triggered by stale peer-id reuse
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

So, while I could not trigger the original ASSERT() (GH issue #773) I
was able to trigger "server misbehaviour" (TCP client with peer-id #0
being kicked out when a leftover UDP client with (old) peer-id #0 sent
data packets).  With the patch, these are gone.

The explanation makes sense - when checking for float, just do not look
at TCP instances at all.  Those can not float, might not have all
data fields filled in, and bring no relevant info for a floating UDP 
client.  So when seen with "git show -w", it's just one extra if()
to verify "only compare with UDP instances" (= 'same proto', as this
function is only called for UDP).

Your patch has been applied to the master branch.

commit fd93e4ad8245e1fd9530a6c1f89cb66c047f3abe
Author: Gianmarco De Gregori
Date:   Fri Jul 18 20:55:53 2025 +0200

     Multi-socket: Fix assert triggered by stale peer-id reuse

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250718185559.4515-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32220.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


