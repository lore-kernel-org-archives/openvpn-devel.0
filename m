Date: Mon, 18 Mar 2024 18:57:46 +0100 (CET)
Message-Id: <202403181757.42IHvkfu098022@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240315170054.2368254-1-frank@...2641...>
References: <20240315170054.2368254-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update Copyright statements to
 2024
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

Acked-by: Gert Doering <gert@...1296...>

Like Christmas... happens every year :-)  - verified that this, indeed,
only affects copyright lines ("git show -I '^ \*  Copyright') - I guess
it was produced by update-copyright.sh anyway, but review is what I do...

The only actual code change is the msg() in options.c

For some unknown reason, the mail-archive.com list archive does not have
the original e-mail, but the sourceforge one has - so I'm linking to
that URL.

Your patch has been applied to the master and release/2.6 branch.

Cherry-Picking to 2.6 upset git a bit (conflict in sig.c and lots of
complaints about unit test files not existing in release/2.6) - but
all quite obvious.

commit b25c6d7e861d446b7a2e03cbcfb892d554c1ef73 (master)
commit ff06f4ca4290fde46019d61d9c1039ad05b12701 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Mar 15 18:00:54 2024 +0100

     Update Copyright statements to 2024

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240315170054.2368254-1-frank@...2641...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/58749316/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


