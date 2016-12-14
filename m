References: <1481746052-17372-1-git-send-email-davids@...515...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3884b7d9-2d02-1f2d-48fe-329c3e259974@...1856...>
Date: Wed, 14 Dec 2016 21:28:21 +0100
MIME-Version: 1.0
In-Reply-To: <1481746052-17372-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] dev-tools: Add reformat-all.sh for code
 style unification
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 14-12-16 21:07, David Sommerseth wrote:
> Due to a bug in uncrustify 0.63

Should be 0.64.

> diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
> new file mode 100755
> index 0000000..11a6eca
> --- /dev/null
> +++ b/dev-tools/reformat-all.sh
> @@ -0,0 +1,136 @@
> +#!/bin/bash

If you replace the pushd/popd with a subshell, /bin.sh suffices (sligtly
more portable).

And, it's a good habit to start shell scripts with set -eu, to make sure
you exit on failures, and don't use uninitialised variables.

Finally, git complains about whitespace errors:

Applying: dev-tools: Add reformat-all.sh for code style unification
.git/rebase-apply/patch:173: trailing whitespace.

.git/rebase-apply/patch:192: trailing whitespace.

warning: 2 lines add whitespace errors.


Other than these details (and what Selva mailed), the patch looks good.

-Steffan

