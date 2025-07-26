Date: Sat, 26 Jul 2025 17:16:09 +0200 (CEST)
Message-Id: <202507261516.56QFG95f056460@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250726135203.3452-1-gert@...1296...>
References: <20250726135203.3452-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: make some multi_*()
 functions static
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Trivial enough :-) - I did check that #844 does not introduce calls
to these functions "from elsewhere", and it doesn't.  Compile- and
client-side tested by the buildbot horde, all green.

Your patch has been applied to the master branch.

commit 3594f5901db17d9b57d8809c729ef24d4bbfddf5
Author: Antonio Quartulli
Date:   Sat Jul 26 15:51:56 2025 +0200

     multi: make some multi_*() functions static

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250726135203.3452-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32356.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


