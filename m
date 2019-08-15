Date: Thu, 15 Aug 2019 20:31:30 +0200 (CEST)
Message-Id: <201908151831.x7FIVUWt017779@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190805092529.9467-2-a@...2181...>
References: <20190805092529.9467-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: harden strncpy() by
 forcing arguments to have the same length
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

Acked-by: Gert Doering <gert@...1296...>

Interesting remark from Casper Dik - strncpy() actually is defined
to *always* write all IFNAMSIZ bytes (so says the linux man page), unlike 
strcpy() which stops after the '\0' byte.  But in this particular case,
"not overrunning" is more important than "save a few cycles on a short
interface name".  But it was certainly news to me.

Now all strings involved are guaranteed to always have the same length.  

Thanks.

Your patch has been applied to the master branch.

commit 8a05f860af386cd135ee1aacb0d5eccc49c466bb
Author: Antonio Quartulli
Date:   Mon Aug 5 11:25:24 2019 +0200

     sitnl: harden strncpy() by forcing arguments to have the same length

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190805092529.9467-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18722.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


