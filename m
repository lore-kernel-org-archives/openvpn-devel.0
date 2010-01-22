Message-ID: <4B598828.2080409@...1294...>
Date: Fri, 22 Jan 2010 12:12:40 +0100
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
References: <4B56CBFD.7080900@...1294...>	
	<9e0cf0bf1001200528r2978e159j787aaf1e128b1330@...278...>	
	<9e0cf0bf1001200529p3014d857hca6585c939d7a322@...278...>	
	<4B58122C.3020202@...1294...>
	<9e0cf0bf1001210400x6fc976b8le3c2b7a162c0a742@...278...>
In-Reply-To: <9e0cf0bf1001210400x6fc976b8le3c2b7a162c0a742@...278...>
Subject: Re: [Openvpn-devel] Crosscompile OpenVPN 2.1.1
Reply-To: e.lohmann@...1294...
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net



Hi Alon,

thanks, this is the only working way for me.
I am compiling with i586-mingw32msvc, where do i get the i686
crosscompiler for Debian or Ubuntu? My gentoo box is ~3 years old, I
better don't touch it. :)

If I want to set some different options to the buildprocess, do I edit
the ./build script or is there another smart way?

Thanks, Eike


Alon Bar-Lev schrieb:
> You should run the build script it will build all including openvpn.
> You can adjust it later to build whatever you need.
>
> On Thu, Jan 21, 2010 at 10:37 AM, Eike Lohmann <e.lohmann@...1294...> wrote:
>   
>> Hi, what should I try there the openvpn binary or the libs?
>> I am not familiar with openbc.
>>
>> Regards, Eike
>>
>>
>>
>>
>> Alon Bar-Lev schrieb:
>>     
>>> Ops...
>>> http://opensc-project.org/build
>>>
>>> On 1/20/10, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>>
>>>       
>>>> Take my build from http://opensc-project.com/build
>>>>
>>>> On 1/20/10, Eike Lohmann <e.lohmann@...1294...> wrote:
>>>>
>>>>         
>>>>> Hello,
>>>>>
>>>>> I am searching for the best way to compile OpenVPN 2.1.1 for Windows, I
>>>>> have tried it on Windows with mingw+msys and on cygwin with the native
>>>>> win32 option. Right now I am on Linux using the mingw crosscompiler and
>>>>> could compile lzo2-03, openssl-0.9.8l, pkcs11-helper-1.07.
>>>>>
>>>>> When I try to configure openvpn-2.1.1(./configure
>>>>> --host=i586-mingw32msvc
>>>>> --with-lzo-headers=../lzo-2.03/usr/local/include/lzo
>>>>> --with-lzo-lib=../lzo-2.03/usr/local/lib) it stops everytime at:
>>>>>
>>>>> configure: checking for LZO Library and Header files...
>>>>> checking lzo/lzo1x.h usability... no
>>>>> checking lzo/lzo1x.h presence... no
>>>>> checking for lzo/lzo1x.h... no
>>>>> checking lzo1x.h usability... yes
>>>>> checking lzo1x.h presence... yes
>>>>> checking for lzo1x.h... yes
>>>>> checking for lzo1x_1_15_compress in -llzo... no
>>>>> configure: error: LZO headers were found but LZO library was not found
>>>>>
>>>>> lza installdir:
>>>>> openvpn-2.1.1$ ls -la ../lzo-2.03/usr/local/lib
>>>>> insgesamt 820
>>>>> drwxr-xr-x 2  4096 2010-01-19 16:55 .
>>>>> drwxr-xr-x 4  4096 2010-01-19 16:29 ..
>>>>> -rw-r--r-- 1 826766 2010-01-19 16:55 liblzo2.a
>>>>> -rwxr-xr-x 1 740 2010-01-19 16:55 liblzo2.la
>>>>>
>>>>> What exactly is missing and how to build it?
>>>>>
>>>>> Thanks and best Regards
>>>>>
>>>>> Eike
>>>>>
>>>>> ------------------------------------------------------------------------------
>>>>> Throughout its 18-year history, RSA Conference consistently attracts the
>>>>> world's best and brightest in the field, creating opportunities for
>>>>> Conference
>>>>> attendees to learn about information security's most important issues
>>>>> through
>>>>> interactions with peers, luminaries and emerging and established
>>>>> companies.
>>>>> http://p.sf.net/sfu/rsaconf-dev2dev
>>>>> _______________________________________________
>>>>> Openvpn-devel mailing list
>>>>> Openvpn-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>>
>>>>>
>>>>>           

