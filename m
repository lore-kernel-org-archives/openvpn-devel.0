Message-ID: <BLU174-W4282B6D757F63B4BC7955AEF130@...512...>
Content-Type: multipart/alternative;
	boundary="_5f87b6b4-98b6-4ab5-b50c-0ede3e69f8d3_"
From: Fran --- --- <fran_vidorreta@...160...>
Date: Mon, 7 Oct 2013 17:54:46 +0430
In-Reply-To: <BLU174-W2766285C65FC570D6C9E9FEF130@...512...>
References: <BLU174-W665F058D57093FBADF27EEF120@...512...>,
	<CAOazyz2XvYvo-CukL39+Mt1JNorsrFYHjnV9e7r8myqCOMV9aw@...278...>,
	<BLU174-W23E17F3D6A693728E129C8EF130@...512...>,
	<BLU174-W2766285C65FC570D6C9E9FEF130@...512...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Reading ethernet frames with tap driver 9.9.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_5f87b6b4-98b6-4ab5-b50c-0ede3e69f8d3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable






Hello!!!
Im trying to read ethernet frames with virtual TAP driver, but it doesn't w=
ork.
When I try to read using readfile function it returns with 0 and the last e=
rror code is 83 Incorrect parameter.
Could you help me please??
Thank's
There is the code.


// ConsoleApplication4.cpp: define el punto de entrada de la aplicaci=F3n d=
e consola.
//
#define UNICODE 1#define _UNICODE 1
#include "stdafx.h"
#include <windows.h>
#include <winioctl.h>#include <stdio.h>#include <strsafe.h>
#define deviceTap L"\\\\.\\Global\\{1C112F19-B3DD-4846-B9BA-A433F3A36ADB}.t=
ap"


#define FILE_DEVICE_UNKNOWN             0x00000022
#define TAP_CONTROL_CODE(request,method) \	CTL_CODE(FILE_DEVICE_UNKNOWN, re=
quest, method, FILE_ANY_ACCESS)

#define TAP_WIN_CONTROL_CODE(request, method) \	CTL_CODE(FILE_DEVICE_UNKNOW=
N, request, method, FILE_ANY_ACCESS)
#define TAP_IOCTL_GET_VERSION           TAP_CONTROL_CODE (2, METHOD_BUFFERE=
D)
#define TAP_IOCTL_SET_MEDIA_STATUS      TAP_CONTROL_CODE (6, METHOD_BUFFERE=
D)

 #define TAP_IOCTL_GET_MAC               TAP_CONTROL_CODE(1, METHOD_BUFFERE=
D) #define TAP_IOCTL_GET_MTU               TAP_CONTROL_CODE(3, METHOD_BUFFE=
RED)
 #define TAP_IOCTL_GET_INFO              TAP_CONTROL_CODE(4, METHOD_BUFFERE=
D) #define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE(5, METHOD_BUFFE=
RED) #define TAP_IOCTL_CONFIG_DHCP_MASQ      TAP_CONTROL_CODE(7, METHOD_BUF=
FERED)
 #define TAP_IOCTL_GET_LOG_LINE          TAP_CONTROL_CODE(8, METHOD_BUFFERE=
D) #define TAP_IOCTL_CONFIG_DHCP_SET_OPT   TAP_CONTROL_CODE(9, METHOD_BUFFE=
RED) #define TAP_WIN_IOCTL_GET_MAC               TAP_WIN_CONTROL_CODE(1, ME=
THOD_BUFFERED)
 #define TAP_WIN_IOCTL_GET_VERSION           TAP_WIN_CONTROL_CODE(2, METHOD=
_BUFFERED) #define TAP_WIN_IOCTL_GET_MTU               TAP_WIN_CONTROL_CODE=
(3, METHOD_BUFFERED) #define TAP_WIN_IOCTL_GET_INFO              TAP_WIN_CO=
NTROL_CODE(4, METHOD_BUFFERED)
 #define TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT TAP_WIN_CONTROL_CODE(5, METHOD=
_BUFFERED) #define TAP_WIN_IOCTL_SET_MEDIA_STATUS      TAP_WIN_CONTROL_CODE=
(6, METHOD_BUFFERED) #define TAP_WIN_IOCTL_CONFIG_DHCP_MASQ      TAP_WIN_CO=
NTROL_CODE(7, METHOD_BUFFERED)
 #define TAP_WIN_IOCTL_GET_LOG_LINE          TAP_WIN_CONTROL_CODE(8, METHOD=
_BUFFERED) #define TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT   TAP_WIN_CONTROL_CODE=
(9, METHOD_BUFFERED)
#define TAP_WIN_IOCTL_CONFIG_TUN            TAP_WIN_CONTROL_CODE (10, METHO=
D_BUFFERED)


void DisplayError(LPTSTR lpszFunction)// Routine Description:// Retrieve an=
d output the system error message for the last-error code{	LPVOID lpMsgBuf;
	LPVOID lpDisplayBuf;	DWORD dw =3D GetLastError();
	FormatMessage(
		FORMAT_MESSAGE_ALLOCATE_BUFFER |		FORMAT_MESSAGE_FROM_SYSTEM |		FORMAT_ME=
SSAGE_IGNORE_INSERTS,
		NULL,		dw,		MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),		(LPTSTR)&lpMsgBuf,
		0,		NULL);
	lpDisplayBuf =3D		(LPVOID)LocalAlloc(LMEM_ZEROINIT,
		(lstrlen((LPCTSTR)lpMsgBuf)		+ lstrlen((LPCTSTR)lpszFunction)		+ 40) // a=
ccount for format string
		* sizeof(TCHAR));
	if (FAILED(StringCchPrintf((LPTSTR)lpDisplayBuf,		LocalSize(lpDisplayBuf) =
/ sizeof(TCHAR),
		TEXT("%s failed with error code %d as follows:\n%s"),		lpszFunction,		dw,
		lpMsgBuf)))	{		printf("FATAL ERROR: Unable to output error code.\n");
	}
	_tprintf(TEXT("ERROR: %s\n"), (LPCTSTR)lpDisplayBuf);
	LocalFree(lpMsgBuf);
	LocalFree(lpDisplayBuf);};
BOOL GetTapDriver(LPWSTR device_guid){	// Handle al controlador.
	HANDLE hDevice =3D INVALID_HANDLE_VALUE;  // handle to the drive to be exa=
mined 	BOOL bResult =3D FALSE;                 // results flag
	DWORD junk =3D 0;                     // discard results	hDevice =3D Creat=
eFileW(device_guid,          // drive to open
		GENERIC_READ | GENERIC_WRITE,		0, /* was: FILE_SHARE_READ */		0,
		OPEN_EXISTING,		FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,		0);

	if (hDevice =3D=3D INVALID_HANDLE_VALUE)    // cannot open the drive	{		re=
turn (FALSE);
	}
	// Versi=F3n del controlador.	unsigned long info[3] =3D { 0, 0, 0 };
	DWORD len;	bResult =3D DeviceIoControl(hDevice,                       // d=
evice to be queried		TAP_IOCTL_GET_VERSION,
		&info,		sizeof(info),		&info,		sizeof(info),
		&len,		NULL);
	printf("version: %i.%i.%i\n", info[0], info[1], info[2]);

	// Tama=F1o del bufer de transmision y recepci=F3n.	ULONG mtu;	if (DeviceI=
oControl(hDevice, TAP_WIN_IOCTL_GET_MTU,
		&mtu, sizeof (mtu),		&mtu, sizeof (mtu), &len, NULL))	{
		printf("TAP-Windows MTU=3D%d  \n", (int)mtu);	}
	unsigned long ep[3];

	// Modo de funcionamiento.		if (!DeviceIoControl(hDevice, TAP_WIN_IOCTL_CO=
NFIG_POINT_TO_POINT,
			ep, sizeof (ep),			ep, sizeof (ep), &len, NULL))			printf("Error al conf=
igurar punto a punto.");

	unsigned char MAC_Adr[6] =3D { 0, 0, 0, 0, 0, 0 };	DeviceIoControl(hDevice=
, TAP_WIN_IOCTL_GET_MAC, &MAC_Adr, sizeof(MAC_Adr), &MAC_Adr, sizeof(MAC_Ad=
r), &len, NULL);
	printf(("El codigo MAC del adaptador es: %d %d %d %d %d %d \n"), MAC_Adr[0=
], MAC_Adr[1], MAC_Adr[2], MAC_Adr[3], MAC_Adr[4], MAC_Adr[5]);

	// Activamos la interfaz.	ULONG status =3D TRUE;	if (!DeviceIoControl(hDev=
ice, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
		&status, sizeof (status),		&status, sizeof (status), &len, NULL))		printf=
("WARNING: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS=
 DeviceIoControl call.");

	DWORD longitud;		//printf("\n Longitud %d %d %d \n",&write_buf->capacity, =
&write_buf->len, &write_buf->offset);
	unsigned char m_buf[1500];	bResult =3D WriteFile(hDevice, m_buf, 20, &long=
itud, NULL);	if (bResult =3D=3D 0){
		DisplayError(TEXT("WriteFile"));	}
	printf("Datos Escritos al adaptador: %d", longitud);

	//while (1){		bResult=3DReadFile(hDevice, m_buf, 10, &longitud, NULL);  //=
 Handle al dispositivo, puntero al buffer,=20
		//bResult =3D ReadFile()		if (bResult =3D=3D 0){			DisplayError(TEXT("Rea=
dFile"));
		}		else		{
		};
		int i;		if (longitud > 0){			printf("Longitud leida: %i \n", longitud);
			for (i =3D 0; i < longitud; i++){				printf("%i , %i", m_buf[i], i);			}
			printf("\n");		};	//};=09
	CloseHandle(hDevice);
	while (1){};

	return (bResult);
}


int _tmain(int argc, wchar_t *argv[]){	BOOL bResult =3D FALSE;      // gene=
ric results flag

	bResult =3D GetTapDriver(deviceTap);
	if (bResult)	{
		wprintf(L"Ok");	}	else	{
		wprintf(L"GetDeviceTap failed %ld.\n", GetLastError());	}
	return ((int)bResult);
}
=20=09=09=20=09=20=20=20=09=09=20=20


=20=09=09=20=09=20=20=20=09=09=20=20=20=09=09=20=09=20=20=20=09=09=20=20=20=
=09=09=20=09=20=20=20=09=09=20=20=

--_5f87b6b4-98b6-4ab5-b50c-0ede3e69f8d3_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'><div><br></div><div>

<style><!--
.ExternalClass .ecxhmmessage P {
padding:0px;
}

.ExternalClass body.ecxhmmessage {
font-size:12pt;
font-family:Calibri;
}

--></style>
<div dir=3D"ltr"><br><span style=3D"font-size:12pt;">Hello!!!</span><div><s=
pan style=3D"font-size:12pt;"><br></span></div><div><span style=3D"font-siz=
e:12pt;">Im trying to read ethernet frames with virtual TAP driver, but it =
doesn't work.</span></div><div><br></div><div>When I try to read using read=
file function it returns with 0 and the last error code is 83 Incorrect par=
ameter.</div><div><br></div><div><div>Could you help me please??</div><div>=
<br></div><div>Thank's</div></div><div><br></div><div>There is the code.</d=
iv><div><br><div><div dir=3D"ltr"><div class=3D"ecxgmail_extra"><div class=
=3D"ecxgmail_quote"><blockquote class=3D"ecxgmail_quote" style=3D"border-le=
ft:1px #ccc solid;padding-left:1ex;"><div><div dir=3D"ltr"><div><br></div><=
div><br></div><div><div>// ConsoleApplication4.cpp: define el punto de entr=
ada de la aplicaci=F3n de consola.</div>
<div>//</div><div><br></div><div>#define UNICODE 1</div><div>#define _UNICO=
DE 1</div><div><br></div><div>#include "stdafx.h"</div><div><br></div><div>=
<span style=3D"font-size:12pt;">#include &lt;windows.h&gt;</span></div>
<div>#include &lt;winioctl.h&gt;</div><div>#include &lt;stdio.h&gt;</div><d=
iv>#include &lt;strsafe.h&gt;</div><div><br></div><div><span style=3D"font-=
size:12pt;">#define deviceTap L"\\\\.\\Global\\{1C112F19-B3DD-4846-B9BA-A43=
3F3A36ADB}.tap"</span></div>
<div><br></div><div><br></div><div>#define FILE_DEVICE_UNKNOWN &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; 0x00000022</div><div><br></div><div>#define T=
AP_CONTROL_CODE(request,method) \</div><div><span style=3D"white-space:pre-=
wrap;">	</span>CTL_CODE(FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCE=
SS)</div>
<div><br></div><div>#define TAP_WIN_CONTROL_CODE(request, method) \</div><d=
iv><span style=3D"white-space:pre-wrap;">	</span>CTL_CODE(FILE_DEVICE_UNKNO=
WN, request, method, FILE_ANY_ACCESS)</div><div><br></div><div>#define TAP_=
IOCTL_GET_VERSION &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TAP_CONTROL_CODE (2, M=
ETHOD_BUFFERED)</div>
<div>#define TAP_IOCTL_SET_MEDIA_STATUS &nbsp; &nbsp; &nbsp;TAP_CONTROL_COD=
E (6, METHOD_BUFFERED)</div><div><br></div><div><br></div><div>&nbsp;#defin=
e TAP_IOCTL_GET_MAC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TAP_CO=
NTROL_CODE(1, METHOD_BUFFERED)</div><div>&nbsp;#define TAP_IOCTL_GET_MTU &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TAP_CONTROL_CODE(3, METHOD_B=
UFFERED)</div>
<div>&nbsp;#define TAP_IOCTL_GET_INFO &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;TAP_CONTROL_CODE(4, METHOD_BUFFERED)</div><div>&nbsp;#define TAP=
_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE(5, METHOD_BUFFERED)</div><div=
>&nbsp;#define TAP_IOCTL_CONFIG_DHCP_MASQ &nbsp; &nbsp; &nbsp;TAP_CONTROL_C=
ODE(7, METHOD_BUFFERED)</div>
<div>&nbsp;#define TAP_IOCTL_GET_LOG_LINE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;TAP_CONTROL_CODE(8, METHOD_BUFFERED)</div><div>&nbsp;#define TAP_IOCTL_CON=
FIG_DHCP_SET_OPT &nbsp; TAP_CONTROL_CODE(9, METHOD_BUFFERED)</div><div>&nbs=
p;#define TAP_WIN_IOCTL_GET_MAC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; TAP_WIN_CONTROL_CODE(1, METHOD_BUFFERED)</div>
<div>&nbsp;#define TAP_WIN_IOCTL_GET_VERSION &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; TAP_WIN_CONTROL_CODE(2, METHOD_BUFFERED)</div><div>&nbsp;#define TAP_W=
IN_IOCTL_GET_MTU &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TAP_WIN_C=
ONTROL_CODE(3, METHOD_BUFFERED)</div><div>&nbsp;#define TAP_WIN_IOCTL_GET_I=
NFO &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TAP_WIN_CONTROL_CODE(4,=
 METHOD_BUFFERED)</div>
<div>&nbsp;#define TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT TAP_WIN_CONTROL_CODE=
(5, METHOD_BUFFERED)</div><div>&nbsp;#define TAP_WIN_IOCTL_SET_MEDIA_STATUS=
 &nbsp; &nbsp; &nbsp;TAP_WIN_CONTROL_CODE(6, METHOD_BUFFERED)</div><div>&nb=
sp;#define TAP_WIN_IOCTL_CONFIG_DHCP_MASQ &nbsp; &nbsp; &nbsp;TAP_WIN_CONTR=
OL_CODE(7, METHOD_BUFFERED)</div>
<div>&nbsp;#define TAP_WIN_IOCTL_GET_LOG_LINE &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;TAP_WIN_CONTROL_CODE(8, METHOD_BUFFERED)</div><div>&nbsp;#define TAP_W=
IN_IOCTL_CONFIG_DHCP_SET_OPT &nbsp; TAP_WIN_CONTROL_CODE(9, METHOD_BUFFERED=
)</div><div><br></div><div>#define TAP_WIN_IOCTL_CONFIG_TUN &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp;TAP_WIN_CONTROL_CODE (10, METHOD_BUFFERED)</div>
<div><br></div><div><br></div><div>void DisplayError(LPTSTR lpszFunction)</=
div><div>// Routine Description:</div><div>// Retrieve and output the syste=
m error message for the last-error code</div><div>{</div><div><span style=
=3D"white-space:pre-wrap;">	</span>LPVOID lpMsgBuf;</div>
<div><span style=3D"white-space:pre-wrap;">	</span>LPVOID lpDisplayBuf;</di=
v><div><span style=3D"white-space:pre-wrap;">	</span>DWORD dw =3D GetLastEr=
ror();</div><div><br></div><div><span style=3D"white-space:pre-wrap;">	</sp=
an>FormatMessage(</div>
<div><span style=3D"white-space:pre-wrap;">		</span>FORMAT_MESSAGE_ALLOCATE=
_BUFFER |</div><div><span style=3D"white-space:pre-wrap;">		</span>FORMAT_M=
ESSAGE_FROM_SYSTEM |</div><div><span style=3D"white-space:pre-wrap;">		</sp=
an>FORMAT_MESSAGE_IGNORE_INSERTS,</div>
<div><span style=3D"white-space:pre-wrap;">		</span>NULL,</div><div><span s=
tyle=3D"white-space:pre-wrap;">		</span>dw,</div><div><span style=3D"white-=
space:pre-wrap;">		</span>MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),</div><=
div><span style=3D"white-space:pre-wrap;">		</span>(LPTSTR)&amp;lpMsgBuf,</=
div>
<div><span style=3D"white-space:pre-wrap;">		</span>0,</div><div><span styl=
e=3D"white-space:pre-wrap;">		</span>NULL);</div><div><br></div><div><span =
style=3D"white-space:pre-wrap;">	</span>lpDisplayBuf =3D</div><div><span st=
yle=3D"white-space:pre-wrap;">		</span>(LPVOID)LocalAlloc(LMEM_ZEROINIT,</d=
iv>
<div><span style=3D"white-space:pre-wrap;">		</span>(lstrlen((LPCTSTR)lpMsg=
Buf)</div><div><span style=3D"white-space:pre-wrap;">		</span>+ lstrlen((LP=
CTSTR)lpszFunction)</div><div><span style=3D"white-space:pre-wrap;">		</spa=
n>+ 40) // account for format string</div>
<div><span style=3D"white-space:pre-wrap;">		</span>* sizeof(TCHAR));</div>=
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>if (FAILE=
D(StringCchPrintf((LPTSTR)lpDisplayBuf,</div><div><span style=3D"white-spac=
e:pre-wrap;">		</span>LocalSize(lpDisplayBuf) / sizeof(TCHAR),</div>
<div><span style=3D"white-space:pre-wrap;">		</span>TEXT("%s failed with er=
ror code %d as follows:\n%s"),</div><div><span style=3D"white-space:pre-wra=
p;">		</span>lpszFunction,</div><div><span style=3D"white-space:pre-wrap;">=
		</span>dw,</div>
<div><span style=3D"white-space:pre-wrap;">		</span>lpMsgBuf)))</div><div><=
span style=3D"white-space:pre-wrap;">	</span>{</div><div><span style=3D"whi=
te-space:pre-wrap;">		</span>printf("FATAL ERROR: Unable to output error co=
de.\n");</div>
<div><span style=3D"white-space:pre-wrap;">	</span>}</div><div><br></div><d=
iv><span style=3D"white-space:pre-wrap;">	</span>_tprintf(TEXT("ERROR: %s\n=
"), (LPCTSTR)lpDisplayBuf);</div><div><br></div><div><span style=3D"white-s=
pace:pre-wrap;">	</span>LocalFree(lpMsgBuf);</div>
<div><span style=3D"white-space:pre-wrap;">	</span>LocalFree(lpDisplayBuf);=
</div><div>};</div><div><br></div><div>BOOL GetTapDriver(LPWSTR device_guid=
)</div><div>{</div><div><span style=3D"white-space:pre-wrap;">	</span>// Ha=
ndle al controlador.</div>
<div><span style=3D"white-space:pre-wrap;">	</span>HANDLE hDevice =3D INVAL=
ID_HANDLE_VALUE; &nbsp;// handle to the drive to be examined&nbsp;</div><di=
v><span style=3D"white-space:pre-wrap;">	</span>BOOL bResult =3D FALSE; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // results flag</div>
<div><span style=3D"white-space:pre-wrap;">	</span>DWORD junk =3D 0; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; // discard =
results</div><div><span style=3D"white-space:pre-wrap;">	</span>hDevice =3D=
 CreateFileW(device_guid, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;// drive to ope=
n</div>
<div><span style=3D"white-space:pre-wrap;">		</span>GENERIC_READ | GENERIC_=
WRITE,</div><div><span style=3D"white-space:pre-wrap;">		</span>0, /* was: =
FILE_SHARE_READ */</div><div><span style=3D"white-space:pre-wrap;">		</span=
>0,</div>
<div><span style=3D"white-space:pre-wrap;">		</span>OPEN_EXISTING,</div><di=
v><span style=3D"white-space:pre-wrap;">		</span>FILE_ATTRIBUTE_SYSTEM | FI=
LE_FLAG_OVERLAPPED,</div><div><span style=3D"white-space:pre-wrap;">		</spa=
n>0);</div>
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>if (hDevi=
ce =3D=3D INVALID_HANDLE_VALUE) &nbsp; &nbsp;// cannot open the drive</div>=
<div><span style=3D"white-space:pre-wrap;">	</span>{</div><div><span style=
=3D"white-space:pre-wrap;">		</span>return (FALSE);</div>
<div><span style=3D"white-space:pre-wrap;">	</span>}</div><div><br></div><d=
iv><span style=3D"white-space:pre-wrap;">	</span>// Versi=F3n del controlad=
or.</div><div><span style=3D"white-space:pre-wrap;">	</span>unsigned long i=
nfo[3] =3D { 0, 0, 0 };</div>
<div><span style=3D"white-space:pre-wrap;">	</span>DWORD len;</div><div><sp=
an style=3D"white-space:pre-wrap;">	</span>bResult =3D DeviceIoControl(hDev=
ice, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; // device to be queried</div><div><span style=3D"white-space:pre-wra=
p;">		</span>TAP_IOCTL_GET_VERSION,</div>
<div><span style=3D"white-space:pre-wrap;">		</span>&amp;info,</div><div><s=
pan style=3D"white-space:pre-wrap;">		</span>sizeof(info),</div><div><span =
style=3D"white-space:pre-wrap;">		</span>&amp;info,</div><div><span style=
=3D"white-space:pre-wrap;">		</span>sizeof(info),</div>
<div><span style=3D"white-space:pre-wrap;">		</span>&amp;len,</div><div><sp=
an style=3D"white-space:pre-wrap;">		</span>NULL);</div><div><br></div><div=
><span style=3D"white-space:pre-wrap;">	</span>printf("version: %i.%i.%i\n"=
, info[0], info[1], info[2]);</div>
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>// Tama=
=F1o del bufer de transmision y recepci=F3n.</div><div><span style=3D"white=
-space:pre-wrap;">	</span>ULONG mtu;</div><div><span style=3D"white-space:p=
re-wrap;">	</span>if (DeviceIoControl(hDevice, TAP_WIN_IOCTL_GET_MTU,</div>
<div><span style=3D"white-space:pre-wrap;">		</span>&amp;mtu, sizeof (mtu),=
</div><div><span style=3D"white-space:pre-wrap;">		</span>&amp;mtu, sizeof =
(mtu), &amp;len, NULL))</div><div><span style=3D"white-space:pre-wrap;">	</=
span>{</div>
<div><span style=3D"white-space:pre-wrap;">		</span>printf("TAP-Windows MTU=
=3D%d &nbsp;\n", (int)mtu);</div><div><span style=3D"white-space:pre-wrap;"=
>	</span>}</div><div><br></div><div><span style=3D"white-space:pre-wrap;">	=
</span>unsigned long ep[3];</div>
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>// Modo d=
e funcionamiento.</div><div><span style=3D"white-space:pre-wrap;">		</span>=
if (!DeviceIoControl(hDevice, TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT,</div><di=
v>
<span style=3D"white-space:pre-wrap;">			</span>ep, sizeof (ep),</div><div>=
<span style=3D"white-space:pre-wrap;">			</span>ep, sizeof (ep), &amp;len, =
NULL))</div><div><span style=3D"white-space:pre-wrap;">			</span>printf("Er=
ror al configurar punto a punto.");</div>
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>unsigned =
char MAC_Adr[6] =3D { 0, 0, 0, 0, 0, 0 };</div><div><span style=3D"white-sp=
ace:pre-wrap;">	</span>DeviceIoControl(hDevice, TAP_WIN_IOCTL_GET_MAC, &amp=
;MAC_Adr, sizeof(MAC_Adr), &amp;MAC_Adr, sizeof(MAC_Adr), &amp;len, NULL);<=
/div>
<div><span style=3D"white-space:pre-wrap;">	</span>printf(("El codigo MAC d=
el adaptador es: %d %d %d %d %d %d \n"), MAC_Adr[0], MAC_Adr[1], MAC_Adr[2]=
, MAC_Adr[3], MAC_Adr[4], MAC_Adr[5]);</div><div><br></div><div>
<span style=3D"white-space:pre-wrap;">	</span>// Activamos la interfaz.</di=
v><div><span style=3D"white-space:pre-wrap;">	</span>ULONG status =3D TRUE;=
</div><div><span style=3D"white-space:pre-wrap;">	</span>if (!DeviceIoContr=
ol(hDevice, TAP_WIN_IOCTL_SET_MEDIA_STATUS,</div>
<div><span style=3D"white-space:pre-wrap;">		</span>&amp;status, sizeof (st=
atus),</div><div><span style=3D"white-space:pre-wrap;">		</span>&amp;status=
, sizeof (status), &amp;len, NULL))</div><div><span style=3D"white-space:pr=
e-wrap;">		</span>printf("WARNING: The TAP-Windows driver rejected a TAP_WI=
N_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");</div>
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>DWORD lon=
gitud;</div><div><span style=3D"white-space:pre-wrap;">	</span></div><div><=
span style=3D"white-space:pre-wrap;">	</span>//printf("\n Longitud %d %d %d=
 \n",&amp;write_buf-&gt;capacity, &amp;write_buf-&gt;len, &amp;write_buf-&g=
t;offset);</div>
<div><span style=3D"white-space:pre-wrap;">	</span>unsigned char m_buf[1500=
];</div><div><span style=3D"white-space:pre-wrap;">	</span>bResult =3D Writ=
eFile(hDevice, m_buf, 20, &amp;longitud, NULL);</div><div><span style=3D"wh=
ite-space:pre-wrap;">	</span>if (bResult =3D=3D 0){</div>
<div><span style=3D"white-space:pre-wrap;">		</span>DisplayError(TEXT("Writ=
eFile"));</div><div><span style=3D"white-space:pre-wrap;">	</span>}</div><d=
iv><br></div><div><span style=3D"white-space:pre-wrap;">	</span>printf("Dat=
os Escritos al adaptador: %d", longitud);</div>
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>//while (=
1){</div><div><span style=3D"white-space:pre-wrap;">		</span>bResult=3DRead=
File(hDevice, m_buf, 10, &amp;longitud, NULL); &nbsp;// Handle al dispositi=
vo, puntero al buffer,&nbsp;</div>
<div><span style=3D"white-space:pre-wrap;">		</span>//bResult =3D ReadFile(=
)</div><div><span style=3D"white-space:pre-wrap;">		</span>if (bResult =3D=
=3D 0){</div><div><span style=3D"white-space:pre-wrap;">			</span>DisplayEr=
ror(TEXT("ReadFile"));</div>
<div><span style=3D"white-space:pre-wrap;">		</span>}</div><div><span style=
=3D"white-space:pre-wrap;">		</span>else</div><div><span style=3D"white-spa=
ce:pre-wrap;">		</span>{</div><div><br></div><div><span style=3D"white-spac=
e:pre-wrap;">		</span>};</div>
<div><span style=3D"white-space:pre-wrap;">		</span>int i;</div><div><span =
style=3D"white-space:pre-wrap;">		</span>if (longitud &gt; 0){</div><div><s=
pan style=3D"white-space:pre-wrap;">			</span>printf("Longitud leida: %i \n=
", longitud);</div>
<div><span style=3D"white-space:pre-wrap;">			</span>for (i =3D 0; i &lt; l=
ongitud; i++){</div><div><span style=3D"white-space:pre-wrap;">				</span>p=
rintf("%i , %i", m_buf[i], i);</div><div><span style=3D"white-space:pre-wra=
p;">			</span>}</div>
<div><span style=3D"white-space:pre-wrap;">			</span>printf("\n");</div><di=
v><span style=3D"white-space:pre-wrap;">		</span>};</div><div><span style=
=3D"white-space:pre-wrap;">	</span>//};</div><div><span style=3D"white-spac=
e:pre-wrap;">	</span></div>
<div><span style=3D"white-space:pre-wrap;">	</span>CloseHandle(hDevice);</d=
iv><div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>while =
(1){};</div><div><br></div><div><br></div><div><span style=3D"white-space:p=
re-wrap;">	</span>return (bResult);</div>
<div>}</div><div><br></div><div><br></div><div><br></div><div>int _tmain(in=
t argc, wchar_t *argv[])</div><div>{</div><div><span style=3D"white-space:p=
re-wrap;">	</span>BOOL bResult =3D FALSE; &nbsp; &nbsp; &nbsp;// generic re=
sults flag</div>
<div><br></div><div><span style=3D"white-space:pre-wrap;">	</span>bResult =
=3D GetTapDriver(deviceTap);</div><div><br></div><div><span style=3D"white-=
space:pre-wrap;">	</span>if (bResult)</div><div><span style=3D"white-space:=
pre-wrap;">	</span>{</div>
<div><span style=3D"white-space:pre-wrap;">		</span>wprintf(L"Ok");</div><d=
iv><span style=3D"white-space:pre-wrap;">	</span>}</div><div><span style=3D=
"white-space:pre-wrap;">	</span>else</div><div><span style=3D"white-space:p=
re-wrap;">	</span>{</div>
<div><span style=3D"white-space:pre-wrap;">		</span>wprintf(L"GetDeviceTap =
failed %ld.\n", GetLastError());</div><div><span style=3D"white-space:pre-w=
rap;">	</span>}</div><div><br></div><div><span style=3D"white-space:pre-wra=
p;">	</span>return ((int)bResult);</div>
<div>}</div></div><div><br></div> 		 	   		  </div></div>
</blockquote></div><br></div>
 		 	   		  </div></div><style><!--
.ExternalClass .ecxhmmessage P {
padding:0px;
}

.ExternalClass body.ecxhmmessage {
font-size:12pt;
font-family:Calibri;
}


--></style></div> 		 	   		  </div></div> 		 	   		  </div></body>
</html>=

--_5f87b6b4-98b6-4ab5-b50c-0ede3e69f8d3_--

