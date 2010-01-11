MIME-Version: 1.0
In-Reply-To: <06FB28F4D07247528CEF41CA4B665DE5@...1292...>
References: <mailman.291693.1263182482.5856.openvpn-devel@lists.sourceforge.net>
	<06FB28F4D07247528CEF41CA4B665DE5@...1292...>
Date: Mon, 11 Jan 2010 20:05:34 +0200
Message-ID: <9e0cf0bf1001111005l602999d2n929d632d70ea12ac@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Help: build openvpn from source on windows
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
To: Juping Jin <juping.jin@...277...>
Cc: openvpn-devel@lists.sourceforge.net

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
> 2. I could not find tapinstall source code in the source achieve. Where can
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
> all source code under DDK/src folder, not the tap driver. Manually build the
> driver works (ie. Run setenv and then do build -cef).
>
> Thanks for your help!
>
> Juping
>
>
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

