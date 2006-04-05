From: Matthias Andree <matthias.andree@...68...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0.6 released
Message-ID: <20060405102256.GA22769@...33...>
References: <44338363.8050008@...41...>
MIME-Version: 1.0
In-Reply-To: <44338363.8050008@...41...>
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
Date: Wed Apr  5 03:24:10 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Wed, 05 Apr 2006, James Yonan wrote:

> 2006.04.05 -- Version 2.0.6
> 
> * Security Vulnerability affecting OpenVPN 2.0 through 2.0.5.
>  An OpenVPN client connecting to a
>  malicious or compromised server could potentially receive
>  "setenv" configuration directives from the server which could
>  cause arbitrary code execution on the client via a LD_PRELOAD
>  attack.  A successful attack appears to require that (a) the
...

James:

What is the MITRE CVE name for this vulnerability?

Thanks,

-- 
Matthias Andree

