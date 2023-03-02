Date: Thu, 2 Mar 2023 18:19:09 +0100 (CET)
Message-Id: <202303021719.322HJ9VX002701@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230301091851.82243-1-kprovost@...2661...>
References: <20230301091851.82243-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: options.c: enforce a minimal
 fragment size
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Straightforward :-) - and we really shouldn't divide by zero..

I have adjusted the message to read "--fragment ..." (with dashes),
because that's what we seem to do in other option-related error
messages.

Your patch has been applied to the master and release/2.6 branch.

commit 78e504210add19343e65f5c5b80be9ea6e9e95ab (master)
commit b9a9de156bc3ad517bfc6d1042ad0ef0350b638e (release/2.6)
Author: Kristof Provost
Date:   Wed Mar 1 10:18:51 2023 +0100

     options.c: enforce a minimal fragment size

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230301091851.82243-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26313.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


