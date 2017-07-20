Date: Thu, 20 Jul 2017 22:48:37 +0200 (CEST)
Message-Id: <201707202048.v6KKmbVi040753@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170720082338.1302-1-a@...2181...>
References: <20170720082338.1302-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: improve error message
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

ACK.  Have no such recent Linux system around, but I trust you to have
tested it - tested on older linuxes where it does not break anything, and 
the code looks reasonable.

Your patch has been applied to the master and release/2.4 branch.

commit 20d98427ef37e3b748dbcca2174cd243dcc963dc (master)
commit f62720269db5299b8779780476c533fba00b354a (release/2.4)
Author: Antonio Quartulli
Date:   Thu Jul 20 16:23:38 2017 +0800

     route: improve error message

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170720082338.1302-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15101.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


