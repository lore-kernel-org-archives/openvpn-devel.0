Date: Fri, 17 Oct 2025 11:06:35 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <aPIHG1mIkWzafoak@...2685...>
References: <20251004141935.17815-1-gert@...1296...>
 <202510041605.594G5lcj088673@...2054...>
MIME-Version: 1.0
In-Reply-To: <202510041605.594G5lcj088673@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: route: Fix a
 unused-but-set-variable warning on OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, Oct 04, 2025 at 06:05:47PM +0200, Gert Doering wrote:
> This is not my most favourite patch in this series... but the alternative
> is "more #ifdefs" (nah) or "more code duplication" (nah).  In these system
> dependent parts, some compromises need to be made... 
> 
> Didn't actually *test* anything, as it's very explicit not doing anything :-)
> (and BB says "it still compiles and tests fine everywhere").
> 
> Your patch has been applied to the master branch.

Can you please also apply this to release/2.6? It applies cleanly and otherwise
buildbot is unhappy on obsd75. We currently have no easy way to make
--enable-werror conditional on the branch.

Thanks,
  Frank

> 
> commit 9243ea88913fc1bed26c25ba7d7b18bb2f16fa4c
> Author: Frank Lichtenheld
> Date:   Sat Oct 4 16:19:30 2025 +0200
> 
>      route: Fix a unused-but-set-variable warning on OpenBSD
> 
>      Signed-off-by: Frank Lichtenheld <frank@...2641...>
>      Acked-by: MaxF <max@...2606...>
>      Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1214
>      Message-Id: <20251004141935.17815-1-gert@...1296...>
>      URL: https://sourceforge.net/p/openvpn/mailman/message/59242246/
>      Signed-off-by: Gert Doering <gert@...1296...>

-- 
  Frank Lichtenheld

