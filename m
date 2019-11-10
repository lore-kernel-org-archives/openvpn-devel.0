Date: Sun, 10 Nov 2019 11:48:25 +0100 (CET)
Message-Id: <201911101048.xAAAmPDv098883@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191110100323.13206-1-a@...2181...>
References: <20191110100323.13206-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: add -Wno-stringop-truncation to
 CFLAGS on linux
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

While I'm not exactly happy suppressing warnings, this particular one
is somewhat of an annoyance - the two cases where we cause warnings
today are perfectly fine, and working around spurious compiler warnings
is not what I want to spend our time on.   We can revisit this later.

Your patch has been applied to the master branch.

commit 46d096074fd74e0d6c1d4756429215d22f2b3441
Author: Antonio Quartulli
Date:   Sun Nov 10 11:03:23 2019 +0100

     add -Wno-stringop-truncation to CFLAGS on linux

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191110100323.13206-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19085.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


