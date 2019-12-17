Date: Tue, 17 Dec 2019 21:00:06 +0100 (CET)
Message-Id: <201912172000.xBHK06EG095833@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191217124410.81-1-lstipakov@...277...>
References: <20191217124410.81-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: ring buffers based I/O
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have "forward-logged" Steffan's ACK on the v6 patch as the v8 is
close enough, except for the "struct win_tun" change (which look 
reasonable),  plus Simon's ACK.

What I do not like is code that uses malloc() and then calls ZeroMemory()
right after.  calloc() exists.  Standard-based, less lines of code.

No reason to NAK this, but maybe this can be fixed in a followup patch
(and put on our styleguide somewhere?)...

Compile-tested on Ubuntu 16.04 / mingw (which worked fine).  No own
code review or any sort of testing done.

commit d5fc4bd41616ee01816df873cb6b6567872a29e2
Author: Lev Stipakov
Date:   Tue Dec 17 14:44:10 2019 +0200

     wintun: ring buffers based I/O

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20191217124410.81-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19243.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


