Date: Mon, 25 Oct 2021 17:59:42 +0200 (CEST)
Message-Id: <202110251559.19PFxgRm061720@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211025145314.23009-1-maximilian.fillinger@...2507...>
References: <20211025145314.23009-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't manually free DH params
 in OpenSSL 3
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Great find.  

I had this trac ticket (1436) about weird hanging/looping on signal exit, 
inside openssl cleanup, and your patch fixes this :-)

Your patch has been applied to the master branch.

commit 4daed27f28f6bb3033e659328fe80322a8f4b5e1
Author: Max Fillinger
Date:   Mon Oct 25 16:53:14 2021 +0200

     Don't manually free DH params in OpenSSL 3

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211025145314.23009-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/search?l=mid&q=20211025145314.23009-1-maximilian.fillinger@...2507...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


