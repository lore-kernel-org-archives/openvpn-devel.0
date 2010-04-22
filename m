Message-ID: <4BD011F3.7030605@...1114...>
Date: Thu, 22 Apr 2010 11:08:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
	<201004192237.51287.dave_br@...1278...>
	<4BD0028F.9040307@...1114...>
	<201004220915.27710.dave_br@...1278...>
In-Reply-To: <201004220915.27710.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/04/10 10:15, Davide Brini wrote:
> On Thursday 22 Apr 2010 09:02:23 David Sommerseth wrote:
> 
>> For future patches, would you mind adding a little bit more descriptive
>> text which can be used as commit log messages.  I do write those commit
>> logs when I find it is needed, but adding a little bit more descriptions
>> of what the patch does is a nice and good habit - no matter how easy the
>> patch looks like ... and it makes my maintenance job a lot easier and
>> quicker.
> 
> Sure, no problem. But just to make it clear (please forgive my ignorance), my 
> original message for the patch contained quite a detailed explanation of what 
> it does. 

Sorry, I was a bit unclear ... the initial patch had good info!  And as
you can see in the commit log, I've used a lot of that text.

> I assume that was too long, and you need a 1-2 lines summary to use 
> for the commit? 

It doesn't need to be a novel, but I do prefer longer ones and not just
1-2 lines.  So not too short, please :)

> Of course this is not to say that the detailed explanation 
> should be missing, only that you need the brief summary as well. Is my 
> understanding correct?

Ideally a commit log should state the problem the patch should fix and
give the basic ideas of how you solved it - without being too technical,
as the patch will describe the technical details.  But things which
might be difficult to understand in the code, should be explained in
"plain English" in the commit log.

If applicable, also add references to mail discussions, chat logs, etc,
if that is relevant and can give more background information.  This is
important when someone wants to investigate the patches later on, maybe
even someone who is fresh to the OpenVPN code.

And if your text can be used as a "copy-paste" into the git commit,
that's what I'd prefer :)

Another thing I've began to add to commit logs are those
"Signed-off-by:" lines for those submitting the patches.  So, please add
"Signed-off-by:" lines as well.


<description_of_signed_off_process>

To explain the Signed-off-by and Acked-by process a bit further.  I do
now separate commit Author and sender.  The difference is that the
author field should be a reference to the one who *wrote* the patch.
This person sends it to someone, and would add the first "Signed-off-by"
message as a "signature" of the patch.  This indicates that the author
finds the patch ready to be sent further.

Then the one who receives the patch and finds it good to go further,
will add his/hers "Signed-off-by" reference.  That way we can track who
have been looking at the patch.  Before it goes into the tree, a final
"Acked-by:" note is added, indicating who accepted it for inclusion into
the tree.

So, if John Doe writes a patch, sends it to Jane Doe and she sends it
Bob Boss for inclusion the process would be:

John Doe:
	Author: John Doe <john.doe@...1113...>
	Patch fixing x.y.z

	explaining the patch

	Signed-off-by: John Doe <john.doe@...1113...>
	
	<the patch itself>

Jane Doe will send it further as:
	Author: John Doe <john.doe@...1113...>
	Patch fixing x.y.z

	explaining the patch

	Signed-off-by: John Doe <john.doe@...1113...>
	Signed-off-by: Jane Doe <jane@...1349...>	

	<the patch itself>

And when Bob Boss ACK's the patch, the final commit to be found in the
tree will be:
	Author: John Doe <john.doe@...1113...>
	Patch fixing x.y.z

	explaining the patch

	Signed-off-by: John Doe <john.doe@...1113...>
	Signed-off-by: Jane Doe <jane@...1349...>	
	Signed-off-by: David Sommerseth <dazo@...384...>
	Acked-by: Bob Boss <bob@...1350...>

	<the patch itself>

The Acked-by: can also be someone who don't do the final commit[1].  Or
it can be my patches which I've sent for review before including
them[2].  And it can of course be ACKed by the same person who do the
final commit.  The last Signed-off-by should normally be the person the
one who does the final commit.  This is the person  who "touched" the
patch by adding the Acked-by line(s).

However, you should not see any commits which is written by (author) and
Acked-by by the same person.  Then the process have failed to give a
qualified review.

You may ask why we have this "bureaucracy" (which is a fair question!)
It is simply to keep all who send in patches, those who reviews them and
finally accepts them into the source tree more accountable for their
work.  And to document that each accepted patch has been through a
certain set of reviews.

As these patches will go back into SVN, it's not possible to, AFAIK, to
track authors and committers explicitly - so we track it in the commit
log as well.  Just to keep this project as transparent as possible.

For now, the only patches which which "breaks" this in the git tree are
the patches coming in from James' SVN BETA21 branch.  But I trust that
James tracks the patches he pulls in according to the standards he
needs.  After all, we just prepare the "next version" tree for James -
thus we're having stricter tracking, to make it more comfortable for
James to accept our patches.

</description_of_signed_off_process>



kind regards,

David Sommerseth


[1] Example: See commit d81eb4cf0ec387
[2] Example: See commit 5acb71a0aab49e
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvQEfEACgkQDC186MBRfrrzzgCfT0bXn/84XqKF2fzDByGzYPXn
j9oAnR+FPGiOixL22YTNCI3cwjKJmXOs
=HMaq
-----END PGP SIGNATURE-----

