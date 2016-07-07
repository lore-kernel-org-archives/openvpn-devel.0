References: <1467889519-8193-1-git-send-email-openvpn@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <99e1c2b7-3bf4-add5-6218-59a6a630be5d@...1227...>
Date: Thu, 7 Jul 2016 13:11:27 +0200
MIME-Version: 1.0
In-Reply-To: <1467889519-8193-1-git-send-email-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Remove NOP function and callers
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...2145...>



Am 07.07.16 um 13:05 schrieb David Sommerseth:
> From: David Sommerseth <dazo@...2145...>
>
> multi_release_io_lock() and the calls to this function are not providing
> anything at all.  Lets remove it and make the overall code less suprising.
>
>
Easy ACK.

Arne

