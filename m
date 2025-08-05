Date: Tue, 5 Aug 2025 15:36:33 +0200 (CEST)
Message-Id: <202508051336.575DaXoE060687@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250805132706.27619-1-gert@...1296...>
References: <20250805132706.27619-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: clang-format: Switch to
 ColumnLimit 0
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

This has been stared-at, and subjected to testing in the client and server
testbeds ("you never know").

Some of the changes are slightly non-obvious - one thing we discovered
is that clang-format tries really hard to align end-of-line comments,
but only if you do not exceed "ColumnLimit".  If you do, all these
comments get "1 space, only, no matter how much they had before".

So, without the limit, some #endif comments ended up going to column 130-ish,
which made the result non helpful - so you see comments disappear now,
because the #ifdef/endif clauses were so short that it was obvious.

Also, errlevel.h got re-aligned now...  which is nice, but makes this
look much larger.

Your patch has been applied to the master branch.

commit 21f7d6e1ad65b1f7db673bc98764dc7325858e0b
Author: Frank Lichtenheld
Date:   Tue Aug 5 15:27:01 2025 +0200

     clang-format: Switch to ColumnLimit 0

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250805132706.27619-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32523.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


