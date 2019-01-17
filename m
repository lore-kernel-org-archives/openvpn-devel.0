Date: Thu, 17 Jan 2019 18:42:53 +0100 (CET)
Message-Id: <201901171742.x0HHgrBO093445@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181112122246.13556-1-simon@...2293...>
References: <20181112122246.13556-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Delete TAP interface before the
 TAP driver is uninstalled
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

Acked-by: Gert Doering <gert@...1296...>

The explanation of "what could possibly go wrong" sounds logical, and
the code change seems to match that (... and has no obvious pitfalls).

Test compiled on ubuntu 16.04 / mingw.

I have not tested this (because I have no idea how to trigger all these
scenarios) so I trust you and Tincantech to have tested the variants
(automated regression testing of this stuff is going to be interesting).

The comment lines are a bit on the long side ("<80 characters, please")
but I've seen an upcoming uncrustify patch, so I hope that will be taken
care of.

Your patch has been applied to the master branch.

commit 39c9811e7d3a509405b2986e9684a99054f25923
Author: Simon Rozman
Date:   Mon Nov 12 13:22:44 2018 +0100

     Delete TAP interface before the TAP driver is uninstalled

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181112122246.13556-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17906.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


