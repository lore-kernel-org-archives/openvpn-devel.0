Date: Thu, 21 Apr 2022 10:01:29 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <866053733.106111.1650528089348@...2642...>
In-Reply-To: <20220420233148.2384208-1-heiko@...2662...>
References: <20220420233148.2384208-1-heiko@...2662...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Add git pre-commit hook script to
 uncrustify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

Definitive NACK due to licensing concern mentioned below.

> Heiko Hund <heiko@...2662...> hat am 21.04.2022 01:31 geschrieben:
> 
>  
> The script is self installing if you call it with "install" as the first
> parameter. Once installed as the pre-commit hook it will check files to
> be committed according to the rules in uncrustify.conf and abort the
> commit if there's formatting issues. The script produces a patch in /tmp
> which can be git apply'ed to fix all issues found.
> 
> The script was originally authored by David Martin [1] and slightly
> modified to fit our needs. At the time it had a 2-clause BSD license.
> 
> [1] https://github.com/ddddavidmartin/Pre-commit-hooks
> 
> Signed-off-by: Heiko Hund <heiko@...2662...>
> ---
>  dev-tools/git-pre-commit-uncrustify.sh | 146 +++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 dev-tools/git-pre-commit-uncrustify.sh
> 
> diff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-commit-uncrustify.sh
> new file mode 100644
> index 00000000..64e5e396
> --- /dev/null
> +++ b/dev-tools/git-pre-commit-uncrustify.sh
> @@ -0,0 +1,146 @@
> +#!/bin/sh
> +
> +# git pre-commit hook that runs an Uncrustify stylecheck.
> +# Features:
> +#  - abort commit when commit does not comply with the style guidelines
> +#  - create a patch of the proposed style changes
> +#
> +# More info on Uncrustify: http://uncrustify.sourceforge.net/
> +
> +# This file was taken from a set of unofficial pre-commit hooks available
> +# at https://github.com/ddddavidmartin/Pre-commit-hooks and modified to
> +# fit the openvpn project's needs

The BSD-2 license requires keeping the original copyright and license statement.
While the original pre-commit-uncrustify file had none of those, there is a
LICENSE file included in that repo. So I think you need to either copy that LICENSE
file and reference it here or just paste it completely into this file.

> +# exit on error
> +set -e
> +
> +
> +# If called so, install this script as pre-commit hook
> +if [ "$1" = "install" ] ; then
> +    ROOTDIR=$(git rev-parse --show-toplevel)
> +    HOOKSDIR="$ROOTDIR/.git/hooks"

Actually, the correct way to find the actual hooks directory is
git rev-parse --git-path hooks
That takes all configuration like $GIT_DIR and core.hooksDir into account.

> +    TARGET="$HOOKSDIR/pre-commit"
> +
> +    if [ -e "$TARGET" ] ; then
> +        printf "$TARGET file exists. Won't overwrite.\n"

Any reason we're using printf here instead of echo? The latter
would avoid the ugly line endings.

[...]
> +# create a filename to store our generated patch
> +prefix="ovpn-fmt"
> +suffix="$(date +%C%y%m%d%H%M%S)"
> +patch="/tmp/$prefix-$suffix.patch"

Are insecure tmp files still a concern? Because this is definitely an insecure tmp file...

[...]

Regards,
--
Frank Lichtenheld

