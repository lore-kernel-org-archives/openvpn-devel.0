Message-Id: <6A820940-C401-44FE-AE34-82F710563254@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <1272340482.17652.2@...1207...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Tue, 27 Apr 2010 14:39:28 +1000
References: <1272340482.17652.2@...1207...>
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


On 27-Apr-10, at 1:54 PM, Karl O. Pinc wrote:

> On 04/26/2010 09:46:06 PM, Toby Thain wrote:
>>
>> On 27-Apr-10, at 12:19 PM, Karl O. Pinc wrote:
>>
>>> On 04/26/2010 06:19:31 PM, Toby Thain wrote:
>>>>>
>>>>>
>>>>
>>>> I don't think unpackaged OS X binaries are very useful, which is
>> why
>>>> I
>>>>
>>>> created the pkg+dmg.
>>>
>>> I agree, because the Apple development kit is shipped,
>>> if not installed, on every Mac.
>>
>> It ships on the DVD but most people never install it, of course.
>>
>>> (Last I looked.)  And
>>> because ./configure ; make is painless.
>>
>> To use your argument from above -- imho much too complex for most end
>>
>> users. As well as requiring Apple Developer Tools (they have to go
>> find the original DVD, which may or may not even be possible), this
>> involves locating and downloading two source archives from two
>> different sites, and configuring and building them both; beyond the
>> pale for non-technical users, even though it's trivial for "us".
>
> I'm not following you here.  I thought we were talking about whether
> unpackaged OS/X binaries were useful to anybody.  The answer being
> no because developers and packagers are the only people who need
> them and developers and packagers can easily create OS/X binaries.

Ah, okay, then we are in agreement.

>
>> ...
>
>> It seems logical to me that an OS X binary dmg could be on the
>> OpenVPN
>>
>> downloads page, giving a similar level of convenience to "yum install
>>
>> openvpn" or "apt-get install openvpn" or "emerge openvpn".
>
> Sure.  Packages can be useful to end-users.

Right - or those organising deployments to them.

>
>>
>> One thing that should *not*, in my opinion, be encouraged at all by
>> OpenVPN, are third party package managers (MacPorts, Fink, Homebrew
>> etc) as the binary route on OS X. That seems to do more harm than
>> good.
>
> I have no opinion.  I suppose it depends on the degree of systems
> integration provided by the 3rd party.  I assume this is usually
> none, in which case there's no point and the end-user may as well
> get their packages straight from the source.
>
>>
>>
>> If I were deploying it, rather than hacking on it, I would expect a
>> binary installer to be available for my platform, at
>> http://openvpn.net
>
> I'd expect my distro provider to supply it, be sure it integrates
> with everything else, and support security fixes. ... The typical  
> user is more likely to have
> a bad OpenVPN experience, over time, when using packages
> obtained directly from OpenVPN than when using packages
> created by their distro, for the reasons outlined above
> and earlier in this thread. ...
>
> The situation is different for MS Windows and OS/X.
> Packages are needed for those platforms and whatever
> other commercial OSs the project wants to support.

+1
Solaris 10 is another possibility. I have experience with this package  
flavour and could easily do the same job as I did for OS X, for  
contrib, at least, if not binary pkg.


>
> There.  Now I've wandered far from the original
> topic and likely offended someone too.

Certainly not me.

--Toby

> Mission accomplished.  :-P
>
> Regards,
>
>
> Karl <kop@...1206...>
> Free Software:  "You don't pay back, you pay forward."
>                 -- Robert A. Heinlein
>


