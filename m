Date: Wed, 23 Jul 2025 10:18:24 +0200 (CEST)
Message-Id: <202507230818.56N8IO5l017154@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250723063039.25449-1-gert@...1296...>
References: <20250723063039.25449-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: use M_FATAL instead
 of M_ERR in netlink error code paths
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at the code, this is all "in netlink error handling", so the
changes makes sense.

Your patch has been applied to the master branch.

commit dfe71b0a397273efffabbc01d1f6a9933f607933
Author: Antonio Quartulli
Date:   Wed Jul 23 08:30:30 2025 +0200

     dco_linux: use M_FATAL instead of M_ERR in netlink error code paths

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250723063039.25449-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32271.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


