Date: Mon, 8 Sep 2025 12:17:13 +0200 (CEST)
Message-Id: <202509081017.588AHDaj036399@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250908083354.19811-1-gert@...1296...>
References: <20250908083354.19811-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: support float
 notifications on FreeBSD
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
To: openvpn-devel@lists.sourceforge.net

So, this is the second part of the "make float notifications on FreeBSD
for the 2.6 tree work" patch series, see
  https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=289303

It's a squash of two patches from master - because the first patch
introduced autoconf changes + #ifdefs that the second one then removed
again (because we decided that "nah, making this conditional does not
really help anyone").  No need to track that in release/2.6 - the 
"master" commit IDs are linked.

Both original patches are from Kristof, so recording him as author
of the squashed patch.  I did the work, Ralf verified that I got it
right :-)

Two assert() have been pointed out as "this is questionable", and the
next patch will replace these and all others in the code with OpenVPN
ASSERT(), plus explaining more background.


This patch affects only FreeBSD (dco_freebsd.h and #ifdef TARGET_FREEBSD),
and has been tested there, confirming that DCO float now works and nothing
else breaks.

Your patch has been applied to the release/2.6 branch (bugfix-ish).

commit 3c9fe881207df94e938ba7325a0cd46765d6ba6c
Author: Kristof Provost
Date:   Mon Sep 8 10:33:49 2025 +0200

     dco: support float notifications on FreeBSD

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Ralf Lici <ralf@...2726...>
     Message-Id: <20250908083354.19811-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32827.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


