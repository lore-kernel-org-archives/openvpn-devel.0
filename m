Message-ID: <4F4515F1.3030105@...1147...>
Date: Wed, 22 Feb 2012 17:21:05 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
In-Reply-To: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
Subject: Re: [Openvpn-devel] [RFC][windows] gettimeofday()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi Alon,

Alon Bar-Lev wrote:
> Hello all,
>
> There is an abnormality in the openvpn sources I want to resolve.
>
> In windows there is own implementation of gettimeofday().
> In the past there was no gettimeofday(), so we used performance counters,
> then James optimize it to reduce CPU consumption.
>
> Unlike in the past, mingw does provide this function these days.
> The question is if it is good enough.
>
> There is also a note:
> /* on WIN32, gettimeofday is faster than time(NULL) */
>
> I am not sure about any of these, can you please try to run the
> benchmark and report back the results?
> It must be compiled using mingw, either at cygwin or at linux.
>
>   
First:
$ i686-pc-mingw32-gcc -o timebench.exe timebench.c

In a virtual WinXP SP3 env on my 2.50 GHz Intel T9300:

c:\users\janjust>timebench.exe
time(): 18
gettimeofday(): 47
openvpn_gettimeofday(): 16



share and enjoy,

JJK


