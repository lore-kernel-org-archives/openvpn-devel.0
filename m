Date: Sat, 22 Nov 2025 18:43:14 +0100 (CET)
Message-Id: <202511221743.5AMHhE7n045883@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251122155506.8901-1-gert@...1296...>
References: <20251122155506.8901-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: fix buffer size in
 call to FormatMessage
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

I have not actually tested this (beyond "does it compile") but reading
the docs about FormatMessageW() and the overall other code, this looks
very correct.

Your patch has been applied to the master branch.

It might be applicable to release/2.6, but we use a "TCHAR" there, not
a WCHAR - so that code might just be correct, or not.

commit b39bed539f218f6165d79224adbc343a63a4514d
Author: Heiko Hund
Date:   Sat Nov 22 16:55:00 2025 +0100

     iservice: fix buffer size in call to FormatMessage

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1387
     Message-Id: <20251122155506.8901-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34583.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


