MIME-Version: 1.0
In-Reply-To: <4F44B38B.7010201@...515...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<4F44A1A3.8050007@...515...> <4F44B38B.7010201@...515...>
Date: Wed, 22 Feb 2012 11:26:08 +0200
Message-ID: <CAOazyz3HZu1btWKKqq9xKX53teZiw9bU+ZdB0hnbwKBXr14OLw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [build] Windows build test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/2/22 Samuli Sepp=C3=A4nen <samuli@...515...>:
> I used this method to cross-compile for Windows (32-bit and 64-bit) on
> Ubuntu 11.10 amd64. I replaced the "bin" directory of an existing
> openvpn-2.3-alpha1 installation with the results on a 32-bit WinXP box
> and it seemed work ok.

Thank you for testing!

>
> Anyways, there was a problem with permissions during build:
>
> --- snip ---
> Fixup libtool files
> Restore libtool files
> Copying documents
> Copying sources
> Cleaning empty directories
> x86_64-w64-mingw32-strip: unable to copy file
> '/home/samuli/opt/openvpn/generic/image
> -win64/openvpn/lib/engines/gmpeay32.dll'; reason: Permission denied
> x86_64-w64-mingw32-strip: unable to copy file
> '/home/samuli/opt/openvpn/generic/image-win64/openvpn/lib/engines/atallae=
ay32.dll';
> reason: Permission denied
> --- snip ---
>
> The offending files had 555 permissions. Changing them manually to 755
> and restarting the build from correct phase allowed the build to complete.

Oh... these warnings can be safely ignored.

Alon.

