From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
In-Reply-To: <200506150712.01979.nomis80@...401...>
Message-ID: <Pine.LNX.4.58.0506161121140.907@...41...>
References: <200506141234.50171.nomis80@...401...> <200506141314.54183.nomis80@...401...>
 <Pine.LNX.4.58.0506142114190.4004@...41...> <200506150712.01979.nomis80@...401...>
MIME-Version: 1.0
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
Date: Thu Jun 16 10:34:54 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Simon Perreault <nomis80@...401...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 15 Jun 2005, Simon Perreault wrote:

> On Tuesday 14 June 2005 23:24, James Yonan wrote:
> > When I was writing the auth-pam plugin, I had problems dynamically linking
> > the plugin to PAM unless OpenVPN itself was also dynamically linked to PAM
> > (which I didn't want to do).
> 
> What kind of problem did you encounter? It seems to work perfectly for me.

> > Remember that PAM itself is going to dlopen, 
> > in turn, the actual PAM module.  Combining dlopen with dynamic linking has
> > got to be problematic when you are dealing with crosslinked dependencies.
> 
> I'm not sure what you mean by "crosslinked dependencies". The way I see it is:
> 
> openvpn --(dlopen)--> auth-pam --(?)--> libpam.so --(dlopen)--> pam_unix.so
> 
> I don't see why (?) should be (dlopen). Can you elaborate?

> dlopen(3) says:
> 
>    If  the  library has dependencies on other shared libraries, then these are
>    also automatically loaded by the  dynamic  linker  using  the  same  rules.
>    (This process may occur recursively, if those libraries in turn have depen-
>    dencies, and so on.)
> 
> Those rules are the same as used by ld.so, so there should be no "not found" 
> problems.

Despite what the dlopen man page says, I had problems with shared library
linkage from libpam.so --(dlopen)--> pam_unix.so when ?=dlopen (the pam
lib couldn't find the plugin).  It only seemed to work if I built OpenVPN
itself with -lpam.  I didn't figure out what what causing the problem, so
it's possible that I wasn't doing something right.  I didn't want OpenVPN 
itself to have the pam dependency, only the auth-pam plugin.

> > dlopening PAM from the plugin seemed to solve all the problems, and
> > followed the approach that others took when accessing PAM from dynamic
> > modules.
> 
> Can you name examples?
> 
> The basic problem I am trying to solve (no, I'm not rummaging through this 
> only because I have nothing better to do) is that auth-pam depends on 
> "libpam.so" instead of "libpam.so.0.77". This means that I would need to add 
> a dependency on pam-devel to my openvpn RPM instead of pam. This seems wrong.

Why is this?  We already have an RPM spec file for OpenVPN and it builds 
binary RPMs which include the auth-pam plugin and doesn't have a pam-devel 
dependency.  (There's a pam-devel dependency only for building the binary 
RPM itself) 

> I've always believed that dlopen should only be used to open libraries shipped 
> along with the calling binary, such as plugins. I'm trying to verify that 
> with you.

If you can figure out how to do it without dlopen, feel free to submit a patch.

James

