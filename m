Date: Sun, 11 Oct 2020 20:25:41 +0200 (CEST)
Message-Id: <202010111825.09BIPfmr014799@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201005111614.29325-1-arne@...1227...>
References: <20201005111614.29325-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add function for common env
 setting of verify user/pass calls
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have stared at the code (with and without "-w").  Looks good.

Removal of duplicated code is always good, as well as reduced
indentation levels.  And if it fixes a bug, even better.

As a side note: "retval" in verify_user_pass_management() got
sillified now... only one code path, only one possible exit.

And we need to get rid of a few #ifdefs there...


Code has been tortured a bit on the server testbed - works
as before (using plugin-auth-pam in deferred mode with
must-succeed and must-fail tests).  No auth script and no 
management on the server today.

Client side has been tested for good measure, but is not 
executing these code paths at all.

I have not specifically tested the buggy situation (no testbed
for exactly that combination right now), but I know a production
setup running that combination - they will surely test RC3 with
the fix :-)

The stray half-sentence in the commit message was fed to the
whitespace dragon.

Your patch has been applied to the master and release/2.5 branch.

commit a4eeef17b20541a7afde0f1cbeae4a4e2b0c455a (master)
commit 09aad8b4e1df91b7b6ed5163390eae3730b17d32 (release/2.5)
Author: Arne Schwabe
Date:   Mon Oct 5 13:16:14 2020 +0200

     Add function for common env setting of verify user/pass calls

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201005111614.29325-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21174.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


