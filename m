Date: Wed, 23 Oct 2024 22:30:04 +0200 (CEST)
Message-Id: <202410232030.49NKU4Um080971@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241023142030.731-1-gert@...1296...>
References: <20241023142030.731-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: io_work: pass event_arg object
 to event handler in case of socket event
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Tested on the server testbed (and GHA, for good measure).

The code change looks okayish.  "struct ta_iow_flags" is not used yet, but
hints at interesting things to come :-)

Your patch has been applied to the master branch.

commit 58612741680994928e67a0e981c91bbffb7a2d20
Author: Antonio Quartulli
Date:   Wed Oct 23 16:20:30 2024 +0200

     io_work: pass event_arg object to event handler in case of socket event

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Message-Id: <20241023142030.731-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29625.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


