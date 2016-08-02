From: debbie10t <debbie10t@...277...>
Message-ID: <57A078C9.6030309@...277...>
Date: Tue, 2 Aug 2016 11:41:13 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel]  Auto-create Windows Firewall Rule
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

I have been installing various versions of openvpn to Windows 10
and I discovered two firewall rules called "Openvpn daemon" which
allows incoming connections to a server being run on the host.

Unfortunately, I do *not* remember creating these rules myself ..

So, I deleted the rules and re-installed various versions again,
including 2.3.11-i601 and a snapshot of git master (20160518)
but the rule was *not* recreated.

Is creating this rule part of the installation or did I just
forget what I had done ?

The reason I ask is because I did *not* see any check-box etc
to inform me that the rule will be created during installation.

Thanks


