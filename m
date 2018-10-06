Date: Sat, 6 Oct 2018 17:26:30 +0200 (CEST)
Message-Id: <201810061526.w96FQUTD057664@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171112084830.22912-1-a@...2181...>
References: <20171112084830.22912-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: merge *-inline.h files with
 their main header
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I had to mangle the patch a bit so it could apply - the copyright notice
and company name changed, so "remove foo-inline.h" failed due to textual
differences.  In addition, the patch had #ifdef ENABLE_CRYPTO still in
(which I all removed).

Also, someone changed misc.h to run_command.h in "multi.c" in the 
meantime... - but these are all not actual code changes, just rebasing 
due to the age of this patch.  Sorry for letting it linger so long.

Also, change "fowrard.h" to "forward.h" in the commit message :)

Verified by "git diff --color-moved=zebra" and test building.

commit 76939e963687e8b87388d3c981009cda9a246906
Author: Antonio Quartulli
Date:   Sun Nov 12 16:48:30 2017 +0800

     merge *-inline.h files with their main header

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20171112084830.22912-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15838.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


