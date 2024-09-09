Date: Mon, 9 Sep 2024 08:56:09 +0200 (CEST)
Message-Id: <202409090656.4896u92M048226@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240719131407.75746-1-frank@...2641...>
References: <20240719131407.75746-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Static-challenge concatenation
 option
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

Thanks for your patience, and sorry for taking so long... vacation and
other excuses.

Haven't actually tested for good (a --static-challenge setup is on my
TODO list since like 100 years...), but the code looks reasonable, it
passes all "non-challenge" tests, and has an ACK from Frank :-) - and
a few basic tests with "run client from cli, look what plugin-auth-pam
reports on the other end" confirm that it does the job.

Is the GUI support already committed?  I seem to remember seeing a PR
for that "weeks ago"... and someone needs to bring Tunnelblick on board.

Your patch has been applied to the master branch.

commit 6f6a0f362f845f042a965f797b731f8931310372 (master)
Author: Selva Nair
Date:   Fri Jul 19 15:14:07 2024 +0200

     Static-challenge concatenation option

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240719131407.75746-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28943.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


