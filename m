From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Got OpenVPN 2.0rc6 working with OpenSC Smartcard
 support
In-Reply-To: <200502020908.26984.fritz.elfert@...347...>
Message-ID: <Pine.LNX.4.58.0502022255100.6387@...41...>
References: <200502020908.26984.fritz.elfert@...347...>
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
Date: Wed Feb  2 22:22:42 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Fritz Elfert <fritz.elfert@...347...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 2 Feb 2005, Fritz Elfert wrote:

> 
> My mail got just bounced because it's too big so here it is again
> without the patch ... Ill upload the patch to the SF patchmanager.
> 
> Hi guys,
> 
> I played around with OpenVPN on Fedora FC3 and Win2K and found it pretty
> nice. Since i use the OpenSC (http://www.opensc.org) SmartCard framework
> on both Win32 and Linux anyway, i wanted OpenVPN using it also ....
>
> So here is a patch which adds OpenSC SmartCard support.
> The patch is versus OpenVPN 2.0rc6 and is tested on both Linux (Fedora FC3)
> and Win2K (built with VC6).
> 
> Some details and remarks:
> 
> Most of the stuff is in 4 new files:
> 
> opensc.c opensc.h - The basic OpenSC support, similar to win32 cryptoapi
> support.
> 
> askphrase.c askphrase.h - A minimalistic GUI (native GDI on Win32, native
> X11 on Unix) for several dialogs:
>  - Requesting the user to insert his Card into the Reader (or an USB token
>    or whatever OpenSC-supported device)
>  - Asking for a PIN to access the SmartCard
> 
> The GUI gan be built both as a standalone app as well as _builtin_ into
> openvpn (which i prefer). On Win, the GUI is capable to interact with the
> user even when it is running as a service. On Linux, it needs a DISPLAY
>  envvar to know where to connect and of course permission to connect to the
>  users display. When built standalone it is something like openssh-askpass or
>  pinentry. Currently, calling it from within openvpn is not implemented
>  (would be similar like in openssh) but you can try it on a console.
> 
> Other (small) changes:
> 
> - Added an option for OpenSC: --opensc-cert
>   argument is the cert-id as hex-string (just like in openssh)
> - Added some code to tweak logfile permissions on Win32.
> - Added some code to make running setuid on Linux working.
> - Added a new subdir "win32" with Visual Studio project files,
>   resouces icons etc.)
> - Added misc automake stuff for Linux
> 
> Notes:
>  On Win32, the binary distribution of OpenSC is linked agains a different
>  openssl version. Since you cannot use 2 versions of the same DLL from
>  within one binary, on Win32 one must rebuild OpenSC and/or OpenVPN linking
>  against the same openssl lib.
> 
>  The icons for the win32 subdir cannot be in a patch - therefore separately
>  attached.
> 
> I plan to build a more client-oriented multi-platform GUI (using wxWidgets)
> which runs as a service on win32 (making openvpnserv.exe unnecessary)
> and uses probably management IF on Unix (should be extended to use
> Unix-Sockets). I also have an InnoSetup based Installer here (i don't like
> nsis) here just in case someone is interested.
> 
> Well, for now thats all ... awaiting your comments / discussion ..

Fritz,

Thanks for the very cool patch.  It's very impressive that you 
implemented both Windows and Linux support.  I'd love to include it, but 
first a few comments/questions:

* We don't tend to put any GUI code directly in OpenVPN.  There's a
management interface now which provides an abstraction layer between the
openvpn executable and a management GUI, and is used, among other things,
for querying passwords.  It would be better if your code could also query
passwords or other user input through the management interface -- then it
will be easier to integrate with existing OpenVPN GUIs, and reduce the 
footprint of the patch.

* Will your code (the non-GUI part) build in the MinGW environment or does
it require MSVC?  MinGW is important because not all developers have
access to MSVC.  Incidentally, I'm not sure if you're aware of this but
because MSVC doesn't support ISO C vararg macros, and because OpenVPN
makes liberal use of them, there's currently a huge performance penalty
when building under MSVC.

* Unfortunately it's a bit late for inclusion in 2.0, but we can start 
talking about merging when the 2.1-beta branch gets forked.

* Any recommendations on smartcards which work well with OpenSC?

James

