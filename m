Date: Fri, 31 Jan 2025 10:36:40 +0100 (CET)
Message-Id: <202501310936.50V9aetO044114@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250131084651.24765-1-gert@...1296...>
References: <20250131084651.24765-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: get_default_gateway():
 implement platform support for Linux/SITNL
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

Tested on a local gentoo system, with "the usual" questions
(--show-gateway, --show-gateway 127.0.0.1, --show-gateway <on lan>, ...).

Patch has been applied to the master branch.

commit f28c254da58c7a48592c2c63c0a98b38283405e8
Author: Gert Doering
Date:   Fri Jan 31 09:46:51 2025 +0100

     get_default_gateway(): implement platform support for Linux/SITNL

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20250131084651.24765-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30749.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


