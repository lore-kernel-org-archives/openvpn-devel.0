Date: Sat, 11 Nov 2023 09:45:48 +0100 (CET)
Message-Id: <202311110845.3AB8jm0N004084@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231111081808.30967-1-gert@...1296...>
References: <20231111081808.30967-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: platform.c: Do not depend
 Windows build on HAVE_CHDIR
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

This patch will do the job, but I think (at least for "master") we should
do a bit more thorough job - as in, get rid of HAVE_CHDIR completely, in
autoconf, cmake, header files.  There is no platform where we have a remote
chance in getting OpenVPN ported that has no chdir(), so this is all
a nice excercise in achieving nothing.

I have not tested this beyond "does it compile?" but the change looks
reasonable and Lev has ACKed it.

Your patch has been applied to the master and release/2.6 branch.

commit 012ea92c414282488e3d60c87452849bde64aac4 (master)
commit b705517b12d14876a12593416a45756b7a952f1e (release/2.6)
Author: Frank Lichtenheld
Date:   Sat Nov 11 09:18:08 2023 +0100

     platform.c: Do not depend Windows build on HAVE_CHDIR

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20231111081808.30967-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27362.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


