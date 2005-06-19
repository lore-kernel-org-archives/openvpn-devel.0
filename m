From: Simon Perreault <nomis80@...422...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506150712.01979.nomis80@...401...> <Pine.LNX.4.58.0506161121140.907@...41...>
In-Reply-To: <Pine.LNX.4.58.0506161121140.907@...41...>
MIME-Version: 1.0
Message-Id: <200506191243.23137.nomis80@...422...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Jun 19 09:44:36 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On June 16, 2005 13:33, James Yonan wrote:
> Despite what the dlopen man page says, I had problems with shared library
> linkage from libpam.so --(dlopen)--> pam_unix.so when ?=dlopen (the pam
> lib couldn't find the plugin).  It only seemed to work if I built OpenVPN
> itself with -lpam.  I didn't figure out what what causing the problem, so
> it's possible that I wasn't doing something right.  I didn't want OpenVPN
> itself to have the pam dependency, only the auth-pam plugin.

I think I know what the problem was. dlopen() wasn't finding libpam.so (ie. 
pam-devel wasn't installed, more about this later). But because you were 
linking openvpn with libpam.so.0.77, which contains the symbols libpam.so 
contains, it wasn't failing. Linking openvpn with libpam.so.0.77 was a 
(wrong) solution to dlopen not finding libpam.so.

I now firmly believe there is no technical reason to dlopen libpam.so from the 
auth-pam plugin. Please consider applying the patch I previously sent. Try to 
reproduce any problem you had. I have tried to but couldn't find any flaw.

> Why is this?  We already have an RPM spec file for OpenVPN and it builds
> binary RPMs which include the auth-pam plugin and doesn't have a pam-devel
> dependency.  (There's a pam-devel dependency only for building the binary
> RPM itself)

...which is wrong. If you try to use the auth-pam plugin when pam-devel isn't 
installed, it will not find libpam.so.

.so's are only included in -devel packages because their only use is when 
linking. Because linking is intended to be done at compile time (not 
dynamically as when using dlopen()), .so's make sense only in the context of 
a -devel package. The only .so's you will find not in -devel packages are 
plugins. For example, you will find .so's of PAM plugins in the pam package 
for this reason.

dlopen() should only be used on libraries *expecting* to be dlopened.

> If you can figure out how to do it without dlopen, feel free to submit a
> patch.

Please take a look at the patch I sent previously, you seem to have overlooked 
it. It contains all the necessary changes.

-- 
Simon Perreault <nomis80@...422...> -- http://nomis80.org

