Message-ID: <50F95EC1.7080305@...1800...>
Date: Fri, 18 Jan 2013 09:40:01 -0500
From: Mike Tancsa <mike@...1800...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
	<50F7257C.9010404@...1800...>
	<20130117213431.GN22465@...1296...>
In-Reply-To: <20130117213431.GN22465@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 1/17/2013 4:34 PM, Gert Doering wrote:
> 
>> I was following the directions at 
>> https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem#Checkingoutopenvpn-buildrepository
>
>> 
> On what platform did you build, and for which target?  Which git
> repository was checked out, and which branch?

I think the issue is that the source codes that is downloaded in the
above URL through the git clone, does not grab 2.3, but a snapshot
from 6 months ago.  I am cross building on Fedora, AMD64.

%git clone https://github.com/OpenVPN/openvpn-build.git
% cd openvpn-build/generic
% IMAGEROOT=`pwd`/image-win32 CHOST=i686-w64-mingw32 \
    CBUILD=x86_64-pc-linux-gnu ./build

Will build just fine, but the older version.

There also needs some manual fetching of files as URLs are out of date
for pkcs
FATAL: Cannot download
https://github.com/downloads/alonbl/pkcs11-helper/pkcs11-helper-1.10.tar.bz2
FATAL: Cannot download
https://github.com/downloads/OpenVPN/tap-windows/tap-windows-9.9.0_master.zip


If I make the following changes, I get the newer version built.
manually fetch
http://swupdate.openvpn.org/community/releases/openvpn-2.3.0.tar.gz
into the openvpn-build/generic/sources
Get rid of the 2.3_master.tar.gz file
change the build.vars
--- build.vars.prev     2013-01-17 16:56:06.356577031 -0500
+++ build.vars  2013-01-17 16:56:21.970578237 -0500
@@ -5,7 +5,7 @@
 PKCS11_HELPER_VERSION="${PKCS11_HELPER_VERSION:-1.10}"
 LZO_VERSION="${LZO_VERSION:-2.05}"
 TAP_WINDOWS_VERSION="${TAP_WINDOWS_VERSION:-9.9.0_master}"
-OPENVPN_VERSION="${OPENVPN_VERSION:-2.3_master}"
+OPENVPN_VERSION="${OPENVPN_VERSION:-2.3.0}"
 OPENVPN_GUI_VERSION="${OPENVPN_GUI_VERSION:-1.0.3}"

 OPENSSL_URL="${OPENSSL_URL:-http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz}"

and that builds the latest release.

	---Mike




-- 
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada   http://www.tancsa.com/

