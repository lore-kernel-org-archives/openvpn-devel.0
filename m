Date: Sat, 30 Sep 2017 12:34:00 +0200 (CEST)
Message-Id: <201709301034.v8UAY0iZ090204@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170928031620.22331-1-hashiz@...2305...>
References: <20170928031620.22331-1-hashiz@...2305...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fixed that "--bind ipv6only"
 did not work due to incorrect parameter processing. It seems that
 "ipv6only" did not work from the beginning.
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
To: hashiz <hashiz@...2305...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.

I have modified the commit message to refer to the commit that broke this,
and added a short first line (which is what shows up in "git shortlog",
so you want this to be less than ~60-70 charcters, not multilien).

Your patch has been applied to the master and release/2.4 branch.

commit cdeba63ca3a9e5c765edecd11745e9e2cc1b945d (master)
commit b0ef0003c554db34f5623a920874c97b22bc0224 (release/2.4)
Author: hashiz <hashiz@...2305...>
Date:   Thu Sep 28 12:16:20 2017 +0900

    Fix '--bind ipv6only'
    
    Commit 3d6a4cded2b20fb81 introduced checking for "too many parameters"
    at option processing, and neglected to take "ipv6only" as possible
    (and optional) argument to "--bind" into account.
    
    Trac: #938

    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <20170928031620.22331-1-hashiz@...2305...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15522.html
    Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,




