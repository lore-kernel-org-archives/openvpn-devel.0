From: "dave" <dev@...575...>
Date: Sun, 31 May 2009 11:22:37 -0500
Message-ID: <F6D6F957DC644BC682F458125E03223F@...576...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C9E1E2.1AA2B8A0"
In-Reply-To: <4A219469.5090500@...41...>
Subject: Re: [Openvpn-devel] Reporting issue with v2.1 rc16
	and--cryptoapicert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'James Yonan' <jim@...41...>, 'Alon Bar-Lev' <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C9E1E2.1AA2B8A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This change seems incomplete, and it does not build on Windows on
non-MINGW32.  It seems simple enough, the conditional compilation
doesn't define 
    OpenVPNCryptAcquireCertificatePrivateKey
For non-MINGW32

Attached is a patch to add that definition for non-MINGW32

-dave

> -----Original Message-----
> From: James Yonan [mailto:jim@...41...] 
> Sent: Saturday, May 30, 2009 3:18 PM
> To: Alon Bar-Lev
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Reporting issue with v2.1 rc16 
> and--cryptoapicert
> 
> 
> Sorry about that.  It must have slipped through the cracks.  
> I've merged 
> the patch:
> 
> --------------------------------------------------------------
> ----------
> r4475 | james | 2009-05-30 13:53:49 -0600 (Sat, 30 May 2009) | 3 lines
> Changed paths:
>     M /branches/BETA21/openvpn/config-win32.h.in
>     M /branches/BETA21/openvpn/cryptoapi.c
>     M /branches/BETA21/openvpn/ssl.c
>     M /branches/BETA21/openvpn/ssl.h
> 
> Fixed issue of symbol conflicts interfering with Windows CryptoAPI
> functionality (Alon Bar-Lev).
> 
> --------------------------------------------------------------
> ----------
> 
> James
> 
> Alon Bar-Lev wrote:
> > Hello James,
> > 
> > I sent you several times correct patch.
> > You did not apply it as-is.
> > Anyway, the attached patches is in queue.
> > 
> > Alon.
> > 
> > On Sat, May 30, 2009 at 1:30 PM, James Yonan <jim@...41...> wrote:
> >> I would rather not have touched cryptoapi.c for rc16, but 
> it wouldn't
> >> build with MinGW 5.1.4 (the .h files in this version of 
> MinGW define the
> >> symbol CryptAcquireCertificatePrivateKey which conflicts 
> with the symbol
> >> of the same definition in cryptoapi.c).  So I did try to 
> work around the
> >> issue, but perhaps I broke something in the process.
> >>
> >> It would be great if one of the developers that uses the crypto API
> >> feature could take a look at it.  We will certainly accept 
> a patch that
> >> fixes any introduced breakage.
> >>
> >> James
> >>
> >> Alon Bar-Lev wrote:
> >>> True.
> >>> I already reported this to James.
> >>> There were too many change-replace at the cryptoapi.c in 
> this version.
> >>>
> >>> On Fri, May 29, 2009 at 2:09 PM, Markus Bickel 
> <ZeroCool.2001@...68...>
> >>> wrote:
> >>>> Dear developers,
> >>>>
> >>>> I'm currently installing and testing OpenVPN 2.1 on 
> windows environment
> >>>> and have seen that there's a newer version rc16.
> >>>>
> >>>> Since this version I cannot use the parameter:
> >>>>
> >>>> --cryptoapicert "Thumb:xx xx xx xx xx"
> >>>>
> >>>> Error message:
> >>>>
> >>>> cannot load certificate "Thumb:xx xx xx xx .... " from Microsoft
> >>>> Certificate Store:
> >>>> error:C506C064:microsoft cryptoapi:GetProcAddress:The 
> specified procedure
> >>>> could not be found.
> >>>>
> >>>>
> >>>> This behaviour is the same on server or client sides.
> >>>> With rc15 this worked well.
> >>>>
> >>>> Maybe this is a small bug.
> >>>> So I want to report this issue to you.
> >>>>
> >>>> Would it be fixed in rc17?
> >>>>
> >>>> Thanks in Adanvce,
> >>>>
> >>>> Markus
> >>>>
> >>>> --
> >>>> Nur bis 31.05.: GMX FreeDSL Komplettanschluss mit DSL 
> 6.000 Flatrate und
> >>>> Telefonanschluss nur 17,95 Euro/mtl.!* 
> http://portal.gmx.net/de/go/dsl02
> >>>>
> >>>>
> >>>> 
> --------------------------------------------------------------
> ----------------
> >>>> Register Now for Creativity and Technology (CaT), June 
> 3rd, NYC. CaT
> >>>> is a gathering of tech-side developers & brand 
> creativity professionals.
> >>>> Meet
> >>>> the minds behind Google Creative Lab, Visual Complexity, 
> Processing, &
> >>>> iPhoneDevCamp as they present alongside digital heavyweights like
> >>>> Barbarian
> >>>> Group, R/GA, & Big Spaceship. 
> http://p.sf.net/sfu/creativitycat-com
> >>>> 
> _______________________________________________
> >>>> Openvpn-devel mailing list
> >>>> Openvpn-devel@lists.sourceforge.net
> >>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>>>
> >>>
> >>> 
> --------------------------------------------------------------
> ----------------
> >>> Register Now for Creativity and Technology (CaT), June 
> 3rd, NYC. CaT is a
> >>> gathering of tech-side developers & brand creativity 
> professionals. Meet
> >>> the minds behind Google Creative Lab, Visual Complexity, 
> Processing, &
> >>> iPhoneDevCamp as they present alongside digital 
> heavyweights like Barbarian
> >>> Group, R/GA, & Big Spaceship. 
> http://p.sf.net/sfu/creativitycat-com
> >>> 
> _______________________________________________
> >>> Openvpn-devel mailing list
> >>> Openvpn-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>
> 
> --------------------------------------------------------------
> ----------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
> is a gathering of tech-side developers & brand creativity 
> professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, 
> Processing, & 
> iPhoneDevCamp as they present alongside digital heavyweights 
> like Barbarian 
> Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

------=_NextPart_000_0000_01C9E1E2.1AA2B8A0
Content-Type: application/octet-stream;
	name="cryptoapi.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cryptoapi.c.patch"

Index: cryptoapi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cryptoapi.c	(revision 4486)
+++ cryptoapi.c	(working copy)
@@ -53,6 +53,8 @@
 static HINSTANCE crypt32dll =3D NULL;=0A=
 static BOOL WINAPI (*OpenVPNCryptAcquireCertificatePrivateKey) =
(PCCERT_CONTEXT pCert, DWORD dwFlags,=0A=
   void *pvReserved, HCRYPTPROV *phCryptProv, DWORD *pdwKeySpec, BOOL =
*pfCallerFreeProv) =3D NULL;=0A=
+#else=0A=
+#define OpenVPNCryptAcquireCertificatePrivateKey =
CryptAcquireCertificatePrivateKey=0A=
 #endif=0A=
 =0A=
 /* Size of an SSL signature: MD5+SHA1 */=0A=

------=_NextPart_000_0000_01C9E1E2.1AA2B8A0--


