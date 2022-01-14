Date: Fri, 14 Jan 2022 14:27:33 +0100 (CET)
Message-Id: <202201141327.20EDRXn8034032@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220110144510.17769-1-a@...2181...>
References: <20220110144510.17769-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl.c: use arrow operator to
 access object member
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

Both is technically doing the same thing, but we use -> notation in 
most places, so this is more consistent.  Client-side tested.

(JFTR, the offending commit is 15d052432, which moved from "structure
access" to "pointer access", so going from "key2." to "(*key2)." is
understandable...)

Your patch has been applied to the master branch.

commit eb3e849e63e32cc015aa21c4481b232bf69c8976
Author: Antonio Quartulli
Date:   Mon Jan 10 15:45:10 2022 +0100

     ssl.c: use arrow operator to access object member

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220110144510.17769-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23521.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


