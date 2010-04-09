Message-ID: <4BBF2E96.80408@...515...>
Date: Fri, 09 Apr 2010 16:41:42 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4BBF0AE8.6090705@...515...> <51530802.20100409143821@...449...>
In-Reply-To: <51530802.20100409143821@...449...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (8th Apr 2010)
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Carsten,

Thanks for the clarifications! The releases will have signed drivers, of
course. The idea is to use self-signed drivers for the OpenVPN testing
tree only. These drivers change rapidly, so an easy, non-bureaucratic
way to sign the drivers is an absolute necessity. If self-signing is the
only way to achieve that goal, then the user has to choose between
OpenVPN testing and DRM-protected "premium" content.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> Hello,
>
>=20=20=20
>> Discussed driver signing issues with Windows Vista / Windows 7. Agreed
>> that it should be possible to self-sign the drivers OpenVPN uses.
>>=20=20=20=20=20
>
> Not for releases, even for public betas this is a no-go.
> If test signing is enabled DRM content can't be played.
>
> Please read the documentation, it's well documented.
> http://www.microsoft.com/whdc/winlogo/drvsign/drvsign.mspx
>
> |Enabling Test Signing
> |Use the BCDEdit command-line tool to enable test signing. To use BCDEdit=
, the user must be a member
> |of the Administrator group on the system and run the command from an ele=
vated command prompt.
> |An elevated command prompt can be launched by creating a desktop shortcu=
t to cmd.exe,
> |right-clicking the shortcut, and then clicking Run as administrator.
> |The following shows an example of running BDCEdit at the command prompt:
> |// Accept test signed kernel mode signatures
> |Bcdedit.exe =96set TESTSIGNING ON
> |
> |// Do not accept test signed kernel mode signatures
> |Bcdedit.exe =96set TESTSIGNING OFF
> |
> |The TESTSIGNING boot configuration option determines whether Windows Vis=
ta accepts test-signed
> |kernel-mode binaries. The option is not defined by default, which means =
that digital signatures
> |on test-signed kernel-mode drivers will not verify and will not load. Wh=
en Windows Vista accepts
> |test-signed kernel-mode binaries, some premium content that is protected=
 may not be accessible on the system.
>
> Source: Digital Signatures for Kernel Modules on Systems Running Windows =
Vista - kmsigning.doc
>
> The reason for Kernel-Mode Code Signing is that Microsoft can identify
> the author of crashing drivers.
>
> greetings
> Carsten
>
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20=20=20



