Message-Id: <4818AFFA-B84A-4DCE-8F6B-9CA42E63AF48@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <AANLkTi=a1GqkMfo2d17XP_JVcD5kOoGBAA=th3WA+rNz@...278...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 13 Sep 2010 15:29:37 -0400
References: <AANLkTin2N8TOJ9H+kDFVojiTaaG+AxM+dNc9xFM9XpuF@...278...>
	<20100913182543.12172.qmail@...1287...>
	<D361C0BE-FCDA-4DA0-BA44-E344D33242B0@...1348...>
	<AANLkTi=a1GqkMfo2d17XP_JVcD5kOoGBAA=th3WA+rNz@...278...>
Subject: Re: [Openvpn-devel] Windows build was messed up!
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>


On 13-Sep-10, at 3:10 PM, Alon Bar-Lev wrote:

> On Mon, Sep 13, 2010 at 8:59 PM, Toby Thain  
> <toby@...1348...> wrote:
>> NMAKE is convenient for Windows builds as it will also happily run
>> under Linux/WINE, targeting both 32 and 64 bit Windows runtimes with
>> the 'freely downloadable' Express toolchain. It may even be possible
>> to combine autotools with the Microsoft compiler, though I haven't
>> tried it (CC="wine cl", etc).
>
> Won't work ever!

Are you certain?

Certainly this works:
	$ wine nmake /f foo.mak

I have dozens of projects which cross-build this way for 32 and 64 bit  
Windows.

--Toby

> Forget about wine and Microsoft compilers.
> mingw provides a decent environment, fully integrated to autotools and
> cross environments.
>
> Alon.


