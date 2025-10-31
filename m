Date: Fri, 31 Oct 2025 12:19:01 +0100 (CET)
Message-Id: <202510311119.59VBJ1aS055093@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251031100819.24855-1-gert@...1296...>
References: <20251031100819.24855-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Zeroize tls-crypt-v2 client keys
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
To: Max Fillinger <max@...2606...>
Cc: openvpn-devel@lists.sourceforge.net

I did not test this, and when reviewing, felt it's above my paygrade - but
since Arne is happy, and he really understands that code, perfect :-)

BB is happy as well!

(I *do* have tested this on the t_server testbed which has tls-crypt[-v2]
using instances, and it still works, so confidence level is high ;-)).

Your patch has been applied to the master branch.

commit 9f71f906ea95331fd9b269502e92c42d1812dd9e
Author: Max Fillinger
Date:   Fri Oct 31 11:08:04 2025 +0100

     Zeroize tls-crypt-v2 client keys

     Signed-off-by: Max Fillinger <max@...2606...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1315
     Message-Id: <20251031100819.24855-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34103.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


