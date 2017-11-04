Date: Sat, 4 Nov 2017 19:34:41 +0100 (CET)
Message-Id: <201711041834.vA4IYfGA026870@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <87k1zi18lt.fsf@...2274...>
References: <87k1zi18lt.fsf@...2274...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print time_t as long long and
 suseconds_t as long
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
To: Jeremie Courreges-Anglas <jca@...2272...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  Reviewed by "staring at the code" (changes are only what it
says on the tin), compiling with clang and gcc (no format related warnings),
and running tests, of course :-)

I'm a bit undecided whether this should go to release/2.4 as well, as it
is "refactoring" and our general policy is "refactoring goes into master"
(but then it's straightforward enough).  Leaving it in master for now, 
but I can be convinced that we want this in 2.4...

Your patch has been applied to the master branch.

commit 31b5c0e9a0c10f59a0e987a9e1f82e9268b30e61 (master)
Author: Jeremie Courreges-Anglas
Date:   Thu Oct 26 11:40:05 2017 +0200

     Print time_t as long long and suseconds_t as long

     Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <87k1zi18lt.fsf@...2274...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15667.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


