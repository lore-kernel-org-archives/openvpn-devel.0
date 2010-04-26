Message-ID: <4BD58B6B.7040005@...1114...>
Date: Mon, 26 Apr 2010 14:47:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <6B68DFBC-517B-4031-8E84-A29922AE9C58@...1348...>
	<4BD57A54.3050608@...1114...>
	<40C3833F-7CCF-4DC2-8D2E-4F92F92DFC9E@...1348...>
In-Reply-To: <40C3833F-7CCF-4DC2-8D2E-4F92F92DFC9E@...1348...>
Subject: Re: [Openvpn-devel] [ANN] OS X packages - OpenVPN 2.1.1
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
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 14:08, Toby Thain wrote:
[...snip...]
>>> cc'd devel list in case there is any interest in adopting the
>>> packaging script(s), perhaps as contrib?
>>>
>>> http://telegraphics.com.au/svn/openvpn-package/trunk/
>>
>> Even though I don't have a OSX box (nor I do I have any plans acquiring
>> any), this looks pretty nice and cool!
>>
>> Would it be any possibilities that you would be willing to try to twist
>> this into the openvpn-testing.git tree?  It would sure fit well into the
>> contrib/ collection.
>>
>> Maybe even do some research if it would be possible, appropriate and
>> good to try to make autotools do a lot of this work automatically if
>> requested?  I'm not sure if this really is appropriate, but let's
>> consider it at least.
>>
>> Or that when running ./configure on an identified OSX box, that it would
>> update the contrib/ Makefile so a user can just go into the contrib/
>> directory and run make to get a proper OSX package.
> 
> This latter is pretty much what I had in mind, for adapting to contrib.
> I think it will be easier than the autotools route (and my time for this
> is limited - from experience futzing with autotools can soak up a *lot*
> of time...) That said, I'd prefer to do it the *right* way, so I won't
> dismiss that route.

Sure, no stress!  Take the time you need, and you may start easier and
modify it later on as well!

> I am a git novice, so I don't think it will be ready for inclusion soon,
> but thankyou for the encouraging feedback, David. When I find some time
> I'll see if I can check out the testing branch and prepare a patch.

Fair enough!  I've put together a very quick "git crash course", which
might help you getting acquainted and started with git.

<http://www.secure-computing.net/wiki/index.php/OpenVPN/git_crash_course>

Also see the developers docs for more resources:

<http://www.secure-computing.net/wiki/index.php/OpenVPN/Developer_documentation>

I can especially recommend the ProGit Book (there is a link on the
Developer docs page)  It's a good starting point when you want to learn
and/or understand more about git and its features.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvVi2gACgkQDC186MBRfrrB8gCfayAZB1a2Qx3Qb6EVvLDSWggI
2DMAmwbYjPfYZvM+aVNTOUvW0fbs1HVN
=ZsNw
-----END PGP SIGNATURE-----

