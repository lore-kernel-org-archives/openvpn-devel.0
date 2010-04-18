Date: Sun, 18 Apr 2010 15:03:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100418130304.GX12312@...1296...>
References: <1271531169-10293-1-git-send-email-openvpn.list@...1114...>
	<1271531169-10293-2-git-send-email-openvpn.list@...1114...>
Mime-Version: 1.0
In-Reply-To: <1271531169-10293-2-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fixed potential NULL pointer issue
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>, Openvpn-devel@lists.sourceforge.net

Hi,

On Sat, Apr 17, 2010 at 09:06:09PM +0200, David Sommerseth wrote:
> If create_temp_file() returns NULL, this strlen() check would cause
> a SEGV.

Looks "obviously correct".  ACK.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

