From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] [PATCH] self-test updates, fix unterminated loop in BSD jails
Message-ID: <20051107104418.GA14850@...33...>
References: <20051104124852.GA19426@...33...> <Pine.LNX.4.58.0511041241030.13189@...41...>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0511041241030.13189@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Nov  7 02:44:47 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, 04 Nov 2005, James Yonan wrote:

> I've applied this to the 2.0 trunk in the SVN, will apply to 2.1 as well 
> when I do the next 2.0 -> 2.1 merge.

Gee. The jail sysctls aren't consistent across FreeBSD versions, so
expect another update for the legacy FreeBSD 4 in a day or so.

-- 
Matthias Andree

