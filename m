From: "Vladislav Grishenko" <themiron@...2010...>
References: <20201204161436.13448-1-themiron@...2010...>
 <20210330011301.1158-1-themiron@...2010...>
In-Reply-To: <20210330011301.1158-1-themiron@...2010...>
Date: Tue, 30 Mar 2021 06:59:33 +0500
Message-ID: <024a01d72508$551785d0$ff469170$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH v11] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

As discussed, rebased against git master with one change vs v10 - dead inetd
code removal. 
Tested on Windows 10 and Linux, FreeBSD should be fine as well since
previous v10.

We talked about the OpenVPN usage experience at NextHop 2020 conference last
fall and got interested external feedback regarding the SRV feature.
Would be great, if you could kindly suggest when re-review/merge can be
scheduled if no issue found.

--
Best Regards, Vladislav Grishenko



