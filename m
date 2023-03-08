Date: Wed, 8 Mar 2023 14:56:11 +0100 (CET)
Message-Id: <202303081356.328DuBJe068355@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230308133743.5059-1-a@...2181...>
References: <20230308133743.5059-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid warning about missing
 braces when initialising key struct
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

Confirmed that it pacifies github, and tests still pass.

Your patch has been applied to the master and release/2.6 branch.

commit 5a14a5ea572ec88e2a9e7bfdad9d5fe31025c021 (master)
commit 26417824ff81ba1dd18b03a40822da533018a892 (release/2.6)
Author: Antonio Quartulli
Date:   Wed Mar 8 14:37:43 2023 +0100

     Avoid warning about missing braces when initialising key struct

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230308133743.5059-1-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20230308133743.5059-1-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


