References: <1456171763-44172-1-git-send-email-fish.thss@...277...>
	<20160225122928.GC24952@...1296...>
	<56CEF9E5.3090508@...2080...>
	<56D0496A.2050301@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56D3FE0D.5010107@...515...>
Date: Mon, 29 Feb 2016 10:15:09 +0200
MIME-Version: 1.0
In-Reply-To: <56D0496A.2050301@...2080...>
Subject: Re: [Openvpn-devel] The puprose of the Signed-off-by: line
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


>>> The reason of adding the Signed-off-by is to have a better understanding
>>> of whom have been involved in particular commits/patches.  While the
>>> "Author field" in the git log (git log --pretty=3Dfuller) can only have
>>> one name, more people can have been involved in the patch.  Using the
>>> Signed-off-by is a way to credit them as well.
>>>
>>> And when everyone is consistent using the Signed-off-by line, writing
>>> tools which parses our git log is also far more easier.
>>>
>>> The other aspect of the Signed-off-by: line has to do with juridical
>>> stuff, to protect the OpenVPN project.  By adding the Signed-off-by:
>>> line you basically sign-off to "Yes, I am the author of these changes
>>> and I am permitted to share them with the project".  For more
>>> information, these pages explains it even better (same info, two
>>> different sources):
>>> <https://git.eclipse.org/r/Documentation/user-signedoffby.html>
>>> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/SubmittingPatches#n409>
>>
>> Hi David,
>>
>> Looks like the rationale for Signed-off-by by is not properly documented=
 in Trac:
>>
>> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
>>
>> David: do you want to integrate above explanation to Trac or shall I?
>
> I intended to update the wiki page as well.  It should be updated.  The
> trouble is that I started thinking.  But I think we should do some more
> modifications to more of this process.
>
> There are two things I think we should agree upon first, which is
> slightly different compared to the wiki page.
>
>
> 1) It probably makes more sense to use Reviewed-by: instead of
>     Signed-off-by: when someone have reviewed and not added code to the
>     commit.

Makes sense.

> 2) We should probably rethink the need of Signed-off-by: lines when
>     Gert or I do commits without modifying the patch in any way.  Whom
>     committed the patch is now also easily accessible using
>     the --pretty=3Dfuller argument to git log.

Indeed:

commit 5f5229e41d134b659e502bb2597c711aedaf8096
Author:     Leonardo Basilio <leobasilio@...277...>
AuthorDate: Wed Feb 10 11:19:39 2016 +0100
Commit:     Gert Doering <gert@...1296...>
CommitDate: Wed Feb 10 11:19:39 2016 +0100

     Correctly report TCP connection timeout on windows.

     ---snip---

Let's scrap the Signed-off-by lines except when actual changes have been=20
made.

>     And it should be an explicit note which states that the committer
>     which adds a Signed-off-by: line to an unmodified commit does not
>     mean the same as when a patch contributor does so.  The committer's
>     Signed-off-by: basically means "Yes, this patch has been accepted by
>     N.N" ... That was the intention of this last Signed-off-by: line.

The difference between Acked-by and Reviewed-by seems to be the=20
completeness of the review:

"Acked-by: does not necessarily indicate acknowledgment of the entire=20
patch. For example, if a patch affects multiple subsystems and has an=20
Acked-by: from one subsystem maintainer then this usually indicates=20
acknowledgment of just the part which affects that maintainer=92s code."

"A Reviewed-by tag is a statement of opinion that the patch is an=20
appropriate modification of the kernel without any remaining serious=20
technical issues."

These quotes are from

<https://git.eclipse.org/r/Documentation/user-signedoffby.html>

We've typically been using Acked-by for acknowledging the full patch,=20
where we could have used Reviewed-by. And we've essentially used the=20
committers Signed-off-by in place of Acked-by, if I'm not mistaken.

> If we drop the additional Signed-off-by: line, we are much closer to
> what other projects using Signed-off-by does.

Sounds good to me. They make little sense because of "--pretty=3Dfuller".

> I know I'm the one to blame for all this, as I believe it was my initial
> suggestion.  But that was many years ago; where both the git tool have
> improved vastly and the way git is used are nowadays somewhat more
> unified across projects then what it was around in 2010-ish.  And I
> think we have all learned to use git far better over all these years as
> well.

+1 for following / trying to follow the instructions given here:

<https://git.eclipse.org/r/Documentation/user-signedoffby.html>

The tags (e.g. Signed-off-by) are not being used for analysis purposes,=20
so this change of practice will not break anything.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

