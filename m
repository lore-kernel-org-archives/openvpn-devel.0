Date: Sun, 5 Dec 2021 18:35:59 +0100 (CET)
Message-Id: <202112051735.1B5HZxlJ090481@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211201180727.2496903-4-arne@...1227...>
References: <20211201180727.2496903-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove cipher_kt_var_key_size
 and remaining --keysize documentation
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

Acked-by: Gert Doering <gert@...1296...>

"Easy enough" - and affects only the output of "--show-ciphers", which
is not guaranteed to have a particular format (which is what've tested).

Your patch has been applied to the master branch.

commit 5dcd9a72436c10888202a957a76325b361cca2a5
Author: Arne Schwabe
Date:   Wed Dec 1 19:07:22 2021 +0100

     Remove cipher_kt_var_key_size and remaining --keysize documentation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211201180727.2496903-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23275.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


