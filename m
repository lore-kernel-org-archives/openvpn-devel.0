Date: Mon, 19 Dec 2022 16:29:04 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y6CDQFCTGH0hQ/NO@...2685...>
References: <Y5xOXLbRtka5Z81+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
 <20221219150226.467-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20221219150226.467-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] git-version.py: proper support for
 tags
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On Mon, Dec 19, 2022 at 05:02:26PM +0200, Lev Stipakov wrote:
[...]
>  v2: 
>   - try to get tag name before branch
>   - use "git describe --exact-match" instead of "git describe --tags"
>   - use subprocess.Popen() instead of os.popen() to suppress output

This now handles the tag case correctly.

But now you mishandle the no-branch and no-tag case because you
removed the "none" fallback. So if I just check out a commit
that is not tagged I get something like
 #define CONFIGURE_GIT_REVISION "/73cab72281deb631"

>  build/msvc/msvc-generate/git-version.py | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-generate/git-version.py
> index 814dc86a..89fd44f2 100644
> --- a/build/msvc/msvc-generate/git-version.py
> +++ b/build/msvc/msvc-generate/git-version.py
> @@ -24,15 +24,22 @@
>  
>  import os
>  import sys
> +import subprocess
> +
> +def run_command(args):
> +    sp = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
> +    o, _ = sp.communicate()
> +    return o.decode("utf-8")[:-1]
>  
>  def get_branch_commit_id():
> -    commit_id = os.popen("git rev-parse --short=16 HEAD").read()[:-1]
> +    commit_id = run_command(["git", "rev-parse", "--short=16", "HEAD"])
>      if not commit_id:
>          raise
> -    l = os.popen("git rev-parse --symbolic-full-name HEAD").read().split("/")[2:]
> -    if not l:
> -        l = ["none\n"]

I think it should be enough to reintroduce these two lines.

> -    branch = "/" .join(l)[:-1]
> +    branch = run_command(["git", "describe", "--exact-match"])
> +    if not branch:
> +        branch = run_command(["git", "rev-parse", "--symbolic-full-name", "HEAD"]).split("/")[2:]
> +        branch = "/" .join(branch) # handle cases like release/2.6
> +
>      return branch, commit_id

Regards,
-- 
  Frank Lichtenheld

