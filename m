Date: Mon, 6 Apr 2026 13:37:37 +0200 (CEST)
Message-Id: <202604061137.636BbbZS020924@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260330180900.16608-1-gert@...1296...>
References: <20260330180900.16608-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: management: add base64
 multi-line input for passwords
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
To: Luca Boccassi <luca.boccassi@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I'm glad Selva reviewed and ACKed this - my understanding of the management
interface code is not as thorough.

I tested the resulting code on the client/server testbeds (which are not
actually using the management interface yet, and even if they were, they
would not use this new interface... - but it confirms that nothing else
was broken).  Glancing at the code also does not find anything I'd 
consider problematic anymore.  In it goes...

Your patch has been applied to the master and release/2.7 branch
(long-term compat, distros moving very slowly, eventual NM integration).

commit 49ff16dd54c5656eedf26194a9879ad90548a7a5 (master)
commit d9b48759fe9e5a1fd216d88377a534ba1f5232cf (release/2.7)
Author: Luca Boccassi
Date:   Mon Mar 30 20:08:54 2026 +0200

     management: add base64 multi-line input for passwords

     Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1593
     Message-Id: <20260330180900.16608-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36360.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


