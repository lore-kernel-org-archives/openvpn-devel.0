Date: Sun, 23 Nov 2025 14:28:16 +0100 (CET)
Message-Id: <202511231328.5ANDSGDg083825@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251123115851.19555-1-gert@...1296...>
References: <20251123115851.19555-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: make sure registry
 string is terminated
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Trivial enough.

Not sure we really *need* this - the documentation for RegGetValueW()
states

    If the data is a string, the function checks for a terminating
    null character. If one is not found, the string is stored with
    a null terminator if the buffer is large enough to accommodate
    the extra character. Otherwise, the function fails and returns
    ERROR_MORE_DATA.

which reads to me like "either we get 'err' or it is always null 
terminated", so the "if (!err)" part would catch this anyway.

I have no way to actually test this beyond "does it compile" - which
it does.

Your patch has been applied to the master branch.

commit a1c41b0acb6905506ad35e339396206653fee5cc
Author: Heiko Hund
Date:   Sun Nov 23 12:58:46 2025 +0100

     iservice: make sure registry string is terminated

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1392
     Message-Id: <20251123115851.19555-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34610.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


