Date: Fri, 3 Apr 2020 10:45:43 +0200 (CEST)
Message-Id: <202004030845.0338jh9q045456@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1585591527-23734-2-git-send-email-selva.nair@...277...>
References: <1585591527-23734-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: When auth-user-pass file has no
 password, query the management interface
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

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code, basic compile / t_client test (which would not excercise
this particular code path) on mingw + freebsd.  Happily taking Jonathan's
"I've tested this on MacOS X with Tunnelblick" as "good enough for me" :-)

I have adjusted all occurrences of "the management" to "the management
interface", though I find "I have to go and ask the management" to be 
a fairly telling statement in itself :-) - I have also changed the
commit message subject slightly to point out that there this does not
happen "always".  The main text is clear enough.

Your patch has been applied to the master branch.

Can I have a joint patch for 2.4 that also updates Changes.rst, please?

(Changes.rst in the master branch needs a "redo from scratch" for 
the 2.5 release, but this should be mentioned for the 2.4.9 release
in release/2.4/Changes.rst)

thanks :)

commit 57578310992d1fbe8eff97049087c5308089acb5
Author: Selva Nair
Date:   Mon Mar 30 14:05:27 2020 -0400

     When auth-user-pass file has no password, query the management interface

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1585591527-23734-2-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19655.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


