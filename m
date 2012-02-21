Message-ID: <4F42E51A.1060208@...68...>
Date: Tue, 21 Feb 2012 01:28:10 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <20120207102413.GQ13929@...1296...>
In-Reply-To: <20120207102413.GQ13929@...1296...>
Subject: Re: [Openvpn-devel] configure patch for MacOS 10.7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 07.02.2012 11:24, schrieb Gert Doering:
> Hi,
> 
> I'm forwarding this "as-is", as I do not have enough understanding of
> autoconf to say whether this is necessary, or "the right fix" - but
> anyway, I've been told that this is needed to make our configure 
> behave on MacOS 10.7.

Looks useful at first superficial inspection - haven't tested it though.
 If it breaks, you'll likely notice on the next ./configure run :)

