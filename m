Message-ID: <511DE2D0.4080903@...515...>
Date: Fri, 15 Feb 2013 09:25:04 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <511B5D2E.5090602@...515...> <511CBDF1.3000406@...515...>
In-Reply-To: <511CBDF1.3000406@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.0 Windows installer with OpenSSL
 1.0.1e ready for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

A minor correction... the installers of course contain OpenSSL 1.0.1e,
not 1.0.0e.

Samuli
> Hi all,
>
> I rebuilt the OpenVPN 2.3.0 Windows installer using OpenSSL 1.0.0e:
>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3.0-I001_master-i686.exe>
> <http://build.openvpn.net/downloads/temp/openvpn-install-2.3.0-I001_master-x86_64.exe>
>
> OpenSSL 1.0.0e fixes the security hole that was discussed earlier on the
> openvpn-user mailing list:
>
> <http://thread.gmane.org/gmane.network.openvpn.user/33859>
> <http://thread.gmane.org/gmane.network.openvpn.user/33867>
>
> The installers also incorporate two fixes related to the installer itself:
>
> <https://community.openvpn.net/openvpn/ticket/249>
> <https://community.openvpn.net/openvpn/ticket/255>
>
> I ran the basic smoketests on WinXP 32-bit and Win7 64-bit and
> everything seemed to work as intended. Please test the installers if you
> can: I'll try to get them released tomorrow.
>
> Best regards,
>


