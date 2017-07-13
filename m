References: <20170713080527.13299-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8832a0ea-909d-b043-3310-2e3d83c4205a@...1227...>
Date: Thu, 13 Jul 2017 18:20:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170713080527.13299-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] use M_ERRNO instead of explicitly
 printing errno
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <antonio@...515...>

Am 13.07.17 um 10:05 schrieb Antonio Quartulli:
> From: Antonio Quartulli <antonio@...515...>
> 
> the msg() function will print the errno for us when
> provided with the M_ERRNO flag.
> 
> Therefore, don't bother printing errno explicitly and always
> pass M_ERRNO to msg().
> 

ACK and shame on me for the utun ones.

Arne


