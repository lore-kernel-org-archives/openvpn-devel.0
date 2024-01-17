Date: Wed, 17 Jan 2024 14:32:43 +0100 (CET)
Message-Id: <202401171332.40HDWhwH089857@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240117090840.32621-1-gert@...1296...>
References: <20240117090840.32621-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: NTLM: increase size of phase 2
 response we can handle
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

Change seems reasonable.  Affects only NTLM stuff, adds better error
reporting and takes large domains/usernames into account.

Smoke tested on GHA and buildbot (no NTLM tests right now, though).

Your patch has been applied to the master branch.

release/2.6 is sufficiently different that a separate patch has been 
posted, which will be handled next :-)

commit d3c9ceecfeab5e34c774b928596ec3c233abc36d (master)
Author: Frank Lichtenheld
Date:   Wed Jan 17 10:08:39 2024 +0100

     NTLM: increase size of phase 2 response we can handle

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240117090840.32621-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28040.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


