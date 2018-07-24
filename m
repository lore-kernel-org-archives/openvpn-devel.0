Date: Tue, 24 Jul 2018 14:29:28 +0200 (CEST)
Message-Id: <201807241229.w6OCTS7m052065@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180708024517.27108-1-a@...2181...>
References: <20180708024517.27108-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: always reload
 tls-auth/crypt key contexts
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

commit 5817b49b4ca39f86eabb092c562b72d46d5509f7
Author: Antonio Quartulli
Date:   Sun Jul 8 10:45:17 2018 +0800

     crypto: always reload tls-auth/crypt key contexts

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20180708024517.27108-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17237.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


