Date: Mon, 13 Sep 2021 12:03:32 +0200 (CEST)
Message-Id: <202109131003.18DA3WwQ023112@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210827144807.27004-1-a@...2181...>
References: <20210827144807.27004-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: search also for
 rst2{man, html}.py
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

Acked-by: Gert Doering <gert@...1296...>

Tested on my gentoo system, which had symlinks rst2html -> rst2html.py
(etc) previously, to work around our configure inflexibility.  This 
now becomes...

..
checking for rst2man... no
checking for rst2man.py... rst2man.py
checking for rst2html... no
checking for rst2html.py... rst2html.py
..
rst2man.py ../../openvpn/doc/openvpn.8.rst > openvpn.8
rst2man.py ../../openvpn/doc/openvpn-examples.5.rst > openvpn-examples.5
rst2html.py ../../openvpn/doc/openvpn.8.rst > openvpn.8.html
rst2html.py ../../openvpn/doc/openvpn-examples.5.rst > openvpn-examples.5.html

and doc/openvpn.8 is built properly.

Your patch has been applied to the master branch.

commit b61d1988582feb2e1ed1cf9e62700f484e0bc150
Author: Antonio Quartulli
Date:   Fri Aug 27 16:48:07 2021 +0200

     configure: search also for rst2{man, html}.py

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210827144807.27004-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22777.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


