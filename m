From: Heiko Hund <heiko@...2662...>
Date: Thu, 21 Apr 2022 14:48:23 +0200
Message-ID: <8555461.V0mEpUJ2Wj@...2664...>
In-Reply-To: <866053733.106111.1650528089348@...2642...>
References: <20220420233148.2384208-1-heiko@...2662...>
 <866053733.106111.1650528089348@...2642...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Frank

On Donnerstag, 21. April 2022 10:01:29 CEST Frank Lichtenheld wrote:
> > +# If called so, install this script as pre-commit hook
> > +if [ "$1" = "install" ] ; then
> > +    ROOTDIR=$(git rev-parse --show-toplevel)
> > +    HOOKSDIR="$ROOTDIR/.git/hooks"
> 
> Actually, the correct way to find the actual hooks directory is
> git rev-parse --git-path hooks
> That takes all configuration like $GIT_DIR and core.hooksDir into account.

Nice one, will add in v2.
 
> > +    TARGET="$HOOKSDIR/pre-commit"
> > +
> > +    if [ -e "$TARGET" ] ; then
> > +        printf "$TARGET file exists. Won't overwrite.\n"
> 
> Any reason we're using printf here instead of echo? The latter
> would avoid the ugly line endings.

Consistency. The script uses printf everywhere.

Heiko



