Date: Tue, 14 Jul 2020 10:49:47 +0200 (CEST)
Message-Id: <202007140849.06E8nlUJ043552@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200711093655.23686-2-arne@...1227...>
References: <20200711093655.23686-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Split
 multi_connection_established into separate functions
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have fixed typo and grammar in the commit message as requested, and
re-wrapped the commit message a bit.

Tested yesterday with a "full t_client and t_server" test with no issues.

commit 0c8c50ca93392e1d0534ac35637899e0017863b9
Author: Fabian Knittel
Date:   Sat Jul 11 11:36:43 2020 +0200

     client-connect: Split multi_connection_established into separate functions

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200711093655.23686-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20289.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


