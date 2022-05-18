From: Heiko Hund <heiko@...2662...>
Date: Wed, 18 May 2022 15:51:50 +0200
Message-ID: <82647152.mPejSR69WL@...2664...>
In-Reply-To: <2ff2762d-44d5-8192-9e90-e56f3c0c2367@...2181...>
References: <20220517210121.1312072-1-heiko@...2662...>
 <2ff2762d-44d5-8192-9e90-e56f3c0c2367@...2181...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

Hi

On Mittwoch, 18. Mai 2022 15:35:58 CEST Antonio Quartulli wrote:
> > -    # does not match any of the extensions specified in $FILE_EXTS
> > +    # does not match the extensions .c or .h
> 
> is this unrelated?

Yes, it is. The original script (collection) has a config file where $FILE_EXTS 
is defined. However, we hardcode this to C and header files only. Simply and 
oversight from the initial version drive-by fix.
 
> > -    # escape special characters in the source filename:
> > -    # - '\': backslash needs to be escaped
> > -    # - '*': used as matching string => '*' would mean expansion
> > -    #        (curiously, '?' must not be escaped)
> > -    # - '[': used as matching string => '[' would mean start of set
> > -    # - '|': used as sed split char instead of '/', so it needs to be
> > escaped -    #        in the filename
> > -    # printf %s particularly important if the filename contains the %
> > character -    file_escaped_source=$(printf "%s" "$file" | sed -e
> > 's/[\*[|]/\\&/g') -
> 
> this seems unrelated too?

See below.
 
> > -    #    --- $file timestamp
> > -    #    +++ - timestamp
> > +    #    --- - timestamp
> > +    #    +++ $tmpout timestamp
> 
> same?

See below.

> > +    git show ":$file" | diff -u -- - "$tmpout" | \
> > +        sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++
> > $tmpout|+++ \"a/$file_escaped_target\"|" >> "$patch"> 

Since the patch is now done differently $file_escaped_source is no longer 
needed. Instead we use $tmpout (the uncrustify output), which has a well 
defined (no need to being escaped) filename. 

The file contents we diff from stdin has changed as well. It is no longer the 
uncrustify output, but instead the file contents from the index (staged), thus 
the --- and +++ lines, we need to fix, switched as well.

Hope that explains it.

Heiko



