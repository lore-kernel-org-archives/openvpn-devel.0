From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506141314.54183.nomis80@...401...> <Pine.LNX.4.58.0506142114190.4004@...41...>
In-Reply-To: <Pine.LNX.4.58.0506142114190.4004@...41...>
MIME-Version: 1.0
Message-Id: <200506150712.01979.nomis80@...401...>
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
Date: Wed Jun 15 04:14:05 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tuesday 14 June 2005 23:24, James Yonan wrote:
> When I was writing the auth-pam plugin, I had problems dynamically linking
> the plugin to PAM unless OpenVPN itself was also dynamically linked to PAM
> (which I didn't want to do).

What kind of problem did you encounter? It seems to work perfectly for me.

> Remember that PAM itself is going to dlopen, 
> in turn, the actual PAM module.  Combining dlopen with dynamic linking has
> got to be problematic when you are dealing with crosslinked dependencies.

I'm not sure what you mean by "crosslinked dependencies". The way I see it is:

openvpn --(dlopen)--> auth-pam --(?)--> libpam.so --(dlopen)--> pam_unix.so

I don't see why (?) should be (dlopen). Can you elaborate?

dlopen(3) says:

   If  the  library has dependencies on other shared libraries, then these are
   also automatically loaded by the  dynamic  linker  using  the  same  rules.
   (This process may occur recursively, if those libraries in turn have depen-
   dencies, and so on.)

Those rules are the same as used by ld.so, so there should be no "not found" 
problems.

> dlopening PAM from the plugin seemed to solve all the problems, and
> followed the approach that others took when accessing PAM from dynamic
> modules.

Can you name examples?

The basic problem I am trying to solve (no, I'm not rummaging through this 
only because I have nothing better to do) is that auth-pam depends on 
"libpam.so" instead of "libpam.so.0.77". This means that I would need to add 
a dependency on pam-devel to my openvpn RPM instead of pam. This seems wrong.

I've always believed that dlopen should only be used to open libraries shipped 
along with the calling binary, such as plugins. I'm trying to verify that 
with you.

