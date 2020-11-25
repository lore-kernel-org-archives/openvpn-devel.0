Date: Wed, 25 Nov 2020 15:45:32 +0100 (CET)
Message-Id: <202011251445.0APEjWJU047798@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023120259.29783-1-arne@...1227...>
References: <20201023120259.29783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace key_scan array of
 static points with inline function
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

Not sure if I ever understood these shortcuts (there are 3*2 keys
in session[].keys[], but the shortcuts only reference [0][0],
[0][1] and [2][1]) but from a "mechanically comparing before/after"
point of view, the change looks sane.  

Plus, it passes client side tests, with short reneg timeouts (20s).

This change, of course, makes it more interesting to do backports
of ssl.c-related changes from master/2.6 to 2.5...  so let's get
out 2.6 quickly :-)

Uncrustify complains about indent of the new switch/case block,
and that there is a trailing semicolon.  Fixed.

*Also*, this patch needed to be (manually) rebased due to context 
conflicts after 0d4ca79d4f.  Done.

"points" -> "pointers", as requested.

Your patch has been applied to the master branch.

commit cc5a71637139557a7eaa024251ff75a0acb22bc8
Author: Arne Schwabe
Date:   Fri Oct 23 14:02:53 2020 +0200

     Replace key_scan array of static pointers with inline function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023120259.29783-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21225.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


