From: "Serge Wautier" <serge@...635...>
References: <462C562F.1050107@...41...>
Date: Mon, 23 Apr 2007 08:59:04 +0200
Message-ID: <002501c78574$e1322950$0201a8c0@...1010...>
MIME-Version: 1.0
In-Reply-To: <462C562F.1050107@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

Hi James,

> * The Windows Installer and TAP driver are now signed by
>   OpenVPN Solutions LLC (in addition to the usual GnuPG
>   signatures).

What kind (purpose) of signature is this? Does this mean that Windows won't
reject the driver anymore during installation?

Keep up with the excellent work.
Regards,

Serge.
http://www.apptranslator.com


> -----Original Message-----
> From: openvpn-devel-bounces@lists.sourceforge.net 
> [mailto:openvpn-devel-bounces@lists.sourceforge.net] On 
> Behalf Of James Yonan
> Sent: lundi 23 avril 2007 8:46
> To: openvpn-users@lists.sourceforge.net; 
> Openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] OpenVPN 2.1_rc3 released
> 
> This release should fix all known Vista issues, on both x86 
> and x64, however the TAP driver will not install on Vista x64 
> unless driver signing enforcement is disabled. 
> 
> I've also added the excellent OpenVPN GUI (Mathias Sundman 
> version) as a Windows install option.
> 
> ChangeLog:
> 
> 2007.04.22 -- Version 2.1_rc3
> 
> * Additional fixes to TAP driver for Windows x64.  Driver
>   now runs successfully on Vista x64 if driver signing
>   enforcement is disabled.
>     
> * The Windows Installer and TAP driver are now signed by
>   OpenVPN Solutions LLC (in addition to the usual GnuPG
>   signatures).
> 
> * Added OpenVPN GUI (Mathias Sundman version) as install
>   option in Windows installer.
> 
> * Clean up configure on FreeBSD for recent autotool versions
>   that require that all .h files have to be compiled.
>   Also, FreeBSD install does not support GNU long options
>   which the Makefile in easy-rsa/2.0 uses (not checked the
>   others as we don't install those on Gentoo) (Roy Marples).
> 
> * Added additional scripts to easy-rsa/Windows for working
>   with password-protected keys; also add -extensions server
>   option when generating server cert via
>   build-key-server-pass.bat (Daniel Zauft).
> 
> James
> 
> 
> --------------------------------------------------------------
> -----------
> This SF.net email is sponsored by DB2 Express Download DB2 
> Express C - the FREE version of DB2 express and take control 
> of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


