Message-ID: <4CC19D36.3010602@...1114...>
Date: Fri, 22 Oct 2010 16:18:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4CBC6CD4.7000103@...1418...>
In-Reply-To: <4CBC6CD4.7000103@...1418...>
Subject: Re: [Openvpn-devel] Errors adding routes on Windows 7 with OpenVPN
 2.1.3
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
To: Christian Rank <christian.rank@...1418...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/10/10 17:50, Christian Rank wrote:
> Hello,
> 
> we noticed a strange problem with OpenVPN 2.1.3 on a Windows 7 client
> here: The VPN tunnel to an OpenVPN server does no longer work since the
> OpenVPN 2.1.3 software tries to insert many strange routes into the
> Windows 7 routing tables. With OpenVPN 2.1.1, all goes well. Our OpenVPN
> server is running on OpenVPN 2.1_rc15 i686-pc-linux-gnu.
> 
> I have attached the Windows OpenVPN log file (with verbosity 4).
> 
> Maybe this is a bug in the Windows implementation of OpenVPN 2.1.3?
> 

Thank you very much for your report.  Gert identified a potential issue,
which seems to fix it.  We've added a patch to the
openvpn-testing.git tree.  For more information, see this community Trac
ticket:

  <https://community.openvpn.net/openvpn/ticket/64>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzBnTQACgkQDC186MBRfrpzugCfabfKjY4MIMHNGng35ltxhSPV
BCEAnRKnpCM7GNHlpKAGKT7jkLmTK85Q
=DzNs
-----END PGP SIGNATURE-----

