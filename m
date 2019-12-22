Date: Sun, 22 Dec 2019 20:14:56 +0100 (CET)
Message-Id: <201912221914.xBMJEuFW088413@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191220161117.1434-5-simon@...2293...>
References: <20191220161117.1434-5-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: add support for
 --dev-node
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Compile-tested on Ubuntu 1604/mingw, stared a bit at the code, seems
to make sense :-)

(I do wonder if it makes sense to just use the driver we found if
--dev-mode was specified, and auto-sense whether this should be handled
as tap6 or wintun - after all, if one option is specifying exactly what
the user wants, why require a second option to be set to something we
can infer?  But that's fine tuning for special cases)

commit d7142c7d883602c6083f65037a52fa1a9df10861
Author: Simon Rozman
Date:   Fri Dec 20 17:11:15 2019 +0100

     wintun: add support for --dev-node

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20191220161117.1434-5-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19282.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


