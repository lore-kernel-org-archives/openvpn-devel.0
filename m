Date: Fri, 3 Mar 2023 17:16:58 +0100 (CET)
Message-Id: <202303031616.323GGwFm043622@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230303110511.9569-1-kprovost@...2661...>
References: <20230303110511.9569-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: define
 OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT on FreeBSD
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the patch - I did the #ifdef variant "because I did not
want to touch FreeBSD enums without checking with you first" - but
this is a better way forward.  Client-side tested on FreeBSD 14 and 12 :-)

Your patch has been applied to the master and release/2.6 branch.

commit 155cf11531e619cf24b2aa9d0acb4ff834b2e8fa (master)
commit 7fdf3e7ad711e1583e960798848c7d7f94e1ad8a (release/2.6)
Author: Kristof Provost
Date:   Fri Mar 3 12:05:11 2023 +0100

     dco: define OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT on FreeBSD

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230303110511.9569-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26324.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


