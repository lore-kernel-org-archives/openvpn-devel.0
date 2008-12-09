Date: Tue, 9 Dec 2008 20:06:38 +0530 (IST)
From: Keyur Pujara <keyurpujara@...293...>
In-Reply-To: <722622.75064.qm@...1154...>
MIME-Version: 1.0
Message-ID: <22886.54984.qm@...1158...>
Subject: [Openvpn-devel] Running Single OpenVPN Daemon on multiple
	(selective) interfaces
Reply-To: keyurpujara@...293...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Greetings!

I have a linux box connected to two ISPs and having two LAN facing interfaces. 

I would like to bind OpenVPN (in TCP mode) on two WAN facing interfaces only (not all). 

I have tried following in server.conf but no success. 

(1) local WAN-1-IP
    local WAN-2-IP
(2) local WAN-1-IP  WAN-2-IP
 
"netstat" just shows binding on one IP. 

I know running two instances (one per interface) may help. 

Would help if someone could comment if there is way to do this by running single instance of daemon. 

Also - if there is no way - would help to know if this support is planned in near future. 

--
Thanks,
Keyur



      


