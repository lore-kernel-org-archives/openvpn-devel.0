Date: Thu, 27 Nov 2025 12:20:02 +0100 (CET)
Message-Id: <202511271120.5ARBK22D075082@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251127105343.30723-1-gert@...1296...>
References: <20251127105343.30723-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure/CMake: Remove unused
 checks
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

Thanks for taking care of this - these tools tend to use so much time
to find things that we couldn't handle a "no" as an answer for anyway...

We might consider getting rid of STRSEP as well (and the compat code) - I
briefly checked FreeBSD, Linux, Solaris, AIX and macOS and they all have
strsep() (nowadays? - well, the *BSDs since ever, "BSD 4.4").

Have not explicitly tested this anywhere, just stared at the changes for
a bit, and and trusted buildbot to notice - #218 green tests, no red.

Your patch has been applied to the master branch.

commit e52f03d42218913a651ec4a0b8b3ace98e459cfa
Author: Frank Lichtenheld
Date:   Thu Nov 27 11:53:37 2025 +0100

     configure/CMake: Remove unused checks

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1409
     Message-Id: <20251127105343.30723-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34740.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


