From: Arne Schwabe <arne@...1227...>
References: <1489056455-6004-1-git-send-email-steffan.karger@...1435...>
Message-ID: <e36ace28-97ed-bfc7-c1d6-7b778848972b@...1227...>
Date: Thu, 9 Mar 2017 14:04:49 +0100
MIME-Version: 1.0
In-Reply-To: <1489056455-6004-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix types in WIN32
	socket_listen_accept()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net



Am 09.03.17 um 11:47 schrieb Steffan Karger:
> SOCKET_UNDEFINED is of type socket_descriptor_t (or SOCKET, in MS types),
> so new_sd should be too.  Also, the return value of this function is
> always stored in a socket_descriptor_t variable, so it should return that
> type (which makes sense now, because it returns new_sd) instead of an int.
>
>
ACK.

Arne


