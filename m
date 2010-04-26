Message-Id: <5A2CC3A7-DA09-4548-8534-AA4967413DA8@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <1272309086.19417.1@...1207...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Tue, 27 Apr 2010 09:31:43 +1000
References: <1272309086.19417.1@...1207...>
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
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>


On 27-Apr-10, at 5:11 AM, Karl O. Pinc wrote:

> On 04/26/2010 11:53:19 AM, Peter Stuge wrote:
>> Karl O. Pinc wrote:
>>> the project is already releasing unpackaged Linux
>>> binaries
>>
>> Really?
>
> They seem to have stopped sometime after July 30 2008.
>
> http://web.archive.org/web/20080730205524/openvpn.net/index.php/
> downloads.html
>
> It's hard to tell when because archive.org does not appear
> to be allowed to archive the site any longer.  Or at least
> there's nothing more recent.  (This seems silly.  I wonder why.)
>
> (I clearly haven't been downloading binaries in a while.
> Probably because I rely on my distro for binaries so
> they can do the systems integration and security patches,
> or I am getting development from CVS/git.
>
> IMO people who don't rely on their distro for systems integration
> and security patches are asking for trouble.  There are of course
> always reasons to make specific exceptions, RH comes to mind. :)
>
> Is OpenVPN in RHEL6?)
>
>>
>>> and it now talking about doing the same for OS/X binaries.
>>
>> Recently discussed work for contrib/ produces a .dmg, very much a
>> package in my view.
>
> Ok.  I don't know much about .dmg.  I thought they were basically
> tarballs by another name in that they just stick stuff somewhere.
> My Mac usage is sporadic, sorry.


The Makefile produces both 'pkg' and 'dmg'. Dmg is just an OS X  
standard self-mounting single file archive which is a way of  
distributing the pkg. Generating a dmg is useful because the pkg is  
actually a file tree, not a single file, so inappropriate for  
downloading, attaching, etc.

Pkg is the package itself, which like any binary UNIX package is  
indeed a tarball by another name plus some metadata and scripts - but  
of course infinitely easier for non-technical end users (let alone  
compared to a source build).

--Toby


>
>>
>>
>>> There's clear utility.
>>
>> I guess it depends. I'm not sure that I agree that compilation is a
>> much bigger bother than (cross-)compiling the NSIS installer..
>
> On Debian all I had to do was "aptitude install nsis" and then
> run it to make MS Windows installers.  Plug and play, no
> compiling necessary.
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


