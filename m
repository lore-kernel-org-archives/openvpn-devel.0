MIME-Version: 1.0
Date: Thu, 22 Dec 2011 08:44:05 +0100
From: michael-dev <michael-dev@...1528...>
In-Reply-To: <4EE0EDA4.2090704@...1338...>
References: "<d3f7c10b2411aa41afce3788970ca839@...1528...>"
	<4EE08E3A.7010209@...1114...>
	<CAOazyz1MCx8x42YK6-fQs0iAzDS0kRLvZ1sw4hvmcZ4gikJrUA@...278...>
	<4EE0EDA4.2090704@...1338...>
Message-ID: <791d427732dff3d334ee0d812c7f68bb@...1528...>
Subject: Re: [Openvpn-devel]
 =?utf-8?q?=5BPATCH=5D_Add_option_to_disable_prior?=
 =?utf-8?q?ity_tagged_packets_=28VID=3D0=29?=
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: alon.barlev@...277..., davids@...1347..., openvpn-devel@lists.sourceforge.net

Hi,

the usage here is with the FeM e.V. [1] WLAN project in order to reuse 
the existing vlans and ip assignments on them.

> And Michael, would you be willing to review and test the full, 
> rebased patch-set [...]?

Testing should be no problem. I currently use a gentoo ebuild that 
points to the git feature branch + patches
so that part should be easy. Further, the openvpn server here is 
currently testing only (until the wlan gets ready)
so I'm free to break it again ;). But I might need some time to put it 
into the schedule.

Regards,
  M. Braun
--
[1] http://www.fem.tu-ilmenau.de/


