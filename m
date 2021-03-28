Date: Sun, 28 Mar 2021 11:44:13 +0200 (CEST)
Message-Id: <202103280944.12S9iDUg068393@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210326175750.4772-1-arne@...1227...>
References: <20210326175750.4772-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup print_details and add
 signature/ED certificate print
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

Lightly tested on OpenSSL 1.0.2 and 1.1.1 clients, talking to 1.0.2 and
1.1.1 servers (= TLS 1.2 and 1.3).

Your patch has been applied to the master and release/2.5 branch.

I think it falls under the "long term compatibility" clause for 2.5,
as 2.5 will be around for a while and being able to print more details
for TLS 1.3 and EC/ED is good.

commit ca57070630a1b2935ee606cc1309005b56eb925f (master)
commit a177388735566c3d7c3120860ceea71b81db5c34 (release/2.5)
Author: Arne Schwabe
Date:   Fri Mar 26 18:57:50 2021 +0100

     Cleanup print_details and add signature/ED certificate print

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210326175750.4772-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21861.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


