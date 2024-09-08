Date: Sun, 8 Sep 2024 22:06:01 +0200 (CEST)
Message-Id: <202409082006.488K61iX084283@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906112908.1009-1-gert@...1296...>
References: <20240906112908.1009-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Protect cached username,
 password and token on client
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

Thanks for taking up the challenge :-) - and I think the approach is 
quite reasonable, and also extensible should one of the other OSes come
up with a similar memory protection function one day ("crypt with a key
outside the program's own memory").

I have test compiled this "for windows" via GHA/MSVC and locally with
MinGW.  Haven't actually tested the windows binary.

More important, since this adds an ASSERT() to a few server-side code path,
fed to the server-side testbed which has user+pass & auth-token instances,
and this all still works :-)

Your patch has been applied to the master and release/2.6 branch
(security hardening).  2.6 lacks the test_user_pass.c file, so that
hunk was omitted.

commit 12a9c357b6a7b55bea929eb5d9669e6386ab0d0e (master)
commit 9e1598de43383ac655fd71bd34021026ac105f23 (release/2.6)
Author: Selva Nair
Date:   Fri Sep 6 13:29:08 2024 +0200

     Protect cached username, password and token on client

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240906112908.1009-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29079.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


