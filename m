Date: Mon, 15 Nov 2021 12:53:09 +0100
From: Ruben Herold <ruben@...1302...>
Message-ID: <20211115115309.GA29441@...2643...>
Reply-To: Ruben Herold <ruben@...1302...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Start openvpn gui before windows login
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net


        hi,

at our company we run into problems with domain joined windows notebooks
during lock downs. We realized that there is no way to start openvpn gui 
before windows login to connect to the company network.

I asks our support contact at MS an got the information that this is
only possible via: Universal Windows Platform (UWP) VPN plug-ins.

It should be possible to add external vpn clients like cisco anyconnect:

https://docs.microsoft.com/en-us/windows/security/identity-protection/vpn/vpn-connection-type

"There are a number of Universal Windows Platform VPN applications, such
as Pulse Secure, Cisco AnyConnect, F5 Access, Sonicwall Mobile Connect,
and Check Point Capsule. If you want to use a UWP VPN plug-in, work with
your vendor for any custom settings needed to configure your VPN
solution."

As seen on the screenshoot at:

https://remote-learning.arizona.edu/campus-technology-how-tos/vpn-start-before-logon

It looks like they only start their client gui. 

The only documentation I could get so far is:

https://docs.microsoft.com/en-us/uwp/api/Windows.Networking.Vpn?view=winrt-22000
and this could be an example:

https://github.com/ysc3839/UWPToyVpn

I'm not a developer so I can't proof. But I have some contacts at MS to
ask for more informations if needed. 

I think this could be a very usefull extension to openvpn. 


            Thx

                ruben



-- 
Ruben Herold 
ruben@...1302...

