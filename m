Date: Tue, 27 Apr 2021 13:37:18 +0200 (CEST)
Message-Id: <202104271137.13RBbIGx085566@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210421123415.1942917-1-arne@...1227...>
References: <20210421123415.1942917-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow all GCM ciphers
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

Looks good to me, and passes regular client side tests :-) - I have 
not actually tested the ARIA ciphers, but "they now show up in
--show-cipher mode".  Seems I'll need to add this to one of the
server test cases and see what explodes...

WolfSSL folks, please fix the incompatibility Antonio found :-)

Your patch has been applied to the master branch.

commit 0f168c9ac6c0be5145b5c19c6e79634edf158262
Author: Arne Schwabe
Date:   Wed Apr 21 14:34:15 2021 +0200

     Allow all GCM ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210421123415.1942917-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22168.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


