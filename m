Date: Sun, 8 Jan 2023 17:43:57 +0100 (CET)
Message-Id: <202301081643.308Ghvxh091317@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230106005438.1664046-1-selva.nair@...277...>
References: <20230106005438.1664046-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix signal handling on Windows
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

I've stared at the code for a bit ("git show -w" helps), but not having
deep understanding of all windows/management intricacies, I can only say
"it looks reasonable".

I have also built a test binary (Ubuntu/MinGW) which behaved properly when
called from the CLI.  Tested F1, F2, F3, F4 and ctrl-C.

I have also recreated the test Lev has done, connect to a non-working
server with "--connect-retry 30" and try to press ctrl-c when sleeping -
did not work before, works now.

Your patch has been applied to the master and release/2.6 branch.

commit 22977577ed128ac953e7ebfe30f839bcf651b334 (master)
commit dec9c03d0f6e184fb6cce16b554491d62622425c (release/2.6)
Author: Selva Nair
Date:   Thu Jan 5 19:54:38 2023 -0500

     Fix signal handling on Windows

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230106005438.1664046-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25895.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


