Date: Mon, 24 Nov 2025 18:51:03 +0100 (CET)
Message-Id: <202511241751.5AOHp30S042308@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251124165311.14859-1-gert@...1296...>
References: <20251124165311.14859-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Harden interactive service pipe
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for taking this on.

I've stared lightly at the code and it looks good.  Lev has tested it
and it does what it says on the lid - make the pipe name nearly impossible
to guess.  Path name length is also not a problem (max 256, plenty of
room to grow).

Your patch has been applied to the master branch.

I think the release/2.6 branch would also benefit from this one (at
least) but it does not want to get in - TEXT() vs. L() changes, at least.


commit 05d0808ee65d68691b0133f5fc3c09bfdba5259d (master)
Author: Selva Nair
Date:   Mon Nov 24 17:53:06 2025 +0100

     Harden interactive service pipe

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1396
     Message-Id: <20251124165311.14859-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34638.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


