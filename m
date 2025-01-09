Date: Thu, 9 Jan 2025 22:37:45 +0100 (CET)
Message-Id: <202501092137.509Lbjxs023108@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250109175528.22033-1-gert@...1296...>
References: <20250109175528.22033-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add methods to read/write
 packet ids for epoch data
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

This basically does not really add "system testable" code yet - but it
does add unit tests (which pass), the code looks reasonable, and it
comes with a +2 from MaxF in Gerrit. 

A comment explaining what packet_id_send_update_epoch() is about would
be nice, though...

Your patch has been applied to the master branch.

commit bc62a9a02cb7365a678bcd3f2faf537a420cc5a0
Author: Arne Schwabe
Date:   Thu Jan 9 18:55:28 2025 +0100

     Add methods to read/write packet ids for epoch data

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250109175528.22033-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30389.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


