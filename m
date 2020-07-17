Date: Fri, 17 Jul 2020 09:52:04 +0200 (CEST)
Message-Id: <202007170752.06H7q4N4006267@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200716225338.611-2-davids@...515...>
References: <20200716225338.611-2-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc/man: Add an .rst formatted
 version of the man page
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have not really "reviewed" this (this would require a full side-by-
side reading of old and new manpage, and nobody ever reads the 
openvpn manpage from top to bottom...) - but I've skimmed through
it, and it made me laugh... :-)  ("OpenVPN ... lightweight footprint").

File sizes are similar, and there is no obvious "mistakes" in the rst
(like, duplications, or random garbage).

-rw-r--r--  1 gert  users  243522 Jun 26 14:33 openvpn.8
-rw-r--r--  1 gert  users  225588 Jul 17 09:29 openvpn.8.rst

$ wc -w openvpn.8 openvpn.8.rst
   35162 openvpn.8
   31700 openvpn.8.rst


There are (at least) two whitespace errors, where an alt-space (0xA0)
shows up at the end of a line, after a ^A character.  I have not changed
these, because it gets split into individual files anyway, and then
I have to re-do it.

Your patch has been applied to the master branch.

For the URL reference, I had to switch to the sourceforge archive as 
mail-archive.org does not accept such big mails.

commit d47b928d4e0501acdf1e449ad59951a19dd154a2
Author: David Sommerseth
Date:   Fri Jul 17 00:53:31 2020 +0200

     doc/man: Add an .rst formatted version of the man page

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200716225338.611-2-davids@...515...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/37063370/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


