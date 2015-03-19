Message-ID: <550B4623.6000609@...1490...>
Date: Fri, 20 Mar 2015 10:56:51 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <AMSPR07MB232F26EA163FA5FB6ACEA0EC1010@...2021...>
	<550AD5A3.9040201@...515...>
In-Reply-To: <550AD5A3.9040201@...515...>
Subject: Re: [Openvpn-devel] OpenVPN Service Windows 8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Unless other changes have been made to the windows service, I'd
recommend not using it at all. There are error conditions under which it
just hangs and blocks openvpn.exe from working

We moved to using nssm - we set it to auto-restart on error and now
openvpn as a Windows service is as reliable as openvpn as a Unix service

Jason

-- 
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


