From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Compilation Problem of =?utf-8?b?b3BlbnZwbi0yLjBfYmV0YTEx?=
In-Reply-To: <loom.20041014T173717-97@...171...>
Message-ID: <Pine.LNX.4.61.0410142109220.17905@...210...>
References: <loom.20041014T173717-97@...171...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Oct 14 12:36:43 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: zeeshaan <xeshaan@...293...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 14 Oct 2004, zeeshaan wrote:

> Hi,
>
> I am trying to compile the OpenVpn in windows but no success,
>
> i have installed Mingw,Msys i have opensssl and lzo libraries source also but
>
> when i try to compile the source through mingw by applying command
>
> Make -f makefile.w32
>
> i get errors as
>
> gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -
> If:/openssl-0.9.7d/include -If:/lzo-1.08/include -c crypto.c -o crypto.o
> In file included from crypto.c:36:
> crypto.h:102: parse error before '*' token
> crypto.h: In function `EVP_CipherInit_ov':
> crypto.h:104: warning: implicit declaration of function `EVP_CipherInit'
> crypto.h:104: `ctx' undeclared (first use in this function)
> crypto.h:104: (Each undeclared identifier is reported only once
> crypto.h:104: for each function it appears in.)
> .......
>
> do anybody know wat is the problem?

I think I found your problem!

When you extract the openssl tar-ball the include files in include/openssl 
is all empty, and then you get exactly the above errors when trying to 
build openvpn.

Run "./Configure mingw" to make it copy the include files into the right 
place.

You build it like this: (Big thanks to James for helping me first time I 
had todo this!)

(1) Make sure you have mingw, msys, and perl installed.

(2) From the top level openssl-0.9.x directory, edit ms/mw.bat.

(3) Find the line that says:

     make -f ms/mingw32.mak

   Change to:

     make --win32 -f ms/mingw32.mak

(4) From a command prompt window (not msys bash), cd to top-level openssl
directory.

(5) Type "ms\mw" to start build.

(6) When build is finished, the .DLLs will be in the top level openssl
directory and the .a and .exe files will be in the "out" subdirectory.

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail

