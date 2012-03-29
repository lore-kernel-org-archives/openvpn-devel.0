MIME-Version: 1.0
In-Reply-To: <1d265066de7b45fc4de8906d65b2e6d2@...1528...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<4F743D70.1090704@...1114...>
	<CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
	<4F745CE6.5070608@...1114...>
	<CAOazyz01p7zCGvxxh0Un1c63mdF+zcgZSD24Lp8kF=NdpPmfSg@...278...>
	<4F746C32.2070106@...1114...>
	<CAOazyz1ygPjKiwp=xpOFHbiquD-=L4sLmdE_OoPBrYYpKSQX1w@...278...>
	<1d265066de7b45fc4de8906d65b2e6d2@...1528...>
Date: Thu, 29 Mar 2012 19:37:33 +0200
Message-ID: <CAOazyz0qpBm0s7HW8igXwMgRywGPbkcknDvHFQBxsrEUQbc=5Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] build: msvc: upgrade to Visual
 Studio 2010 + fixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: michael-dev <michael-dev@...1528...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Mar 29, 2012 at 7:26 PM, michael-dev <michael-dev@...1528...> wrote:
> Hi,
>
> On Thu, 29 Mar 2012 18:10:24 +0200, Alon Bar-Lev wrote:
>> For example...
>>
>> at your end:
>> ---
>> ./configure
>> make
>> make dist
>> ---
>>
>> at other people end:
>> ---
>> tar -xf <tarball>
>> cp -a openvpn* openvpn*.org
>> cd openvpn*
>> msvc-dev
>> <add a file to project>
>> <save all>
>> <quit>
>> cd ..
>> diff -urNp openvp* openvpn*.org
>> ---
>>
>> will result in a complete change of all microsoft specific files
>> because of the new line issue.
>> is this enough problem?
>
> so why don't use --strip-trailing-cr (diffutils) or something similar
> to avoid this?
>
> So as long as msvc-dev does accept eol=lf input files, storing them as
> eol=lf files is without issue?

Hi,

Because I believe that file format should be as-is and these diff/git
magic should be done only when forced, when invalid action was taken.

Of course all had been better if Microsoft supported keeping the line
format, but this is not the case.

I want to see a "make dist" containing file format as it should be,
and Microsoft solution and project files should be CRLFed.

I truly don't understand... there is a simple solution of git to
explicit set eol style on specific files, why not use it?

And... also avoid using global setting of git, which is invalid anyway
as we maintain several projects which should be independent.

Alon.

