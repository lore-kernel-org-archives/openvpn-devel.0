Date: Sun, 3 Apr 2022 16:47:38 +0200 (CEST)
Message-Id: <202204031447.233ElcfC069654@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220402070902.30282-3-a@...2181...>
References: <20220402070902.30282-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking: silence warnings
 about unused arguments
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

While my compiler (gcc 11.2.1) does not warn about them, having these (void) 
for two of the three functions and not all of them is at least slightly 
silly... so, yeah, why not.

Your patch has been applied to the master branch.

commit c3aa44699c69811493a81bda340a03530059929b
Author: Antonio Quartulli
Date:   Sat Apr 2 09:08:57 2022 +0200

     networking: silence warnings about unused arguments

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220402070902.30282-3-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24052.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


