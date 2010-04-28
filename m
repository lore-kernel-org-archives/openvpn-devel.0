Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 28 Apr 2010 11:31:37 -0500
Message-ID: <46765BEFF12FD9429C02AC2050704CE50137DEED@...1363...>
In-Reply-To: <mailman.290480.1272467076.8007.openvpn-devel@lists.sourceforge.net>
References: <mailman.290480.1272467076.8007.openvpn-devel@lists.sourceforge.net>
From: "Kayvan Javid" <kayvan.javid@...1264...>
Subject: Re: [Openvpn-devel] Openvpn-devel Digest, Vol 47, Issue 36
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

> Date: Wed, 28 Apr 2010 09:12:29 -0500
> From: <openvpn@...1315...>
> Very interesting timing! Just last night I was poking about about this
> a bit, and I'm not so sure that the proxy approach noted so far is the
> best / right way to do this. Rather, to be able to handle dynamic (not
> just static) proxy configurations the WinHTTP API looks to me to be
the
> way to do this (see http://msdn.microsoft.com/en-
> us/library/aa384097(v=3DVS.85).aspx for an example).

Actually the InternetQueryOption and WinHTTP API need to be used in
conjunction to guarantee proxy setting coverage - or at least thats the
approach we have taken in our products.
=20
> Message: 2
> Date: Wed, 28 Apr 2010 17:24:31 +0300
> From: Alon Bar-Lev <alon.barlev@...277...>
> The IE API is user specific.
> As OpenVPN runs as a service using own user or system account, IE API
> is not suitable.
> Using WinHTTP indeed looks better.

I don't believe this is correct, depending on the handle you pass to the
API you can set proxy settings on a per connection, per session or
global basis.  In any case, surely having a per user proxy settings is
not an issue, as you are going to establish a VPN on a per user basis
also?

Sorry I am not in a position to help develop, but can provide you with
basically what you need to use, the following should compile under
MinGW, had to snip out some unneeded stuff but you get the idea:

=3D=3D=3D=3D=3D

// Alter system-wide web proxy settings
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <wininet.h>

#include <iostream>
#include <cstring>
#include <string>

// Define various things which don't seem
// to exist in the MinGW headers

#define INTERNET_OPTION_PER_CONNECTION_OPTION 75
#define INTERNET_PER_CONN_FLAGS 1
#define PROXY_TYPE_PROXY 2
#define PROXY_TYPE_DIRECT 1
#define PROXY_TYPE_AUTO_PROXY_URL 4
#define INTERNET_PER_CONN_PROXY_SERVER 2
#define INTERNET_PER_CONN_PROXY_BYPASS 3
#define INTERNET_PER_CONN_AUTOCONFIG_URL 4

typedef struct {
	DWORD dwOption;
	union {
		DWORD dwValue;
		LPTSTR pszValue;
		FILETIME ftValue;
	} Value;
} INTERNET_PER_CONN_OPTION, *LPINTERNET_PER_CONN_OPTION;

typedef struct {
	DWORD dwSize;
	LPTSTR pszConnection;
	DWORD dwOptionCount;
	DWORD dwOptionError;
	LPINTERNET_PER_CONN_OPTION pOptions;
} INTERNET_PER_CONN_OPTION_LIST, *LPINTERNET_PER_CONN_OPTION_LIST;

// Entry point

int main(int argc, char *argv[])
{
	// Initialise the option list with options common to various
proxy types
	INTERNET_PER_CONN_OPTION_LIST list;
	INTERNET_PER_CONN_OPTION options[3];
	options[0].dwOption =3D INTERNET_PER_CONN_FLAGS;
	options[2].dwOption =3D INTERNET_PER_CONN_PROXY_BYPASS;
	std::string proxy, bypass("127.0.0.1;");
=09
	// Use a specific proxy
	options[0].Value.dwValue =3D PROXY_TYPE_PROXY | PROXY_TYPE_DIRECT;
	proxy.assign("http://");
	proxy.append(argv[2]);
	options[1].dwOption =3D INTERNET_PER_CONN_PROXY_SERVER;
	options[1].Value.pszValue =3D (TCHAR*) (proxy.c_str());

	// Add the proxy itself to the list of things to access directly
	// - but don't stick the protocol or port number in the bypass
list
	std::string addtobypass(proxy.substr(7));
	std::string::size_type pos(addtobypass.find(':'));
	if (pos !=3D std::string::npos)
	{
		addtobypass.assign(addtobypass.substr(0, pos));
	}
	bypass.append("; ");
	bypass.append(addtobypass);

	list.dwOptionCount =3D 3;
=09
	// or to use no proxy
	// options[0].Value.dwValue =3D PROXY_TYPE_DIRECT;
	//	list.dwOptionCount =3D 1;
=09
	// or to use a proxy autoconfiguration file
	//	options[0].Value.dwValue =3D PROXY_TYPE_AUTO_PROXY_URL |
PROXY_TYPE_DIRECT;
	//	options[1].dwOption =3D INTERNET_PER_CONN_AUTOCONFIG_URL;
	//	options[1].Value.pszValue =3D argv[2];
	//	list.dwOptionCount =3D 3;
=09
	// Finalise option list
	options[2].Value.pszValue =3D (TCHAR*) (bypass.c_str());
	list.dwSize =3D sizeof(list);
	list.pszConnection =3D NULL;
	list.dwOptionError =3D 0;
	list.pOptions =3D options;

	// Set the options
	if (InternetSetOption(NULL,
INTERNET_OPTION_PER_CONNECTION_OPTION, &list, sizeof(list)) =3D=3D FALSE)
	{
		std::cerr << "Could not InternetSetOption (1): " <<
GetLastError() << std::endl;
		return 2;
	}
=09
	// Tell Windows we've finished changing options and to apply the
new ones now
	if (InternetSetOption(NULL, INTERNET_OPTION_REFRESH, NULL, 0) =3D=3D
FALSE)
	{
		std::cerr << "Could not InternetSetOption (2): " <<
GetLastError() << std::endl;
		return 2;
	}
=09
	return 0;
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D

We use the above in conjunction with the commandline WinHTTP API
wrapper:

proxycfg -u

This seems to do the job for us.

HTH, goodluck.

Kave

