Date: Tue, 24 Jul 2018 14:29:35 +0200 (CEST)
Message-Id: <201807241229.w6OCTZdP052069@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180707090421.25953-2-a@...2181...>
References: <20180707090421.25953-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: make tls-auth and tls-crypt
 per-connection-block options
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

Your patch has been applied to the master branch.

(I have not reviewed this - trusting Steffan on it - but have run cmocka and 
t_client tests on it, and things keep working)

commit 57d6f103f378b927b9e0054b022b5b8b442973b8
Author: Antonio Quartulli
Date:   Sat Jul 7 17:04:21 2018 +0800

     make tls-auth and tls-crypt per-connection-block options

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20180707090421.25953-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17226.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


