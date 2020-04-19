Date: Sun, 19 Apr 2020 12:40:25 +0200 (CEST)
Message-Id: <202004191040.03JAePrk011606@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200416113930.15192-3-arne@...1227...>
References: <20200416113930.15192-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: After the last big formatting
 patch a number of changes have been commited that do not conform with our
 style/uncrustify config. This has lead to the problem that running
 uncrustify on before sending PR some of the changes made by uncrustify need
 to be backed out again.
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

Verified the changes manually and by test compiling (Linux and FreeBSD)
- with "git show -w" one can see that most of it is simple whitespace
changes, and the rest is "change line wraps" and "add comment to #endif"
stuff.

The manage.c change is particularily ugly, but with a function name
that long and multiple (long) arguments, there is not really a way
that an automated tool can make this look *nice* (except if it had
a rule for "if the indended indent is > 50 chars, limit to 50" or
so - but then it would just be inconsistent).

Your patch has been applied to the master branch.

I've modified the commit message slightly (put the long text in the body,
add a shorter subject)

commit 9cf7b4925a54d93fbea1cadcf3dc0e11f3ce358f
Author: Arne Schwabe
Date:   Thu Apr 16 13:39:30 2020 +0200

     Another round of uncrustify code cleanup.

     After the last big formatting patch a number of changes have been commited that do not conform with our style/uncrustify config. This has lead to the problem that running uncrustify on before sending PR some of the changes made by uncrustify need to be backed out again.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200416113930.15192-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19750.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


