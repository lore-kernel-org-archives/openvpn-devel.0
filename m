Date: Wed, 27 Oct 2021 20:40:50 +0200 (CEST)
Message-Id: <202110271840.19RIeoYn040774@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-3-arne@...1227...>
References: <20211019183127.614175-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add --with-openssl-engine
 autoconf option (auto|yes|no)
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

I have reformatted the indentation (your editor seems to have played
tricks with you, since configure.ac actually uses tabs, which the rest
doesn't...).  Tested on 3.0.0 and 1.1.1 builds.

3.0.0 does not report anything about "engine support" in the configure
output, which we might want to extend a bit ("checking for openssl engine
support... no" or such), but config.log and config.h show that it disabled 
things properly.

.. which makes "make check" much more happy, as it does no longer
try to build and run the libengine test, which always failed before
(with 3.0.0) - yay :-)

Your patch has been applied to the master branch.

commit 75fb5e1215f125a2ce472e10ae75b507262429b9
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:08 2021 +0200

     Add --with-openssl-engine autoconf option (auto|yes|no)

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23000.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


