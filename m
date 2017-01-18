From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <3decc2ec-f8a3-cb6c-a33f-e7f6368dd1b3@...515...>
Date: Wed, 18 Jan 2017 09:48:58 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] ASLR/DEP -enabled 2.4.0 Windows installer available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

There's now a 2.4.0 Windows installer where all executables and 
libraries have ASLR/DEP enabled:

<https://build.openvpn.net/downloads/temp/openvpn-install-2.4.0-I602-aslr-dep.exe>
<https://community.openvpn.net/openvpn/ticket/325>

I ran the installer through the Windows test suite and did not encounter 
any obvious issues.

More testing would be welcome - especially on 32-bit Windows - before we 
make this the default.

Samuli

