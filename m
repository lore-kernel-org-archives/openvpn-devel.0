Date: Wed, 11 Jan 2023 13:53:33 +0100 (CET)
Message-Id: <202301111253.30BCrXWD072674@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221127142506.41986-1-frank@...2641...>
References: <20221127142506.41986-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Always define
 options->management_flags
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

The ACK from Arne is not on the list, but it's in the quote from Frank,
so I can say "I have seen it" (and since the discussion went on about
a comment line, it's not a fake :-) ).  I have removed that comment
line per discussion on IRC.

Tested by compiling normally and with --disable-management, and asking
for a GHA test run.

Your patch has been applied to the master branch.

commit ff7d7989e007a8c66fba438a257c1b85e8bcca69 (master)
commit c8b131e5eb174a2c81a29a0b7eab5110e2e3ca19 (release/2.6)
Author: Frank Lichtenheld
Date:   Sun Nov 27 15:25:06 2022 +0100

     options: Always define options->management_flags

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20221127142506.41986-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25554.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


