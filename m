Message-ID: <489C8DFB.2000603@...41...>
Date: Fri, 08 Aug 2008 12:18:35 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <4892B01F.10208@...41...>
	<20080808074543.GA8673@...33...>
In-Reply-To: <20080808074543.GA8673@...33...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc9 released -- note security fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: Openvpn-devel@lists.sourceforge.net

> 1 - --script-security is documented in openvpn --help,
>     but not in the manual page.

Really?  I see the documentation clearly added in ./openvpn.8:

.\"*********************************************************
.TP
.B --script-security level
This directive offers policy-level control over OpenVPN's usage of 
external programs
and scripts.  Lower values are more restrictive, higher values are more 
permissive.  Settings for
.B level:

.B 0 --
Strictly no calling of external programs.
.br
.B 1 --
(Default) Only call built-in executables such as ifconfig, ip, route, or 
netsh.
.br
.B 2 --
Allow calling of built-in executables and user-defined scripts.
.br
.B 3 --
Allow passwords to be passed to scripts via environmental variables 
(potentially unsafe).
.\"*********************************************************
.

James

