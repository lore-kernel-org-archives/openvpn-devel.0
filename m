Message-ID: <9e0cf0bf0801231416x3f6e5988p14c4bcc6dc6e986a@...278...>
Date: Thu, 24 Jan 2008 00:16:28 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <4797B53E.4020007@...41...>
MIME-Version: 1.0
References: <4797B53E.4020007@...41...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

All PKCS#11 users, please notice,
There was a major change in the parameters of PKCS#11, please refer to
the HOWTO:
http://openvpn.net/howto.html#pkcs11

Regards,
Alon Bar-Lev.

On 1/23/08, James Yonan <jim@...41...> wrote:
> OpenVPN 2.1-rc5 is available, please test.  I would especially like
> feedback on the Windows TAP driver.  We've made some portability changes
> recently to the driver to allow it to run on Win2K through Vista in x86
> or x64 modes.
>
> Download:
>
> http://openvpn.net/beta/
>
> File Signatures:
>
> http://openvpn.net/signatures/
>
> Here is the change log:
>
> 2008.01.23 -- Version 2.1_rc5
>
> * Fixed Win2K TAP driver bug that was introduced by Vista fixes,
>   incremented driver version to 9.4.
>
> * Windows build system changes:
>
>   Incremented included OpenSSL version to openssl-0.9.7m.
>
>   Updated openssl.patch for openssl-0.9.7m and added some
>   brief usage comments to the head of the patch.
>
>   Added build-pkcs11-helper.sh for building the pkcs11-helper
>   library.
>
>   Integrated inclusion of pkcs11-helper into Windows build
>   system.
>
>   Upgraded TAP build scripts to use WDK 6001.17121
>   (Windows 2008 Server pre-RTM).
>
> * Windows installer changes:
>
>   Clean up the start menu folder.
>
>   Allow for a site-specific sample configuration file and keys
>   to be included in a custom installer (see SAMPCONF macros
>   in settings.in).
>
>   New icon (temporary).
>
> * Added "forget-passwords" command to the management interface
>   (Alon Bar-Lev).
>
> * Added --management-signal option to signal SIGUSR1 when the
>   management interface disconnects (Alon Bar-Lev).
>
> * Modified command line and config file parser to allow
>   quoted strings using single quotes ('') (Alon Bar-Lev).
>
> * Use pkcs11-helper as external library, can be downloaded from
>   https://www.opensc-project.org/pkcs11-helper (Alon Bar-Lev).
>
> * Fixed interim memory growth issue in TCP connect loop where
>   "TCP: connect to %s failed, will try again in %d seconds: %s"
>   is output.
>
> * Fixed bug in epoll driver in event.c, where the lack of a
>   handler for EPOLLHUP could cause 99% CPU usage.
>
> * Defined ALLOW_NON_CBC_CIPHERS for people who don't
>   want to use a CBC cipher for OpenVPN's data channel.
>
> * Added PLUGIN_LIBDIR preprocessor string to prepend a default
>   plugin directory to the dlopen search list when the user
>   specifies the basename of the plugin only (Marius Tomaschewski).
>
> * Rewrote extract_x509_field and modified COMMON_NAME_CHAR_CLASS
>   to allow forward slash characters ("/") in the X509 common name
>   (Pavel Shramov).
>
> * Allow OpenVPN to run completely unprivileged under Linux
>   by allowing openvpn --mktun to be used with --user and --group
>   to set the UID/GID of the tun device node.  Also added --iproute
>   option to allow an alternative command to be executed in place
>   of the default iproute2 command (Alon Bar-Lev).
>
> * Fixed --disable-iproute2 in ./configure to actually disable
>   iproute2 usage (Alon Bar-Lev).
>
> * Added --management-forget-disconnect option -- forget
>   passwords when management session disconnects (Alon Bar-Lev).
>
> James
>
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
>

