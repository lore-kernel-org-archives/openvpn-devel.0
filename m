Date: Mon, 20 Sep 2021 17:29:35 +0200 (CEST)
Message-Id: <202109201529.18KFTZEw097539@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210904095629.6273-6-a@...2181...>
References: <20210904095629.6273-6-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: compat-mode: add
 --data-cipher-fallback auomatically if requested
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

Code change looks reasonably simple :-) - not sure I understand all
the intricacies, but at least it does not break anything in my test 
rigs.  Which I wouldn't expect.

Your patch has been applied to the master branch.

commit cdef503b646087f9284b53e01c64988c98879c36
Author: Antonio Quartulli
Date:   Sat Sep 4 11:56:27 2021 +0200

     compat-mode: add --data-cipher-fallback auomatically if requested

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210904095629.6273-6-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22798.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


