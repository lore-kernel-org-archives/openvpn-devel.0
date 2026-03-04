Date: Wed, 4 Mar 2026 17:11:49 +0100 (CET)
Message-Id: <202603041611.624GBnan063432@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260304142720.1311-1-gert@...1296...>
References: <20260304142720.1311-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable -Wsign-compare
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

Looks large, touches lots of files, but in effect does nothing more
than "remove -Wno-sign-compare from CMakeLists/Autoconf, and add
#pragma all over the place where we are hiding warnings, for now".

As we have agreed earlier on, this patch & the grunt of the "remove
a block of warning and the #pragmas coming with it" work will only
go to master (2.8-to-be).  If this excercise turns up real type handling
bugs, they get backported, of course.

Your patch has been applied to the master branch.

commit 4f0f2615f942feb3298f96b9c915d6682c5640e8
Author: Frank Lichtenheld
Date:   Wed Mar 4 15:27:12 2026 +0100

     Enable -Wsign-compare

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1386
     Message-Id: <20260304142720.1311-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35888.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


