Message-ID: <4CF7BB67.2040409@...1114...>
Date: Thu, 02 Dec 2010 16:29:43 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CF7B2FA.9090105@...1147...>
In-Reply-To: <4CF7B2FA.9090105@...1147...>
Subject: Re: [Openvpn-devel] script-security 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/10 15:53, Jan Just Keijser wrote:
> hi all,
> 
> the openvpn 2.1 man page on script-security reads:
> 
> --script-security level [method]
>     This directive offers policy-level control over OpenVPN's usage of 
> external programs and scripts. Lower level values are more restrictive, 
> higher values are more permissive. Settings for level:
> 
>     0 -- Strictly no calling of external programs.
>     1 -- (Default) Only call built-in executables such as ifconfig, ip, 
> route, or netsh.
>     2 -- Allow calling of built-in executables and user-defined scripts.
>     3 -- Allow passwords to be passed to scripts via environmental 
> variables (potentially unsafe).
> 
> but if I try something like
>  openvpn --config <serverconf> --script-security 1 --up "/sbin/ip addr 
> show eth0"
> I still get
> 
> Thu Dec  2 15:52:51 2010 /sbin/ip addr show eth0 tun0 1500 1541 
> 192.168.200.1 255.255.255.0 init
> Thu Dec  2 15:52:51 2010 openvpn_execve: external program may not be 
> called unless '--script-security 2' or higher is enabled.  Use 
> '--script-security 3 system' for backward compatibility with 2.1_rc8 and 
> earlier.  See --help text or man page for detailed info.
> Thu Dec  2 15:52:51 2010 script failed: external program fork failed
> Thu Dec  2 15:52:51 2010 Exiting
> 
> what _IS_ the list of built-in executables? I cannot find it in the 
> source code either.

My understanding of it is executables which are executed by the C code,
like the programs mentioned.  That further means that no external script
hooks may be used, like --up, --down, --route-up, etc, etc.

You need --script-security 2 to enable the script hooks, which will
enable the execve() code path for these hooks.  And if
'--script-security 2 system' is set, it will use system() instead of
execve() to execute the scripts.

If --script-security 0 is used, the execve() calls will be completely
blocked.

For Linux, I believe the list of "built-ins" are ip, ifconfig, netstat
and route.  I'm not sure about the Windows side.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz3u2UACgkQDC186MBRfrq3ZQCfaww4niDxYNBHwGtf7Jv6PTQF
yqEAn0ZFP3glNd7b0YBWIlUXd+FEEWNJ
=cYzj
-----END PGP SIGNATURE-----

