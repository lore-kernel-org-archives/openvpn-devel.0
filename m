Date: Fri, 25 Jun 2021 18:02:32 +0200 (CEST)
Message-Id: <202106251602.15PG2W2L002548@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210625010405.224-1-lstipakov@...277...>
References: <20210625010405.224-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix console prompts with
 redirected log
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

Acked-by: Gert Doering <gert@...1296...>

Thanks for that.  Stared-at-code (looks good and much more "I understand
how this works" than before :-) ).  Test built on ubuntu/mingw, but not
actually tested the resulting binary - but I did test the openvpn.exe
that Lev built with MSVC for amd64, and it is working nicely for all
tested cases ("openvpn.exe --auth-user-pass --log file.txt --config ..."
actually prompts now, which it didn't before - GUI and CLI tested,
with and without auth-user-pass and passphrase prompts)

Your patch has been applied to the master and release/2.5 branch (bugfix).

commit 480e4cc14ff34fac72406ab1dd66290a91cc09f0 (master)
commit 86b247a40b919fa8e0a3de1c367087355bb10074 (release/2.5)
Author: Lev Stipakov
Date:   Fri Jun 25 04:04:05 2021 +0300

     Fix console prompts with redirected log

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210625010405.224-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210625010405.224-1-lstipakov@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


