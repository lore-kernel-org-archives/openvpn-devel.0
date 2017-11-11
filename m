From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 11 Nov 2017 18:09:52 +0100
Message-ID: <2986665.LhKa9TOmFL@...2319...>
In-Reply-To: <9c305096-7d5c-5272-85a4-df5b9652a8d7@...2080...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
 <1477672963-5724-6-git-send-email-heiko.hund@...1489...>
 <9c305096-7d5c-5272-85a4-df5b9652a8d7@...2080...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 5/7] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi David,

On Wednesday, November 9, 2016 9:41:21 PM CET David Sommerseth wrote:
> In the new argv_prep_format() function:
> 
> +      if (!in_token)
> +        {
> +          ++*count;
> +          if (f[0])
> +            f[j++] = delim;
> +        }
> 
> What is the purpose of the f[0] check?  At first glance it looks like a
> NOOP, as you'd expect f[0] to always have a value > 0.  But that is just
> until you've parsed something which have been put into f, so I presume
> it is some kind of "lock" to not write a delimiter as the first byte in
> a string.

That check is there to not add a delimiter after leading spaces, I've added a 
comment in v2 of the patch.
 
> Can this whole function be made a bit simpler to understand, as I'm
> struggling to fully follow what happens and why?  If I spend enough time
> digging into this, I will understand it ... but I prefer code which is
> easier to understand at first glance, unless the task can't be resolved
> with less complexity.

Added comments to explain what's happening in argv_prep_format() and 
argv_printf_arglist(). Especially the first one does more than just copying the 
format string buffer, so its complexity is justified.

> So to argv_printf_arglist():
> 
> +  va_copy (tmplist, arglist);
> +  len = vsnprintf (NULL, 0, f, tmplist);
> +  va_end (tmplist);
> +  if (len < 0)
> +    goto out;
> 
> This is reasonably okay, but would benefit from a comment simply
> explaining what you do here.  I presume it is a kind of estimated
> strlen() operation of the final formatted string.

Done.

> Wed Nov  9 21:37:26 2016
> Wed Nov  9 21:37:26 2016 openvpn_execve: called with empty argv
> Wed Nov  9 21:37:26 2016 Exiting due to fatal error
> 
> Reverting this patch makes t_cltsrv.sh succeed, so pretty sure this
> patch is the one to blame for this error.

Nice catch! This was triggered by the use of strtok(), which only returns 
nonempty tokens. During shutdown openvpn passes empty strings to the down 
script, which triggered this. Not using strtok() anymore and also added a unit 
test for empty string parameters.

Cheers
Heiko

