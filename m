Date: Wed, 23 Oct 2024 14:02:56 +0200 (CEST)
Message-Id: <202410231202.49NC2udf028582@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241023113923.7420-1-gert@...1296...>
References: <20241023113923.7420-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix for msbuild/mingw GHA
 failures
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for quickly fixing this.  (Morale 1: don't do "while I am here,
let's clean up this other thing" changes..., Morale 2: we need windows
builds in gerrit/buildbot)

I've reworded the commit message a bit, to reference the actual commit
ID in question, and to make it more clear what happened.

The patch itself is a trivial undo of those 2 lines, easily verified
with "git diff HEAD~2".

(A later patch in the series actually does the same thing, when moving
the code to multi_io.c - so "test the whole tree via GHA" did not
expose the problem)

Your patch has been applied to the master branch.

commit 3636da3b0f168d8e06a00ec5d1f33e4b9aded262
Author: Gianmarco De Gregori
Date:   Wed Oct 23 13:39:23 2024 +0200

     Fix for msbuild/mingw GHA failures

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241023113923.7420-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20241023113923.7420-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


