Date: Thu, 4 Feb 2010 15:29:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100204142914.GT857@...1296...>
References: <4B6564E1.1000506@...515...> <4B6A9823.8010800@...1114...>
Mime-Version: 1.0
In-Reply-To: <4B6A9823.8010800@...1114...>
Subject: Re: [Openvpn-devel] New development process ready
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Feb 04, 2010 at 10:49:23AM +0100, David Sommerseth wrote:
> I am willing to maintain a testing tree, 

Thanks.  This is quite an important role, and I was refraining from
volunteering because I *know* I don't have enough time.

> but to make it maintainable and
> flexible for my ideas around this I'd prefer to keep this in a git tree.
>
> [ git layout and process ]

Makes sense to me.

> But I must warn those who wants to contribute patches as well.  I will
> be critical and easily rejective if certain "rules" are not followed.
> 
>   - All patches should be useful and beneficial for several OpenVPN
>     users, not just for "special case" situations.
>   - All patches must contain an argumentation for *why* this patch
>     should be included and *how* it solves the issue in plain English.
>   - Everyone who has contributed to this patch should be mentioned,
>     with at least a valid e-mail address, preferably with full name in
>     addition.  (I want to give credit to contributors!)
>   - All patches must be against the SVN development branch or git
>     master branch, at least until a feature branch is created.
>   - All initial patches must be sent as unified diff (diff -u)
>   - Patches must be sent to the openvpn-devel mailing list, at least
>     until a better patch tracker have been implemented.

Would you be willing to consider pulling branches from other repositories?

(I'm asking because the "IPv6 transport" stuff already lives in Berni's
git repository, and this might make things easier)

OTOH, running a "git diff" on our end is not that much work, though :-)

>   - Patches on the mailing list should preferably be start with [PATCH]
>     in the subject field.  (This will not cause a direct rejection, but
>     I might miss a contributed patch when parsing the mailing list)
>   - Patches sent to me directly *will* be rejected.  All patches must be
>     public and will be discussed in public.
>   - If a lot of merge conflicts turns up when applying the patch, I will
>     most likely reject the patch and ask for a new patch which applies
>     cleanly.

Overall, I think these rules make lots of sense.

I'd add another rule

    - All new code must be written following the OpenVPN coding conventions
      (code indenting, scratch memory handling with "gc", etc.)

Long-term maintenance of code written with different indent styles and
different ideas about memory management in different places is a 
nightmare.

> If someone maintains their code in a git tree already, I am willing to
> pull those git trees - as long as it will not cause any conflicts
> against the master/SVN development branch I am maintaining.  But!  Pull
> requests with an update of the changes must be sent to the mailing list.

Ah :-) - Question from above answered.  Cool.


> Further, I would prefer if we could arrange with a ACK/NACK system of
> patches.  That means that patches goes through minimum a "code review"
> by at least one other person on the openvpn-devel mailing list.  And if
> it looks good, it gives it either an ACK for acceptance or NACK for
> disapproving it.  Ideally, I would only implement those patches which
> gets at least one ACK.  The person ACKing would also be mentioned in the
> commit log.  This way, it's not only me who reviews patches and only
> contributions which makes sense to implement are included - and we avoid
> spoiling the code base with features which is only requested for very
> special conditions.

ACK!

> It would be great if all patch contributors who have contributed patches
> could contact me on IRC (freenode: ##openvpn-devel, nick: dazo),
> especially if they are not sure or they know that their patch has not
> been included yet in the SVN tree James keeps.

Will do tonight :-)

> Of course, I am only going to do this if the community *and* OpenVPN
> company accept my offer.  So unless somebody feel I'm not trustworthy or
> not capable of doing this job, I will step aside and let others do this
> job.  No hard feelings :)  But as I've not seen or heard about anyone
> stepping up yet, so I take the chance of doing that now.

Thanks for volunteering!

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

