Date: Sat, 3 Apr 2021 11:29:05 +0200 (CEST)
Message-Id: <202104030929.1339T5nA062277@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210328090530.10653-1-arne@...1227...>
References: <20210328090530.10653-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate non TLS mode in
 OpenVPN
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

The code change is simple enough to review.  My p2p tests now complain
to me in large letters that I should not be doing this (but still work
fine).

I have spent a bit of time on the commit message and I hope I made it 
even more clear.

I have added a note to Changes.rst

Your patch has been applied to the master branch.

commit b72b5ff5e80135e85acc54b807797947528f1963
Author: Arne Schwabe
Date:   Sun Mar 28 11:05:30 2021 +0200

     Deprecate non TLS mode in OpenVPN

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210328090530.10653-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21868.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


