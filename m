From: "Juping Jin" <juping.jin@...277...>
References: <mailman.291693.1263182482.5856.openvpn-devel@lists.sourceforge.net>
Date: Mon, 11 Jan 2010 11:17:53 -0500
Message-ID: <06FB28F4D07247528CEF41CA4B665DE5@...1292...>
MIME-Version: 1.0
In-Reply-To: 
Subject: [Openvpn-devel] Help: build openvpn from source on windows
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
To: openvpn-devel@lists.sourceforge.net


I tried to build openvpn on Windows from its source code and encountered a
few problems:

1. Incorrect defines at autodefs/defs.h, line 51-52: 
#define PRODUCT_TAP_DEVICE_DESCRIPTION TAP-Win32 Adapter V9
#define PRODUCT_TAP_PROVIDER TAP-Win32 Provider V9

They are supposed to be:

#define PRODUCT_TAP_DEVICE_DESCRIPTION "TAP-Win32 Adapter V9"
#define PRODUCT_TAP_PROVIDER "TAP-Win32 Provider V9"

How is defs.h created at the first place?

2. I could not find tapinstall source code in the source achieve. Where can
I download it? 

3. install-win32/maketap: line 42 doesn't work. The line is: 

cmd //c "C:\\WINDDK\\$DDKVER\\bin\\setenv.bat C:\\WINDDK\\$DDKVER $mode &&
cd `perl install-win32/dosname.pl $t` && build -cef"

it's supposed to issue "build -cef" command in tap-win32 folder after
setting environment. However, the cd command doesn't work (I could not get
it work even with hard-coded value). As a result, build -cef will compile
all source code under DDK/src folder, not the tap driver. Manually build the
driver works (ie. Run setenv and then do build -cef).

Thanks for your help!

Juping


