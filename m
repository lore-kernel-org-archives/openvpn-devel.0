Message-Id: <40C3833F-7CCF-4DC2-8D2E-4F92F92DFC9E@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <4BD57A54.3050608@...1114...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 26 Apr 2010 22:08:35 +1000
References: <6B68DFBC-517B-4031-8E84-A29922AE9C58@...1348...>
	<4BD57A54.3050608@...1114...>
Subject: Re: [Openvpn-devel] [ANN] OS X packages - OpenVPN 2.1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net


On 26-Apr-10, at 9:34 PM, David Sommerseth wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 26/04/10 01:47, Toby Thain wrote:
>> Hi,
>>
>> I have put together a generic packaging script for OS X (pkg/dmg),  
>> and
>> created basic binary Installer packages for PowerPC and Intel. It's
>> meant only for distributing the generic binary distribution,  
>> analogous
>> to any other UNIX binary package. A small addition is a script which
>> installs an OS X launchd service, net.openvpn.
>>
>> The binary package can be combined with a separate per-client key pkg
>> that installs configuration and keys and starts the launchd service
>> (scripts also available for this, in key-package directory).
>>
>> This may help people with simple deployments that include OS X
>> clients. I have not linked to built packages, on the theory that
>> there's little reason you should trust my builds. (If you have the
>> Apple Developer Tools, and archives for openvpn and lzo, then  
>> creating
>> the binary packages and disk image yourself, for whatever  
>> architecture
>> you run, is as simple as 'make dmg'. Package build, install and run
>> have been tested on 32-bit PowerPC and Intel.)
>>
>> cc'd devel list in case there is any interest in adopting the
>> packaging script(s), perhaps as contrib?
>>
>> http://telegraphics.com.au/svn/openvpn-package/trunk/
>
> Even though I don't have a OSX box (nor I do I have any plans  
> acquiring
> any), this looks pretty nice and cool!
>
> Would it be any possibilities that you would be willing to try to  
> twist
> this into the openvpn-testing.git tree?  It would sure fit well into  
> the
> contrib/ collection.
>
> Maybe even do some research if it would be possible, appropriate and
> good to try to make autotools do a lot of this work automatically if
> requested?  I'm not sure if this really is appropriate, but let's
> consider it at least.
>
> Or that when running ./configure on an identified OSX box, that it  
> would
> update the contrib/ Makefile so a user can just go into the contrib/
> directory and run make to get a proper OSX package.

This latter is pretty much what I had in mind, for adapting to  
contrib. I think it will be easier than the autotools route (and my  
time for this is limited - from experience futzing with autotools can  
soak up a *lot* of time...) That said, I'd prefer to do it the *right*  
way, so I won't dismiss that route.

I am a git novice, so I don't think it will be ready for inclusion  
soon, but thankyou for the encouraging feedback, David. When I find  
some time I'll see if I can check out the testing branch and prepare a  
patch.

--Toby

>
> /me is just thinking out aloud :)
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkvVelQACgkQDC186MBRfrpB3gCdEmal8SRyLhf/ZrK5Ub495zC+
> k3oAoK1FcTi43h57qjqLCv5kpvdGVQtF
> =FJ38
> -----END PGP SIGNATURE-----
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


