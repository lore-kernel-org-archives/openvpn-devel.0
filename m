From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
Message-ID: <20050422071247.GA13077@...33...>
References: <20050420091539.C21450@...283...> <Pine.LNX.4.58.0504201125560.14131@...41...> <20050420141742.B1503@...283...> <Pine.LNX.4.58.0504211811260.14131@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0504211811260.14131@...41...>
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
Date: Fri Apr 22 00:14:02 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 21 Apr 2005, James Yonan wrote:

> I would like to merge your IPv6 patch into the 2.1 branch, once it gets 
> started (I'd like to keep the 2.0.x branch as stable as possible, with 
> minimalistic changes that don't go beyond bug fixes and small patches).

Speaking of branches; I have updated the FreeBSD OpenVPN 1.6 port to
2.0, overthrowing requests to keep the 1.6 port around and start a new
openvpn2 port instead, on the assumption that OpenVPN 2.0 is in the same
line as 1.6 was in my perception, and not a separate branch, and I've
assumed that we won't see further 1.6 branches. Was this correct?

Would you think it's important to keep an "openvpn16" port (at 1.6.0)
available or is 2.0 sufficient? I'd think 2.0 is sufficient as it's a
really smooth upgrade from 1.6 (the FreeBSD port hasn't dared use
pthreads since FreeBSD 4 has had three competing thread models for a
long time - so we're not losing this feature in the FreeBSD port).

Thank you for your great work on OpenVPN 2.0.

-- 
Matthias Andree

