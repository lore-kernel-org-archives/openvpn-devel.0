From: tincanteksup <tincanteksup@...277...>
Message-ID: <ee0e5768-c1d3-47ea-a466-b868b78cbe21@...277...>
Date: Sat, 15 Aug 2020 19:29:04 +0100
MIME-Version: 1.0
Content-Language: en-GB
Subject: [Openvpn-devel] 2.5-beta-1 Windows installer problems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I would like to document the very strange issues I had testing the 2.5 
MSI installers.

The first test was on a Win7-Ent/32bit VM with 32bit installer.  The 
second test was a real PC with Win7-HomePro/64bit (yeah, user did not 
want w10) 64bit installer. The third test was Win10/64bit VM 64bit 
installer.

The results were almost identical:

1. Logged in as admin user.
2. Installed over previous installation.
    Completed apparently OK ?
3. On testing the VPN I found that:
    IPv6 worked (could ping both ways)
    IPv4 did not (could not ping either way)
    Firewall disabled. Dual stack VPN.
4. Logged out/Logged in as normal user.
5. OpenVPN Installer forced a re-install of the TAP/wintun drivers.
    The user could select "do not install" but the installer was auto-run.
    The user was *not* prompted for admin password.
6. Using the same VPN config as above, the VPN now functions correctly.

The only difference was that on Win10 I could not test logging back in 
as a standard user because my VM could not be activated.

I do not know where would be the bast place to raise these issues and so 
sent my feedback to the list for further consideration.

Regards
Richard

