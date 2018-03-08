Date: Thu, 8 Mar 2018 17:03:09 +0100 (CET)
Message-Id: <201803081603.w28G39Mx090857@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1512734870-17133-8-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-8-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move env helper functions into
 their own module/file
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Does what it says on the lid: code is moved 1:1 with no code changes, 
and only #include lines are adjusted elsewhere (which is actually painful
to review in this case, as the "moved out" stuff was scattered along
misc.c and parts ended in env_set.h, so "plain diff" between old-misc.c 
and new-env_set.c didn't help much.  "git show --color-moved" helps, tho).

Two small catches: 

 - this collided with 06ad53e067d9a8b and setenv_long_long() being 
   changed from "%lld" to PRIi64 - so I changed the patch accordingly
   so that it still only moves lines from misc.c to env_set.c

 - the hunk that adds env_set.c to "some of the test modules" caused
   build fails here (because it was added to the wrong module, assuming
   test code that wasn't there yet) - so I've removed it.  I'm aware
   that this will cause build failures later on when the test driver in
   question shows up, but then I'll re-add it.  "Building test code"
   follows slightly easier rules on "changing patches" :-)

Your patch has been applied to the master branch.

commit 68b97b25e4c479156d697bf3df90a4b68fbbbcea
Author: Steffan Karger
Date:   Fri Dec 8 13:07:47 2017 +0100

     Move env helper functions into their own module/file

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1512734870-17133-8-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16066.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


