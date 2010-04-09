Date: Fri, 9 Apr 2010 14:38:21 +0200
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <51530802.20100409143821@...449...>
In-Reply-To: <4BBF0AE8.6090705@...515...>
References: <4BBF0AE8.6090705@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (8th Apr 2010)
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

> Discussed driver signing issues with Windows Vista / Windows 7. Agreed
> that it should be possible to self-sign the drivers OpenVPN uses.

Not for releases, even for public betas this is a no-go.
If test signing is enabled DRM content can't be played.

Please read the documentation, it's well documented.
http://www.microsoft.com/whdc/winlogo/drvsign/drvsign.mspx

|Enabling Test Signing
|Use the BCDEdit command-line tool to enable test signing. To use BCDEdit, =
the user must be a member
|of the Administrator group on the system and run the command from an eleva=
ted command prompt.
|An elevated command prompt can be launched by creating a desktop shortcut =
to cmd.exe,
|right-clicking the shortcut, and then clicking Run as administrator.
|The following shows an example of running BDCEdit at the command prompt:
|// Accept test signed kernel mode signatures
|Bcdedit.exe =96set TESTSIGNING ON
|
|// Do not accept test signed kernel mode signatures
|Bcdedit.exe =96set TESTSIGNING OFF
|
|The TESTSIGNING boot configuration option determines whether Windows Vista=
 accepts test-signed
|kernel-mode binaries. The option is not defined by default, which means th=
at digital signatures
|on test-signed kernel-mode drivers will not verify and will not load. When=
 Windows Vista accepts
|test-signed kernel-mode binaries, some premium content that is protected m=
ay not be accessible on the system.

Source: Digital Signatures for Kernel Modules on Systems Running Windows Vi=
sta - kmsigning.doc

The reason for Kernel-Mode Code Signing is that Microsoft can identify
the author of crashing drivers.

greetings
Carsten


