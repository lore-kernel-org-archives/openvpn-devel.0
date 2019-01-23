Date: Wed, 23 Jan 2019 20:08:23 +0100 (CET)
Message-Id: <201901231908.x0NJ8NBX056343@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1544210258-8754-1-git-send-email-selva.nair@...277...>
References: <1544210258-8754-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move OpenSSL vs CNG signature
 digest type mapping to a function
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

It needed a bit of massaging due to the uncrustify patches to cryptoapi.c
that happened in between (f57431cdc88f2), but since the relevant conflicts
were all "simple whitespace changes", fairly easily solved.

From a quick clance on cryptoapi.c in release/2.4 it looks like this
might also be applicable - but "by default" I won't apply pure refactoring
changes.  So: if you need this for a change that falls into release/2.4
land ("long-term compatibility" or "bugfix"), please let me know.

Test built on ubuntu 16.04/mingw.

commit 0cab3475a83e9bad35b0eeb39b9ca886e6afaf1e
Author: Selva Nair
Date:   Fri Dec 7 14:17:37 2018 -0500

     Move OpenSSL vs CNG signature digest type mapping to a function

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1544210258-8754-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17999.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


