MIME-Version: 1.0
Date: Thu, 29 Mar 2012 19:26:58 +0200
From: michael-dev <michael-dev@...1528...>
In-Reply-To: <CAOazyz1ygPjKiwp=xpOFHbiquD-=L4sLmdE_OoPBrYYpKSQX1w@...278...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<4F743D70.1090704@...1114...>
	<CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
	<4F745CE6.5070608@...1114...>
	<CAOazyz01p7zCGvxxh0Un1c63mdF+zcgZSD24Lp8kF=NdpPmfSg@...278...>
	<4F746C32.2070106@...1114...>
	<CAOazyz1ygPjKiwp=xpOFHbiquD-=L4sLmdE_OoPBrYYpKSQX1w@...278...>
Message-ID: <1d265066de7b45fc4de8906d65b2e6d2@...1528...>
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
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, 29 Mar 2012 18:10:24 +0200, Alon Bar-Lev wrote:
> For example...
>
> at your end:
> ---
> ./configure
> make
> make dist
> ---
>
> at other people end:
> ---
> tar -xf <tarball>
> cp -a openvpn* openvpn*.org
> cd openvpn*
> msvc-dev
> <add a file to project>
> <save all>
> <quit>
> cd ..
> diff -urNp openvp* openvpn*.org
> ---
>
> will result in a complete change of all microsoft specific files
> because of the new line issue.
> is this enough problem?

so why don't use --strip-trailing-cr (diffutils) or something similar 
to avoid this?

So as long as msvc-dev does accept eol=lf input files, storing them as 
eol=lf files is without issue?

Regards,
  M. Braun
--
[1] http://stackoverflow.com/questions/1889559/git-diff-to-ignore-m


