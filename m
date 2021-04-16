Date: Fri, 16 Apr 2021 18:56:58 +0200 (CEST)
Message-Id: <202104161656.13GGuwfT016081@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210408120029.19438-1-arne@...1227...>
References: <20210408120029.19438-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Always save/restore pull options
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

The code looks good, and the local test for the "pull" case works,
unsurprisingly (as it does the very same things in that case).  It might
trigger different behaviour for the "non pull" case - but then, it puts
everything back to where it was before (if saved), so I do not expect
surprises.  Client side testing and "break the things we know are
broken on save/restore today" (compress etc) works as expected.

This is a (fairly light) refactoring patch, but as it is prerequisite for 
two further patches (and maybe more) that are actual bugfixes, I considered
putting into 2.5 as well.  It does not want to go in (#ifdef P2MP, and
conflicts with the NCP saving patch), so I'll backport the "compress"
and "route-*gateway" patch manually.  Those are trivial enough.

Your patch has been applied to the master branch.

commit c1150e5b95b63a95ee4f157d8870d3214099d8a0
Author: Arne Schwabe
Date:   Thu Apr 8 14:00:27 2021 +0200

     Always save/restore pull options

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210408120029.19438-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22079.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


