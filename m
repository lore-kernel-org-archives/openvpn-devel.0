Date: Wed, 9 Oct 2019 19:57:21 +0200 (CEST)
Message-Id: <201910091757.x99HvLPi052361@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191009143422.9419-2-a@...2181...>
References: <20191009143422.9419-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: maddr: create helper function
 to populate maddr object from eth_addr
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

Acked-by: Gert Doering <gert@...1296...>

This is one of the easy ones, and very "obviously correct".  Client side
tested on Linux and FreeBSD with t_client / TAP tests (which do not really
excercise this code, unfortunately, but my test server is still down).

While I do prefer memcpy()'s using "sizeof(dest)" to "OPENVPN_ETH_ALEN", 
mroute.eth_addr is "uint8_t[OPENVPN_ETH_ALEN]" so this is safe enough.

Your patch has been applied to the master branch.

commit 5e27e47d631f61ee3f9234dd076389232495e714
Author: Antonio Quartulli
Date:   Wed Oct 9 16:34:14 2019 +0200

     maddr: create helper function to populate maddr object from eth_addr

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191009143422.9419-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18921.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


