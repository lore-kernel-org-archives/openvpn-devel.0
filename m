From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <572C454A.1060901@...515...>
Date: Fri, 6 May 2016 10:18:34 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Installation failure with
 openvpn-install-2.3.10-I003-i686.exe on Windows XP 32-bit?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I received a report on IRC that "openvpn-install-2.3.10-I003-i686.exe"=20
installer fails on Windows XP 32-bit with

"This installer only works on Windows Vista, Windows server 2008 and above."

Can anyone else reproduce the above problem on Windows XP?

The openvpn-build commit that made this error possible was 65e328c:

<https://github.com/OpenVPN/openvpn-build/commit/65e328c89182c47d1a93398e04=
ca92199bf17af3>

However, as it states in the commit log the code path was tested before=20
merging it.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

