From: "Juping Jin" <juping.jin@...277...>
References: <mailman.291693.1263182482.5856.openvpn-devel@lists.sourceforge.net>
	<06FB28F4D07247528CEF41CA4B665DE5@...1292...>
	<9e0cf0bf1001111005l602999d2n929d632d70ea12ac@...278...>
Date: Mon, 11 Jan 2010 21:55:04 -0500
Message-ID: <783B83D7F51B4A99AF36C4EBE8D8E754@...1292...>
MIME-Version: 1.0
In-Reply-To: <9e0cf0bf1001111005l602999d2n929d632d70ea12ac@...278...>
Subject: Re: [Openvpn-devel] Help: build openvpn from source on windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Alon Bar-Lev' <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I just realized where the problem is for issue #3 in my original email:

The following command has no effect if openvpn source code is not on the
same drive as where WDK is installed (which is my case):

cd `perl install-win32/dosname.pl $t`

On window's world, it needs to switch to particular drive first (E: in my
case), and then change to the specified folder.

One possible solution is to have another perl script to return drive letter
(say, dosdrive.pl):

`perl install-win32/dosdrive.pl $t` && cd `perl install-win32/dosname.pl $t`

The rest of the command line will be the same.

I will have not found tapinstall source code. Could someone point me to
right place?
Thanks.

Juping

-----Original Message-----
From: Alon Bar-Lev [mailto:alon.barlev@...277...] 
Sent: Monday, January 11, 2010 1:06 PM
To: Juping Jin
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Help: build openvpn from source on windows

I use my own build to build this [1].

The OpenVPN project should have long ago separate between a some
components for ease of use:

1. OpenVPN
2. OpenVPN Windows Service Wrapper
3. OpenVPN TAP driver
4. OpenVPN Windows Installer
5. Easy-RSA

This would have enable users to build specific component without the
other, or changing the installer without releasing a new version of
core product.

[1] http://www.opensc-project.org/build

On Mon, Jan 11, 2010 at 6:17 PM, Juping Jin <juping.jin@...277...> wrote:
>
> I tried to build openvpn on Windows from its source code and encountered a
> few problems:
>
> 1. Incorrect defines at autodefs/defs.h, line 51-52:
> #define PRODUCT_TAP_DEVICE_DESCRIPTION TAP-Win32 Adapter V9
> #define PRODUCT_TAP_PROVIDER TAP-Win32 Provider V9
>
> They are supposed to be:
>
> #define PRODUCT_TAP_DEVICE_DESCRIPTION "TAP-Win32 Adapter V9"
> #define PRODUCT_TAP_PROVIDER "TAP-Win32 Provider V9"
>
> How is defs.h created at the first place?
>
> 2. I could not find tapinstall source code in the source achieve. Where
can
> I download it?
>
> 3. install-win32/maketap: line 42 doesn't work. The line is:
>
> cmd //c "C:\\WINDDK\\$DDKVER\\bin\\setenv.bat C:\\WINDDK\\$DDKVER $mode &&
> cd `perl install-win32/dosname.pl $t` && build -cef"
>
> it's supposed to issue "build -cef" command in tap-win32 folder after
> setting environment. However, the cd command doesn't work (I could not get
> it work even with hard-coded value). As a result, build -cef will compile
> all source code under DDK/src folder, not the tap driver. Manually build
the
> driver works (ie. Run setenv and then do build -cef).
>
> Thanks for your help!
>
> Juping
>
>
>
----------------------------------------------------------------------------
--
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and
easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


