Message-Id: <4E8CFE17-2394-4FAD-A1A5-AF193D97E7A3@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <1272334773.8910.2@...1207...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Tue, 27 Apr 2010 12:46:06 +1000
References: <1272334773.8910.2@...1207...>
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


On 27-Apr-10, at 12:19 PM, Karl O. Pinc wrote:

> On 04/26/2010 06:19:31 PM, Toby Thain wrote:
>>>
>>>
>>
>> I don't think unpackaged OS X binaries are very useful, which is why
>> I
>>
>> created the pkg+dmg.
>
> I agree, because the Apple development kit is shipped,
> if not installed, on every Mac.

It ships on the DVD but most people never install it, of course.

>  (Last I looked.)  And
> because ./configure ; make is painless.

To use your argument from above -- imho much too complex for most end  
users. As well as requiring Apple Developer Tools (they have to go  
find the original DVD, which may or may not even be possible), this  
involves locating and downloading two source archives from two  
different sites, and configuring and building them both; beyond the  
pale for non-technical users, even though it's trivial for "us".

The pkg/dmg is, on the other hand, a genuine one click install. (Even  
if you have to do a 2nd key install, which pkg has to be built  
individually and distributed securely anyway.)
It seems logical to me that an OS X binary dmg could be on the OpenVPN  
downloads page, giving a similar level of convenience to "yum install  
openvpn" or "apt-get install openvpn" or "emerge openvpn".

One thing that should *not*, in my opinion, be encouraged at all by  
OpenVPN, are third party package managers (MacPorts, Fink, Homebrew  
etc) as the binary route on OS X. That seems to do more harm than good.


> MS Windows on
> the other hand requires additional software
> to compile anything.  And the FOSS choices, which
> are the the ones most universally available, are non-trivial
> to install and use.
>
> I'd bet cross compiling  Un*x-to-Mac is easier too, but
> I have no experience to back that up.

Generally very simple, fwiw. It probably helps that OS X toolchain is  
gcc-based and many GNU utilities are standard.


> Now that OpenVPN is accepting more patches cross compiling
> Un*x-to-MSWindows will probably get easier but it will
> never be easy.

If I were deploying it, rather than hacking on it, I would expect a  
binary installer to be available for my platform, at http://openvpn.net

--Toby

>
> Karl <kop@...1206...>
> Free Software:  "You don't pay back, you pay forward."
>                 -- Robert A. Heinlein
>


