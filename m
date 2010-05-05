Message-ID: <4BE1294F.4080009@...1114...>
Date: Wed, 05 May 2010 10:16:15 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <B23F897A-5ADC-4A29-A34B-3BB16C18B4F3@...1360...>
	<4BD7DB78.2010704@...1114...>
	<C5DC4FDD-13FA-45AC-9D17-35BE15E03C1D@...1360...>
	<4BDC2F8C.1010206@...1114...>
	<53312779-25C8-4857-9A02-C95004329ABF@...1360...>
In-Reply-To: <53312779-25C8-4857-9A02-C95004329ABF@...1360...>
Subject: Re: [Openvpn-devel] [PATCH] Mac OSX Keychain certificate support
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
To: Brian Raderman <brian@...1360...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/05/10 04:40, Brian Raderman wrote:
> Hi David,
> 
> On May 1, 2010, at 9:41 AM, David Sommerseth wrote:
>> Looking good!  You also have dmsg() I believe for debugging as well.
>> But then I believe the logging will only be enabled if configured with
>> - --enable-debug, iirc.  Anyway, that was just a side note.  If you want
>> it like it is now, we don't need to change anything in this regard.
> 
> We can leave the logging functionality like it is now.  Again, it is not
> actively being used, it's there just in case.   If it ends up being used
> a lot in future debugging efforts, I may change the calls to dmsg().

Sounds sensible!

>> Seems good to me.  Have you tried running a patched OpenVPN through
>> valgrind?  Just to make sure you don't have any memory leaks.  It's
>> important to also check how it reacts when re-negotiating the tunnel
>> encryption (--reneg-* arguments can be tweaked to make this happen more
>> often).  And also if there are any leaks in error situations.
> 
> I hadn't even heard of valgrind until you mentioned it.  I ran the
> certificate code through Mac OSX Instruments to detect memory leaks, but
> that was before I integrated it with OpenVPN and added the gc_arena
> stuff.  I will try running it through Instruments again or valgrind when
> I get a chance.

Very good!  We will try to provide some more documentations on other
testing mechanisms as well on our community pages as well.

[...snip...]
>> When they give a positive response on the compilation and usability,
>> I'll give you a feature branch in openvpn-testing.git.  And when we feel
>> pretty safe that no memory leaks are found, we can look at merging it
>> into the allmerged branch.  Does this sound reasonable to you?
> 
> Sounds perfectly reasonable.  This is the normal process you go through,
> correct?  

To be honest, it's not been any clear processes for this in the past.
But we need to get a better process for this.  And this is a first step
in doing so.

> My only concern is that we will have difficulty finding people
> to test out this functionality on Mac OSX.  I'm working on trying to get
> the word out to possibly interested parties.   Should I have them post
> their results to this list?

I completely understand this issue, and it's one we also hit with the
other distributions and OSes as well - unfortunately.  But it is
important that we know that the code we're modifying are getting tested
by users, to avoid introducing bugs and/or bloating OpenVPN with
features nobody or just a small minority is interested in.

So feedback from users are important!  If they are willing to send their
responses to the mailing lists, that would really be the best!  Or else
we don't know much what's happening and might do decisions in the future
based on wrong impressions.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvhKU8ACgkQDC186MBRfrqplQCggxiOtLtdUjV0p4m0jjZXUJVm
UQoAn0hy703Ya4G0LGK7F4icGSC3bIGa
=7GXZ
-----END PGP SIGNATURE-----

