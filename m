Date: Thu, 4 Mar 2010 22:35:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100304213523.GF25238@...1296...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
Mime-Version: 1.0
In-Reply-To: <7cd17813.52db77fa.4b901800.4e59d@...1309...>
Subject: Re: [Openvpn-devel] Openvpn 2.1.1 bad tcp performance but good
	pingwhen -l 1472 (with packet size = MTU)
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
Content-Disposition: inline
To: booyakasha <booyakasha@...1309...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Mar 04, 2010 at 09:28:48PM +0100, booyakasha wrote:
> magic number 2952 (ping ?l 2952). It wasn?t only the 1472 ping
> packet which worked OK. All packets over 2952 are OK !!!  I am
> waiting for your opinions why packets from 1 byte to 2952 bytes
> (without 1472 byes package) are going extremely slowly and others not.

TCP_NODELAY

David has already suggested that you should try setting

  "socket-flags TCP_NODELAY"

- did you?

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

