From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a063286a-f8b9-974b-ed78-f358f1dd67f3@...515...>
Date: Tue, 15 Nov 2016 17:38:22 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Reviewing C# code in openvpnserv2?
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

Selva recently fixed a bug[1] in openvpnserv2, the new OpenVPN 
background service bundled with OpenVPN 2.4_alpha1 Windows installers.

Do we have any C# developers here who could review the code? The PR is here:

<https://github.com/OpenVPN/openvpnserv2/pull/1>

I already built the patched openvpnserv2 and it worked as advertised, 
gracefully shutting down openvpn.exe instances it has launched, instead 
of killing them brutally as it used to do.

Samuli

[1] <https://github.com/xkjyeah/openvpnserv2/issues/10>


