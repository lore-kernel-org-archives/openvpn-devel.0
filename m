Date: Tue, 15 Apr 2025 17:35:21 +0200 (CEST)
Message-Id: <202504151535.53FFZLXp057602@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250414180636.31936-1-gert@...1296...>
References: <20250414180636.31936-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: implement --dns option
 support with NRPT
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

I'm not claiming to be an expert on Windows code and NRPT especially,
but I've stared hard at the code and this all seems to make sense
(including and especially memory and string handling).  Lev tested
this in detail, I just compile tested.

(The code change to openvpn itself is fairly straightforward and not
that windows specific.  The code change to the iservice is a tough one :-) ).

As discussed on IRC, sorry for the "%s" messup - but I would really
appreciate having "code fixes" and "new code" in separate commits, as
that makes reviewing & shipping the "fixes" quicker, and reviewing the
"new code" easier (less lines...).

Your patch has been applied to the master branch.

commit 0f3b7d17d565a422bfddc0f393b7712031e5bdbb
Author: Heiko Hund
Date:   Mon Apr 14 20:06:26 2025 +0200

     win: implement --dns option support with NRPT

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250414180636.31936-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31426.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


