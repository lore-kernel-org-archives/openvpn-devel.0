Date: Wed, 28 Apr 2021 14:19:40 +0200 (CEST)
Message-Id: <202104281219.13SCJeGj023357@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210428081054.29081-1-a@...2181...>
References: <20210428081054.29081-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: respect ECB argument
 type from prototype
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Interesting find from gcc11 :-) 

Your patch has been applied to the master branch.

commit 6a3cbb43a3d09dbf0b5df33c741455f34bde2440
Author: Antonio Quartulli
Date:   Wed Apr 28 10:10:54 2021 +0200

     crypto: respect ECB argument type from prototype

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210428081054.29081-1-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210428081054.29081-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


