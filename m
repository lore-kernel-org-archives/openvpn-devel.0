Message-ID: <4434126C.1030207@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.1-beta12 released
References: <44338444.60509@...41...>
In-Reply-To: <44338444.60509@...41...>
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
Date: Wed Apr  5 11:55:06 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: 'openvpn-users' <openvpn-users@lists.sourceforge.net>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

James Yonan wrote:
> 2006.04.05 -- Version 2.1-beta12
>
> * Security Vulnerability -- An OpenVPN client connecting to a
>  malicious or compromised server could potentially receive
>  "setenv" configuration directives from the server which could
>  cause arbitrary code execution on the client via a LD_PRELOAD
>  attack... 
This vulnerability has been assigned the name CVE-2006-1629.

James


