Date: Sat, 25 Feb 2023 17:29:18 +0100 (CET)
Message-Id: <202302251629.31PGTIw9077391@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230214200804.600405-1-selva.nair@...277...>
References: <20230214200804.600405-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a unit test for functions
 in cryptoapi.c
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

Acked-by: Gert Doering <gert@...1296...>

Thanks for the v4.  This enabled me to just push to GH to have
to build and run the tests, without having to bother myself with
copying binaries around :-) 

OTOH, there might be a bit of polishing needed - the other tests
print out what they are doing ("Running 7 test(s)"), while the
cryptoapi unit test "just succeeds".  Is there something missing
wrt cmocka initalization?

  https://github.com/cron2/openvpn/actions/runs/4270790193/jobs/7434873211


I also did do a MinGW "make check" and it built the new test binary
just fine, and succeeded otherwise.

   298368    704 -rwxrwxr-x   1 gert     gert       718042 Feb 25 16:10 ./tests/unit_tests/openvpn/.libs/cryptoapi_testdriver.exe

The unit test itself looks reasonably complete in testing expected
and error-handling behaviour (v3->v4).  Not much coverage beyond 
"parse_hexstring()", but it's a good start to build upon :-)

Your patch has been applied to the master and release/2.6 branch.

commit 8aff5655a51d9f9f67ca31b363d4ebaf5342d410 (master)
commit 094aea56ce20d0bb6fe79e6e14a3dfe68ea11786 (release/2.6)
Author: Selva Nair
Date:   Tue Feb 14 15:08:04 2023 -0500

     Add a unit test for functions in cryptoapi.c

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230214200804.600405-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26268.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


