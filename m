Date: Fri, 31 Jan 2025 20:10:58 +0100 (CET)
Message-Id: <202501311910.50VJAw6q061177@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250121161025.37545-1-frank@...2641...>
References: <20250121161025.37545-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: mudp.c: keep offset value when
 resetting buffer
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

Just for clarification: I'm taking the patch "v10" from the list, while
gerrit claims to have a "v12" - this is just due to rebasing and re-pushing,
but nothing at all has changed there.

I admit I haven't really closely looked what happens here, but it was
stared-at by Frank and Antonio, and both are fine.  The ASSERT() is
"this can never fail, but if it does, something is really wrong", so
we do not expect this to ever misfire ("all other buf_init() calls
also have an ASSERT()").

Tested on client and server testbed, with lots of UDP activity :-) - no
complaints.

Your patch has been applied to the master branch.

commit bfa5f0bdfe89d181f7b5f7af2ba34ab9357a1d13
Author: Lev Stipakov
Date:   Tue Jan 21 17:10:25 2025 +0100

     mudp.c: keep offset value when resetting buffer

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250121161025.37545-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30519.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


