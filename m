MIME-Version: 1.0
Sender: johnswolter@...277...
Date: Thu, 11 Nov 2010 13:35:50 -0500
Message-ID: <AANLkTinA0-1sAsFh0oo-cmREc+qUBE-2X8d-E7vSVf+s@...278...>
From: john s wolter <johnswolter@...1431...>
Content-Type: multipart/alternative; boundary=0016e6d625f839ba100494cb3ee3
Subject: [Openvpn-devel] Architecture diagram & Theory of Operation documents
Reply-To: johnswolter@...1431...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0016e6d625f839ba100494cb3ee3
Content-Type: text/plain; charset=ISO-8859-1

I'm writing in response to this posting subject..
"Re: [Openvpn-devel] VERY weird interaction between openvpn and
opensc-pkcs11"

When it comes to debugging problems inside OpenVPN and other FOSS software
there is a lack of design information.  Architecture diagram & Theory of
Operation documents are a minimum starting point for those not directly
involved in development.  Do you have a link to these documents?

These documents will greatly improve the way OpenVPN works and how it should
be install and debugged.

Cheers.
-------------------------
John S. Wolter

Mailto:johnswolter@...1431...
Desk Phone: 734-408-1263
Cell phone: 734-904-8433
USA, Eastern Standard Time, -5 GMT, -4 GMT DST

- Cloud based web services
- Virtual Office services
- Software Development
- Engineered applications





On Thu, Nov 11, 2010 at 9:32 AM, Jan Just Keijser <janjust@...1147...> wrote:

> hi all,
>
> I just spent almost a day debugging a very weird interaction between
> OpenVPN 2.1 and opensc-pkcs11 :
>
> Hardware:
> a Feitian ePass smartcard with an Omnikey CardMan 3121 card reader
>
> Software:
> openvpn 2.1.3
> opensc 0.12.0 (not officially released yet)
> pkcs11-helper 1.07
> linux 2.6.34 64bit kernel (fc13)
>
> Here's what happens:
>
> openvpn starts up, queries me for the PKCS11 prompt, connection is
> established alright.
> When I look at the log file (with 'verb 99') I see that the pkcs11
> function __pkcs11h_forkFixup is called several times, with a different
> pid=%d value every time. This is bad, as it causes opensc-pkcs11 to
> reload the card every time (it calls C_Finalize then C_Initialize). This
> operation is very expensive.
> During key renegotiation it gets even worse, as openvpn prompts me for
> the PIN again and connectivity is lost until I enter the PIN.
>
> Now here's the weirdest part:
>
> the __pkcs11h_forkFixup function is called after the invocation of an
> external program (e.g. /sbin/ip link , /sbin/ip/addr add etc). If I use
>  script-security 2 system
> the openvpn_execve function uses 'system()' calls to start these
> programs and the problem goes away !
>
> So it seems that openvpn's openvpn_execve fork+waitpid function causes
> the program pid to change every time, triggering the reset of the pkcs11
> interface !
>
> What shall we do about this?
>
> cheers,
>
> JJK / Jan Just Keijser
>
>
>
>
>
>
>
> ------------------------------------------------------------------------------
> Centralized Desktop Delivery: Dell and VMware Reference Architecture
> Simplifying enterprise desktop deployment and management using
> Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
> client virtualization framework. Read more!
> http://p.sf.net/sfu/dell-eql-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0016e6d625f839ba100494cb3ee3
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I&#39;m writing in response to this posting subject..<br>&quot;Re: [Openvpn=
-devel] VERY weird interaction between openvpn and opensc-pkcs11&quot;<br><=
br>When it comes to debugging problems inside OpenVPN and other FOSS softwa=
re there is a lack of design information.=A0 Architecture diagram &amp; The=
ory of Operation documents are a minimum starting point for those not direc=
tly involved in development.=A0 Do you have a link to these documents?<br>
<br>These documents will greatly improve the way OpenVPN works and how it s=
hould be install and debugged.<br><br><span style=3D"font-size: 10pt; font-=
family: Arial; color: rgb(0, 0, 0); background-color: transparent; font-wei=
ght: normal; font-style: normal; text-decoration: none; vertical-align: bas=
eline;" id=3D"internal-source-marker_0.9064256525306285">Cheers.</span><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">-------------------------</spa=
n><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">John S. Wolter</span><br><span=
 style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); backgro=
und-color: transparent; font-weight: normal; font-style: normal; text-decor=
ation: none; vertical-align: baseline;"></span><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">Mailto:<a href=3D"mailto:johns=
wolter@...1431...">johnswolter@...1431...</a></span><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">Desk Phone: 734-408-1263</span=
><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">Cell phone: 734-904-8433</span=
><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">USA, Eastern Standard Time, -5=
 GMT, -4 GMT DST</span><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;"></span><br><span style=3D"font=
-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); background-color: tra=
nsparent; font-weight: normal; font-style: normal; text-decoration: none; v=
ertical-align: baseline;">- Cloud based web services</span><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">- Virtual Office services</spa=
n><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;"></span><span style=3D"font-siz=
e: 10pt; font-family: Arial; color: rgb(0, 0, 0); background-color: transpa=
rent; font-weight: normal; font-style: normal; text-decoration: none; verti=
cal-align: baseline;">- Software Development</span><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;">- Engineered applications</spa=
n><br>
<span style=3D"font-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); ba=
ckground-color: transparent; font-weight: normal; font-style: normal; text-=
decoration: none; vertical-align: baseline;"></span><br><span style=3D"font=
-size: 10pt; font-family: Arial; color: rgb(0, 0, 0); background-color: tra=
nsparent; font-weight: normal; font-style: normal; text-decoration: none; v=
ertical-align: baseline;"></span><br>
<br><br><br><div class=3D"gmail_quote">On Thu, Nov 11, 2010 at 9:32 AM, Jan=
 Just Keijser <span dir=3D"ltr">&lt;<a href=3D"mailto:janjust@...1147...">j=
anjust@...1147...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, =
204); padding-left: 1ex;">
hi all,<br>
<br>
I just spent almost a day debugging a very weird interaction between<br>
OpenVPN 2.1 and opensc-pkcs11 :<br>
<br>
Hardware:<br>
a Feitian ePass smartcard with an Omnikey CardMan 3121 card reader<br>
<br>
Software:<br>
openvpn 2.1.3<br>
opensc 0.12.0 (not officially released yet)<br>
pkcs11-helper 1.07<br>
linux 2.6.34 64bit kernel (fc13)<br>
<br>
Here&#39;s what happens:<br>
<br>
openvpn starts up, queries me for the PKCS11 prompt, connection is<br>
established alright.<br>
When I look at the log file (with &#39;verb 99&#39;) I see that the pkcs11<=
br>
function __pkcs11h_forkFixup is called several times, with a different<br>
pid=3D%d value every time. This is bad, as it causes opensc-pkcs11 to<br>
reload the card every time (it calls C_Finalize then C_Initialize). This<br>
operation is very expensive.<br>
During key renegotiation it gets even worse, as openvpn prompts me for<br>
the PIN again and connectivity is lost until I enter the PIN.<br>
<br>
Now here&#39;s the weirdest part:<br>
<br>
the __pkcs11h_forkFixup function is called after the invocation of an<br>
external program (e.g. /sbin/ip link , /sbin/ip/addr add etc). If I use<br>
 =A0script-security 2 system<br>
the openvpn_execve function uses &#39;system()&#39; calls to start these<br>
programs and the problem goes away !<br>
<br>
So it seems that openvpn&#39;s openvpn_execve fork+waitpid function causes<=
br>
the program pid to change every time, triggering the reset of the pkcs11<br>
interface !<br>
<br>
What shall we do about this?<br>
<br>
cheers,<br>
<br>
JJK / Jan Just Keijser<br>
<br>
<br>
<br>
<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Centralized Desktop Delivery: Dell and VMware Reference Architecture<br>
Simplifying enterprise desktop deployment and management using<br>
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end<br>
client virtualization framework. Read more!<br>
<a href=3D"http://p.sf.net/sfu/dell-eql-dev2dev" target=3D"_blank">http://p=
.sf.net/sfu/dell-eql-dev2dev</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br>

--0016e6d625f839ba100494cb3ee3--

