Message-Id: <DA715293-35F5-48ED-A5CF-372C8B67393A@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <1272297494.12238.0@...1207...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Tue, 27 Apr 2010 09:19:31 +1000
References: <1272297494.12238.0@...1207...>
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was: Re:
	[Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
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
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net


On 27-Apr-10, at 1:58 AM, Karl O. Pinc wrote:

> On 04/26/2010 10:23:21 AM, David Sommerseth wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 26/04/10 16:47, Karl O. Pinc wrote:
>>> Speaking of the standard release process there is still this
>> thread:
>>>
>>> Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
>> building
>>
>>> 2.1 rc15 on Windows XP
>>>
>>> and its patch for releasing unpackaged MS Windows binaries;
>>> quite similar to what you're proposing for OS/X.
>
>> Thanks for pushing this.  I am honestly not quite sure were we stand
>> with that patch.  And since I understand the Windows building least
>> of
>> all, I've refrained from going into details of this one so far.  It
>> has
>> not been my intention of ignoring this patch.  I'm primarily focusing
>> on
>> the platforms I happen to understand better, and hope others will
>> chime
>> in on the other issues.
>>
>> But as responses are missing, I'll try to find some time in the near
>> future (this week is crazily hectic for me) - to see if I can
>> understand
>> what your patch solves.  That is a little bit unclear to me, as the
>> patch I'm looking at seems to just make a tarball with compiled
>> binaries
>> ... Right now, I do not immediately see what problem that solves.
>> But
>> I'm pretty sure I'm overlooking something!
>>
>> Btw, you mentioned in some of the threads that you would look at some
>> of
>> the docs for this as well.  I remember vaguely something about
>> another
>> set of patches for HTML files - which I can't say I've seen in the
>> source tree.  That would be good to get into the tree together with
>> this
>> patch when I've looked at it a bit better.
>
> It's a packaging policy issue.
>
> The problem addressed is that there only binaries available
> for MS Windows are pre-packaged in an installer executable.
> This means that anyone who wants stock binaries but a
> modified installer has to recompile from source.
>
> There are many reasons why one would want a non-stock
> MS Windows installer -- the foremost being to include
> an OpenVPN configuration file that allows connections
> between pre-designated endpoints.  One might want to
> go so far as to include certificates in the installation
> to secure the communications channel.  ;-)

For the OS X package, I chose to simply make two packages - one the  
generic binaries, and one for whatever configuration and keys are  
needed for a particular deployment. Could you do the same on Windows?

> Creating custom installation executables is
> relatively easy, especially as the OpenVPN code base
> includes a working config file that's used to make
> the installer OpenVPN distributes.  But of course
> OpenVPN binaries are a requirement before packaging
> can be attempted.
>
> Recompiling is both complicated and error prone.  Historically
> there are a number of issues that make compiling difficult.
> I recall problems with mingw versions
> when compiling on MS Windows and some other sort of problems
> when trying to cross compile from Linux.

Just a FYI - the Visual Studio Express toolchain (32+64 bit) works  
well under WINE.

> In any case it's
> clear that compiling will always be relatively complicated
> and time-consuming to setup in comparison with downloading
> binaries.

Correct - while it is a lot easier on OS X (just ./configure; make),  
most users never install the Developer Tools and don't know how to use  
Terminal. So we have similar motivations.

>
> So, there are 2 patches.  The first is to the OpenVPN
> build process.  It produces unpackaged MS Windows binaries
> and (last you wrote) it works.  The second patch is to
> the OpenVPN documentation.  It documents that the
> binaries exist and when you want them.  It does not
> apply because the OpenVPN website has since been
> restructured.   The doc patch needs to be re-worked
> to put the text in the appropriate place.
>
> But this only makes sense if OpenVPN _will_ release
> unpackaged MS Windows binaries.  It makes sense to me;
> the project is already releasing unpackaged Linux
> binaries and it now talking about doing the same
> for OS/X binaries.

I don't think unpackaged OS X binaries are very useful, which is why I  
created the pkg+dmg. I haven't explored whatever GUI & packaging  
enhancements have been done by third parties - overkill for my  
immediate simple deployment needs.

I *do* think that generic OS X binary pkgs are worthwhile including as  
part of the standard downloads.

--Toby

> There's clear utility.  Regardless,
> this is a policy decision.  Getting a resolution on
> packaging policy seems to me to be the first step.
>
> If OpenVPN _won't'_ release unpackaged MS Windows
> binaries I'd like to know why so it would be
> nice if whomever moves this forward, as with
> any other patch, solicits more than a yes/no answer.
>
> Regards,
>
> Karl <kop@...1206...>
> Free Software:  "You don't pay back, you pay forward."
>                 -- Robert A. Heinlein
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


