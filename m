Message-ID: <451FC16A.2010906@...795...>
Date: Sun, 01 Oct 2006 09:23:54 -0400
From: Andrew Richardson <andrew@...795...>
MIME-Version: 1.0
References: <451FBC52.70900@...41...>
In-Reply-To: <451FBC52.70900@...41...>
Sender: Andrew Richardson <andrew@...795...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.0.9 and 2.1-beta16
	released
Reply-To: andrew@...795...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: 'openvpn-users' <openvpn-users@lists.sourceforge.net>
Cc: openvpn-announce@lists.sourceforge.net, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

James Yonan wrote:
> 2006.10.01 -- Version 2.0.9
> 
> * Windows installer updated with OpenSSL 0.9.7l DLLs to fix
>   published vulnerabilities.
> 
> * Fixed TAP-Win32 bug that caused BSOD on Windows Vista
>   (Henry Nestler).  The TAP-Win32 driver has now been
>   upgraded to version 8.4.
> 
> 2006.10.01 -- Version 2.1-beta16
> 
> * Windows installer updated with OpenSSL 0.9.7l DLLs to fix
>   published vulnerabilities.
> 
> * Fixed TAP-Win32 bug that caused BSOD on Windows Vista
>   (Henry Nestler).
> 
> * Autodetect 32/64 bit Windows in installer and install
>   appropriate TAP driver (Mathias Sundman, Hypherion).
> 
> * Fixed bug in loopback self-test introduced
>   in 2.1-beta15 where self test as invoked by
>   "make check" would not properly exit after
>   2 minutes (Paul Howarth).
> 
> James

James, do you have an informal road map for future OpenVPN development?
There have been a number of major enhancements discussed and it's not
clear how they would be brought together, or even if they fit under
OpenVPN vs. a separate project. I'm wondering what your longer-term
plans are for the project.

Andrew

