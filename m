Date: Tue, 21 Oct 2025 21:45:42 +0200 (CEST)
Message-Id: <202510211945.59LJjg2S082198@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251021193147.26778-1-gert@...1296...>
References: <20251021193147.26778-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: Fix wrong usage of
 mroute_extract_openvpn_sockaddr
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Bad API hack, correct fix...  verified by going to mroute.c and 
reading up on what mroute_extract_openvpn_sockaddr() does with
"addr.proto" which should be an *output* structure, but this
field is used as input as well...  can someone fix this for good,
please, after 2.7 release?

(Quite an impressive find by GCC)

Your patch has been applied to the master branch.

commit 0abf6e716b5a50b2b7f4287b1d50f4889eed36aa
Author: Frank Lichtenheld
Date:   Tue Oct 21 21:31:40 2025 +0200

     multi: Fix wrong usage of mroute_extract_openvpn_sockaddr

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Gianmarco De Gregori <gianmarco@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1292
     Message-Id: <20251021193147.26778-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33830.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


