Date: Fri, 10 Apr 2020 22:25:21 +0200 (CEST)
Message-Id: <202004102025.03AKPLZV014277@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200407174436.238933-1-wgh@...2548...>
References: <20200407174436.238933-1-wgh@...2548...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL: Fix --crl-verify not
 loading multiple CRLs in one file
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
To: Maxim Plotnikov <wgh@...2548...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch
(sort-of bugfix / featurette with very localized impact).

Did a very basic compile/client side test, no CRLs involved.  Code change
looks reasonable and similar to what Arne did with the CAs just recently.

commit 05229fb5923f43a502bf0ca731d9ba3106c259e8 (master)
commit ed925c0a8d3e6aa8bc26de8c0e7ed79a47e5c7d6 (release/2.4)
Author: Maxim Plotnikov
Date:   Tue Apr 7 20:44:36 2020 +0300

     OpenSSL: Fix --crl-verify not loading multiple CRLs in one file

     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200407174436.238933-1-wgh@...2548...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19710.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


