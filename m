Date: Wed, 18 May 2022 11:41:58 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2008220979.1131565.1652866918794@...2642...>
In-Reply-To: <20220517210121.1312072-1-heiko@...2662...>
References: <20220517210121.1312072-1-heiko@...2662...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] pre-commit: uncrustify based on staged
 changes
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

Acked-By: Frank Lichtenheld <frank@...2641...>

Tested various combinations of workspace changes and index changes and
it seems to do what it should do.

> Heiko Hund <heiko@...2662...> hat am 17.05.2022 23:01 geschrieben:
> 
>  
> Previously the generated patch was based on the file(s) in the working
> directory. This is a problem if you have not to be commited changes
> there and these changes fix formatting issues that exist in the staging
> area. This effectively circumventes the script from rejecting the
> commit.
> 
> An example:
>    git add file.c
>    git commit
>    ... pre-commit hooks complains about formatting ...
>    ... you fix the file manually, forget to git add ...
>    git commit
>    ... succeeds, even though the commit still has issues ...
> 
> Signed-off-by: Heiko Hund <heiko@...2662...>
> ---
>  dev-tools/git-pre-commit-uncrustify.sh | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-commit-uncrustify.sh
> index a5cf3d41..9851c212 100755
> --- a/dev-tools/git-pre-commit-uncrustify.sh
> +++ b/dev-tools/git-pre-commit-uncrustify.sh
> @@ -97,6 +97,7 @@ fi
>  
>  # create a filename to store our generated patch
>  patch=$(mktemp /tmp/ovpn-fmt-XXXXXX)
> +tmpout=$(mktemp /tmp/uncrustify-XXXXXX)
>  
>  # create one patch containing all changes to the files
>  # sed to remove quotes around the filename, if inserted by the system
> @@ -106,21 +107,11 @@ sed -e 's/^"\(.*\)"$/\1/' | \
>  while read file
>  do
>      # ignore file if we do check for file extensions and the file
> -    # does not match any of the extensions specified in $FILE_EXTS
> +    # does not match the extensions .c or .h
>      if ! matches_extension "$file"; then
>          continue;
>      fi
>  
> -    # escape special characters in the source filename:
> -    # - '\': backslash needs to be escaped
> -    # - '*': used as matching string => '*' would mean expansion
> -    #        (curiously, '?' must not be escaped)
> -    # - '[': used as matching string => '[' would mean start of set
> -    # - '|': used as sed split char instead of '/', so it needs to be escaped
> -    #        in the filename
> -    # printf %s particularly important if the filename contains the % character
> -    file_escaped_source=$(printf "%s" "$file" | sed -e 's/[\*[|]/\\&/g')
> -
>      # escape special characters in the target filename:
>      # phase 1 (characters escaped in the output diff):
>      #     - '\': backslash needs to be escaped in the output diff
> @@ -136,15 +127,17 @@ do
>  
>      # uncrustify our sourcefile, create a patch with diff and append it to our $patch
>      # The sed call is necessary to transform the patch from
> -    #    --- $file timestamp
> -    #    +++ - timestamp
> +    #    --- - timestamp
> +    #    +++ $tmpout timestamp
>      # to both lines working on the same file and having a a/ and b/ prefix.
>      # Else it can not be applied with 'git apply'.
> -    "$UNCRUSTIFY" -q -c "$UNCRUST_CONFIG" -f "$file" | \
> -        diff -u -- "$file" - | \
> -        sed -e "1s|--- $file_escaped_source|--- \"a/$file_escaped_target\"|" -e "2s|+++ -|+++ \"b/$file_escaped_target\"|" >> "$patch"
> +    git show ":$file" | "$UNCRUSTIFY" -q -l C -c "$UNCRUST_CONFIG" -o "$tmpout"
> +    git show ":$file" | diff -u -- - "$tmpout" | \
> +        sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpout|+++ \"a/$file_escaped_target\"|" >> "$patch"
>  done
>  
> +rm -f "$tmpout"
> +
>  # if no patch has been generated all is ok, clean up the file stub and exit
>  if [ ! -s "$patch" ] ; then
>      rm -f "$patch"
> -- 
> 2.32.0
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--
Frank Lichtenheld

