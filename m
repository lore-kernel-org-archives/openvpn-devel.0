Date: Sun, 27 Jan 2008 23:29:35 +0100
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1098705957.20080127232935@...449...>
In-Reply-To: <9e0cf0bf0801271028t5efa9ecei13f35466dd9a9e12@...278...>
References: <4797B53E.4020007@...41...>
	<9e0cf0bf0801231416x3f6e5988p14c4bcc6dc6e986a@...278...>
	<9e0cf0bf0801262257k735616a6r6f0931e4ae5f4e1a@...278...>
	<479C8208.3070602@...1068...>
	<9e0cf0bf0801270530y1ce5d0c0pae2978d87b625a8e@...278...>
	<479CBDF3.60601@...1068...>
	<9e0cf0bf0801271028t5efa9ecei13f35466dd9a9e12@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1-rc5 released
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net

Hello Alon,

> Oh... Building OpenVPN for Windows is very difficult task now...
> I am working to simplify that...

building pkcs11-helper with openssl support didn't work for me with mingw.
the openssl symlinks don't work.

A server that produces nightly builds would be nice ...

------------------------------
what I done till now:

Download + Install
------------------

MinGW (c-compiler) + MSYS (make, etc) + Perl (alternativly Activestate Perl):
http://www.mingw.org/download.shtml

Man2html:
http://hydra.nac.uci.edu/indiv/ehood/man2html.html

OpenSSL 0.9.7 (need perl):
http://www.openssl.org/source/

LZO 2:
http://www.oberhumer.com/opensource/lzo/download/

pkcs11-helper (need man2html)
http://www.opensc-project.org/files/pkcs11-helper/

nullsoft scriptable install system (NSIS)
http://nsis.sourceforge.net/Download

Windows Driver Development Kit
http://www.microsoft.com/whdc/DevTools/ddk/default.mspx
J:\WINDDK\3790.1830\src\setup\devcon

Platform SDK (Windows Server 2003 R2 Platform SDK)
http://www.microsoft.com/downloads/details.aspx?FamilyId=484269E2-3B89-47E3-8EB7-1F2BE6D7123A&displaylang=en
Service.c
Service.H
(from Simple Service example)

Compile
-------
1. patch openssl
2. build openssl
3. build lzo
4. build pkcs11-helper with openssl engine
5. customize install-win32\settings.in
6. run domake-win

greetings
Carsten


