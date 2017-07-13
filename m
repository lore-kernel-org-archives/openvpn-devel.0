References: <20170713080527.13299-1-a@...2181...>
	<20170713080527.13299-2-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3e2f1a38-76f8-318f-e3d6-bfee89b1e560@...1227...>
Date: Thu, 13 Jul 2017 18:20:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170713080527.13299-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] don't print errno twice
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
> when passing the M_ERRNO flag to msg(), the latter will already
> print the errno message (in a form of a string and number) for us,
> hence there is no need to explicitly print it a second time.
> 

ACK. Does what it says.

Arne


