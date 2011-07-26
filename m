From: Russell Morris <openvpn@...1315...>
Date: Mon, 25 Jul 2011 21:57:57 -0500
Message-id: <1311649077083710500@...1315...>
MIME-version: 1.0
Content-type: multipart/mixed;
	boundary="===axigen=6587403400883786210745080012247054633544=axigen==="
Subject: [Openvpn-devel] Windows Auto-Proxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=6587403400883786210745080012247054633544=axigen===
Content-Type: multipart/alternative;
	boundary="===axigen=1131522696838780789584025221760382763704=axigen==="

--===axigen=1131522696838780789584025221760382763704=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline








 *=20
 *=20
 *=20



Hi,

=20

I have been discussing this a bit with Samuli, to see if it makes sense =E2=
=80=93 and it seems that perhaps it does, so let me raise this with the dev=
elopment folks to get your thoughts. Hopefully this is something that would=
 help OpenVPN (or at least that=E2=80=99s my intention!).=20

=20

I use OpenVPN with a Windows client, and I tend to be on one network one mi=
nute, another the next. One time with a proxy, the next time without =E2=80=
=A6 so I really want OpenVPN to automatically detect the proxy (if there is=
 one), and apply it =E2=80=A6 for every connection restart, client open, et=
c. My thinking is to add a new option, say something like =E2=80=9Cauto-pro=
xy=E2=80=9D (so this won=E2=80=99t break anything that is already working!)=
. The idea being that if this option is enabled, then on every connection /=
 reconnection attempt OpenVPN will first check the proxy, and then apply it=
 for the actual connection back to the server. Hopefully this makes sense s=
o far =E2=80=A6 J.

=20

To try to help with this, I wrote a small application that detect the Windo=
ws proxy settings (even working with PAC files!), based on WinHTTP. I have =
attached the code to this email, so you can take a look at comment (BTW, it=
 builds just fine in Visual Studio Express 2010). A few thoughts on this co=
de,

- feel free to try it on various configurations and machines (and provide f=
eedback of course!). However, it may not need to be bulletproof before it's=
 included (but feel free to disagree!), as it=E2=80=99s disabled by just by=
 not using the (new) auto-proxy option.

- I have tried it on Win XP and Win 7, with a proxy PAC file ... both on an=
d off the network (so with and without proxy). It works fine in all these c=
ases (and gets the right answer ... :-)).

- I'm not sure how you use proxy in your code. At least with the PAC file t=
hat I go through, I get a response back of the format proxy.domain.net:8080=
;10.10.10.10:8080. We may need to parse this (again, just not sure how you =
use it).

- I have not implemented asynchronous processing. It can be done, but not s=
ure it buys much, as you can't proceed until the proxy information is avail=
able. I also haven't modified the WinHTTP timeout. Again, this can be done =
if needed (but the response is typically quite quick).

- the slew of messages that I have put in the code are just FYI for now. Th=
ese could be split to console output, or logging, or just removed.

Whatever folks prefer.

=20

So - please take a look at let me know. I=E2=80=99m not sure exactly how it=
 would be integrated in to the OpenVPN code, as I don=E2=80=99t have the bi=
g picture of that. But I=E2=80=99m sure someone else does, and I can modify=
 this as needed to get to that point.

=20

Thanks,

=E2=80=A6 Russell

=20

=20

--===axigen=1131522696838780789584025221760382763704=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><BR>
<DIV style=3D"null: ">
<META content=3D"text/html; charset=3Dus-ascii" equiv=3D"Content-Type" http=
=3D"HTTP">
<META name=3DProgId content=3DWord.Document>
<META name=3DGenerator content=3D"Microsoft Word 12">
<META name=3DOriginator content=3D"Microsoft Word 12"><LINK rel=3DFile-List=
><LINK rel=3DthemeData href=3D"~~themedata~~"><LINK rel=3DcolorSchemeMappin=
g href=3D"~~colorschememapping~~">
<STYLE><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-alt:Wingdings;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-alt:"Calisto MT";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1107305727 0 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Arial Rounded MT Bold";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	mso-themecolor:hyperlink;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></STYLE>

<DIV class=3DWordSection1>
<P class=3DMsoNormal>Hi,<?xml:namespace prefix =3D o /><o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>I have been discussing this a bit with Samuli, to see =
if it makes sense =E2=80=93 and it seems that perhaps it does, so let me ra=
ise this with the development folks to get your thoughts. Hopefully this is=
 something that would help OpenVPN (or at least that=E2=80=99s my intention=
!). <o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>I use OpenVPN with a Windows client, and I tend to be =
on one network one minute, another the next. One time with a proxy, the nex=
t time without =E2=80=A6 so I really want OpenVPN to automatically detect t=
he proxy (if there is one), and apply it =E2=80=A6 for every connection res=
tart, client open, etc. My thinking is to add a new option, say something l=
ike =E2=80=9Cauto-proxy=E2=80=9D (so this won=E2=80=99t break anything that=
 is already working!). The idea being that if this option is enabled, then =
on every connection / reconnection attempt OpenVPN will first check the pro=
xy, and then apply it for the actual connection back to the server. Hopeful=
ly this makes sense so far =E2=80=A6 <SPAN style=3D"FONT-FAMILY: Wingdings;=
 mso-ascii-font-family: Calibri; mso-ascii-theme-font: minor-latin; mso-han=
si-font-family: Calibri; mso-hansi-theme-font: minor-latin; mso-char-type: =
symbol; mso-symbol-font-family: Wingdings"><SPAN style=3D"mso-char-type: sy=
mbol; mso-symbol-font-family: Wingdings">J</SPAN></SPAN>.<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>To try to help with this, I wrote a small application =
that detect the Windows proxy settings (even working with PAC files!), base=
d on <SPAN class=3DSpellE>WinHTTP</SPAN>. I have attached the code to this =
email, so you can take a look at comment (BTW, it builds just fine in Visua=
l Studio Express 2010). A few thoughts on this code,<o:p></o:p></P>
<P class=3DMsoNormal>- feel free to try it on various configurations and ma=
chines (and provide feedback of course!). However, it may not need to be bu=
lletproof before it's included (but feel free to disagree!), as it=E2=80=99=
s disabled by just by not using the (new) auto-proxy option.<o:p></o:p></P>
<P class=3DMsoNormal>- I have tried it on Win XP and Win 7, with a proxy PA=
C file ... both on and off the network (so with and without proxy). It work=
s fine in all these cases (and gets the right answer ... :-)).<o:p></o:p></=
P>
<P class=3DMsoNormal>- I'm not sure how you use proxy in your code. At leas=
t with the PAC file that I go through, I get a response back of the format =
proxy.domain.net:8080;10.10.10.10:8080. We may need to parse this (again, j=
ust not sure how you use it).<o:p></o:p></P>
<P class=3DMsoNormal>- I have not implemented asynchronous processing. It c=
an be done, but not sure it buys much, as you can't proceed until the proxy=
 information is available. I also haven't modified the <SPAN class=3DSpellE=
>WinHTTP</SPAN> timeout. Again, this can be done if needed (but the respons=
e is typically quite quick).<o:p></o:p></P>
<P class=3DMsoNormal>- the slew of messages that I have put in the code are=
 just FYI for now. These could be split to console output, or logging, or j=
ust removed.<o:p></o:p></P>
<P class=3DMsoNormal>Whatever folks prefer.<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>So - please take a look at let me know. I=E2=80=99m no=
t sure exactly how it would be integrated in to the OpenVPN code, as I don=
=E2=80=99t have the big picture of that. But I=E2=80=99m sure someone else =
does, and I can modify this as needed to get to that point.<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal>Thanks,<o:p></o:p></P>
<P class=3DMsoNormal>=E2=80=A6 Russell<o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P></DIV></DIV></body></html>=

--===axigen=1131522696838780789584025221760382763704=axigen===--

--===axigen=6587403400883786210745080012247054633544=axigen===
Content-Type: text/plain; charset="utf-8"; name=AutoProxy.c
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="AutoProxy.c"

/**************************************************************************=
********

Utility: AutoProxy - automatically determine Windows Proxy (example for Ope=
nVPN)
Author : R. Morris
Vesion : 1.00

Reference Information:
1) C++ Character Constants
http://msdn.microsoft.com/query/dev10.query?appId=3DDev10IDEF1&l=3DEN-US&k=
=3Dk(L);k(DevLang-%22C%2B%2B%22)&rd=3Dtrue

2) WinHTTP Functions:
WinHttpOpen Function                          : http://msdn.microsoft.com/e=
n-us/library/aa384098(v=3Dvs.85).aspx
WinHttpGetProxyForUrl Function                : http://msdn.microsoft.com/e=
n-us/library/aa384097(v=3Dvs.85).aspx

2) WinHTTP Structures:
WINHTTP_CURRENT_USER_IE_PROXY_CONFIG Structure: http://msdn.microsoft.com/e=
n-us/library/aa384250(VS.85).aspx
WINHTTP_AUTOPROXY_OPTIONS Structure           : http://msdn.microsoft.com/e=
n-us/library/aa384123(v=3Dvs.85).aspx
WINHTTP_PROXY_INFO Structure                  : http://msdn.microsoft.com/e=
n-us/library/aa383912(v=3Dvs.85).aspx

***************************************************************************=
*********/

#include <Windows.h>
#include <winhttp.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>

// Include WinHTTP Library
#pragma comment(lib, "winhttp.lib")

void main()
{
	LPWSTR lpszURL;													// LPWSTR: Input URL (pointer to Unicode strin=
g, to search for Proxy)
	HINTERNET hSession;												// HINTERNET: Session Handle (for HTTP Open)
	WINHTTP_CURRENT_USER_IE_PROXY_CONFIG IEProxyConfig;				// Structure: IE Pr=
oxy Configuration (for current user)
	WINHTTP_AUTOPROXY_OPTIONS AutoProxyOptions;						// Structure: AutoProxy O=
ptions
	WINHTTP_PROXY_INFO AutoProxyInfo;								// Structure: WinHTTP (Auto)Proxy=
 Information
	BOOL bURLResult;												// Boolean: URL Result (from Get HTTP Proxy Ca=
ll)
	long errNum;													// Long: Error Number (from WinHTTP Call)
	LPCWSTR lpszDefaultURL =3D L"http://www.openvpn.net";				// LPCWSTR: Defau=
lt URL

	// Get input from user for site to check proxy for (as proxy can be site d=
ependent)
	lpszURL =3D (LPWSTR)GlobalAlloc(GMEM_FIXED, 512);
	wprintf(L"URL to check Proxy for [%s]: ", lpszDefaultURL);
	_getws_s(lpszURL, 256);

	printf("\nStarting Proxy processing ...\n");
	if (wcslen(lpszURL) =3D=3D 0) {
		wprintf(L"   Empty URL, using default entry [%s]\n", lpszDefaultURL);
		wcscpy_s(lpszURL, 256, lpszDefaultURL);
	}

	// Retreive Internet Explorer Proxy Configuration (for Current User)
	ZeroMemory(&AutoProxyOptions, sizeof(AutoProxyOptions));
	ZeroMemory(&AutoProxyInfo, sizeof(AutoProxyInfo));

	printf("   Retrieving Internet Explorer Proxy Configuration (for Current U=
ser) ...\n");
	if (WinHttpGetIEProxyConfigForCurrentUser(&IEProxyConfig) =3D=3D TRUE) {

		// Set Options for Internet Explorer =3D Automatically Detect Settings (1=
st Priority)
		if (IEProxyConfig.fAutoDetect =3D=3D TRUE) {
			printf("   Internet Explorer calls for AutoDetect\n");
			AutoProxyOptions.dwFlags =3D WINHTTP_AUTOPROXY_AUTO_DETECT;
			AutoProxyOptions.dwAutoDetectFlags =3D WINHTTP_AUTO_DETECT_TYPE_DHCP | W=
INHTTP_AUTO_DETECT_TYPE_DNS_A;
			AutoProxyOptions.fAutoLogonIfChallenged =3D TRUE;

		// Set Options for Internet Explorer =3D Use Automatic Configuration Scri=
pt (2nd Priority)
		} else if (IEProxyConfig.lpszAutoConfigUrl !=3D NULL) {
			printf("   Internet Explorer calls for Auto Configuration Script\n");
			AutoProxyOptions.dwFlags =3D WINHTTP_AUTOPROXY_CONFIG_URL;
			AutoProxyOptions.lpszAutoConfigUrl =3D IEProxyConfig.lpszAutoConfigUrl;
			AutoProxyOptions.fAutoLogonIfChallenged =3D TRUE;

		// Set Options for Internet Explorer =3D Proxy Server (3rd Priority)
		} else if (IEProxyConfig.lpszProxy !=3D NULL) {
			printf("   Internet Explorer calls for (defined) Proxy Server\n");
			AutoProxyInfo.dwAccessType =3D WINHTTP_ACCESS_TYPE_NAMED_PROXY;
			AutoProxyInfo.lpszProxy =3D IEProxyConfig.lpszProxy;
			AutoProxyInfo.lpszProxyBypass =3D IEProxyConfig.lpszProxyBypass;

		// Set Options for Internet Explorer =3D No Proxy Options Defined (so no =
proxy!)
		} else {
			printf("   Internet Explorer does not define any proxy options\n");
			AutoProxyInfo.dwAccessType =3D WINHTTP_ACCESS_TYPE_NO_PROXY;
		}

	} else {
		// Retrieving Internet Explorer Configuration failed, so try Auto Detecti=
on!
		printf("   Internet Explorer Configuration Read Failed (so attempt Auto D=
etection!)\n");
		AutoProxyOptions.dwFlags =3D WINHTTP_AUTOPROXY_AUTO_DETECT;
		AutoProxyOptions.dwAutoDetectFlags =3D WINHTTP_AUTO_DETECT_TYPE_DHCP | WI=
NHTTP_AUTO_DETECT_TYPE_DNS_A;
	}

	// Now, retreive Proxy information based on Internet Explorer Configuratio=
n (if appropriate)
	if (AutoProxyOptions.dwFlags !=3D 0) {

		// Need to create a temporary WinHttp session handle -> Note: performance=
 of GetProxyInfoForUrl can be improved by saving this hSession handle acros=
s calls instead of creating a new handle each time
		printf("   Opening WinHTTP Session\n");
		hSession =3D WinHttpOpen(L"OpenVPN AutoProxy Check", WINHTTP_ACCESS_TYPE_=
NO_PROXY, WINHTTP_NO_PROXY_NAME, WINHTTP_NO_PROXY_BYPASS, 0);

		// Get Proxy Details for Target URL
		printf("      Getting Proxy Details for Target URL ...\n");
		bURLResult =3D WinHttpGetProxyForUrl(hSession, lpszURL, &AutoProxyOptions=
, &AutoProxyInfo);

		// Evaluate Results from URL Specific Proxy check
		if (bURLResult =3D=3D TRUE) {
			// Successful, retrieve Proxy details
				printf("      Proxy Query Successful, Retrieved Proxy for URL!\n");
		} else {

			// Proxy retreival failed, so get error number (to determine why it fail=
ed) ... and set for no Proxy (as call failed)
			printf("      Proxy Query failed, retreive Error Code\n");
			errNum =3D GetLastError();
			AutoProxyInfo.dwAccessType =3D WINHTTP_ACCESS_TYPE_NO_PROXY;

			// And display error information (to examine why it failed)
			printf("      WinHTTPGetProxyForURL Error: ");
			switch (errNum) {
				case ERROR_WINHTTP_AUTO_PROXY_SERVICE_ERROR:
					printf("ERROR_WINHTTP_AUTO_PROXY_SERVICE_ERROR\n");
					break;
				case ERROR_WINHTTP_BAD_AUTO_PROXY_SCRIPT:
					printf("ERROR_WINHTTP_BAD_AUTO_PROXY_SCRIPT\n");
					break;
				case ERROR_WINHTTP_INCORRECT_HANDLE_TYPE:
					printf("ERROR_WINHTTP_INCORRECT_HANDLE_TYPE\n");
					break;
				case ERROR_WINHTTP_INTERNAL_ERROR:
					printf("ERROR_WINHTTP_INTERNAL_ERROR\n");
					break;
				case ERROR_WINHTTP_INVALID_URL:
					printf("ERROR_WINHTTP_INVALID_URL\n");
					break;
				case ERROR_WINHTTP_LOGIN_FAILURE:
					printf("ERROR_WINHTTP_LOGIN_FAILURE\n");
					break;
				case ERROR_WINHTTP_OPERATION_CANCELLED:
					printf("ERROR_WINHTTP_OPERATION_CANCELLED\n");
					break;
				case ERROR_WINHTTP_UNABLE_TO_DOWNLOAD_SCRIPT:
					printf("ERROR_WINHTTP_UNABLE_TO_DOWNLOAD_SCRIPT\n");
					break;
				case ERROR_WINHTTP_UNRECOGNIZED_SCHEME:
					printf("ERROR_WINHTTP_UNRECOGNIZED_SCHEME\n");
					break;
				case ERROR_NOT_ENOUGH_MEMORY:
					printf("ERROR_NOT_ENOUGH_MEMORY\n");
					break;
			}

		}

		// Close WinHTTP Session
		printf("   Closing WinHTTP Session\n");
		WinHttpCloseHandle(hSession);
	}

	// Print Summary Information (i.e. Proxy details)
	printf("\nProxy Details (determined by routine):\n");
	printf("   Proxy Type: ");
	switch (AutoProxyInfo.dwAccessType) {
		case WINHTTP_ACCESS_TYPE_DEFAULT_PROXY:
			printf("WINHTTP_ACCESS_TYPE_DEFAULT_PROXY\n");
			wprintf(L"   Proxy: %s\n", AutoProxyInfo.lpszProxy);
			wprintf(L"   Proxy Bypass: %s\n", AutoProxyInfo.lpszProxyBypass);
			break;
		case WINHTTP_ACCESS_TYPE_NO_PROXY:
			printf("WINHTTP_ACCESS_TYPE_NO_PROXY\n");
			break;
		case WINHTTP_ACCESS_TYPE_NAMED_PROXY:
			printf("WINHTTP_ACCESS_TYPE_NAMED_PROXY\n");
			wprintf(L"   Proxy: %s\n", AutoProxyInfo.lpszProxy);
			wprintf(L"   Proxy Bypass: %s\n", AutoProxyInfo.lpszProxyBypass);
			break;
	}

	// Free up Memory Allocated during the Proxy Detection process
	printf("\nProxy Detection completed!\n");
	printf("Freeing up Memory Allocated during the Proxy Detection Process ...=
\n");
	if (IEProxyConfig.lpszAutoConfigUrl !=3D NULL) GlobalFree(IEProxyConfig.lp=
szAutoConfigUrl);
	if (IEProxyConfig.lpszProxy !=3D NULL) GlobalFree(IEProxyConfig.lpszProxy);
	if (IEProxyConfig.lpszProxyBypass !=3D NULL) GlobalFree(IEProxyConfig.lpsz=
ProxyBypass);
	if (AutoProxyInfo.lpszProxy !=3D NULL)  GlobalFree(AutoProxyInfo.lpszProxy=
);
	if (AutoProxyInfo.lpszProxyBypass !=3D NULL) GlobalFree(AutoProxyInfo.lpsz=
ProxyBypass);
	GlobalFree(lpszURL);
	printf("Memory deallocation processing completed\n\n");

	// And exit (letting the user see the info first)
	printf ("\nPress any key to exit ...");
	_getch();
}


--===axigen=6587403400883786210745080012247054633544=axigen===--


