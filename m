From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] openvpn for the palm
In-Reply-To: <1109592455.10523.7.camel@...23...>
Message-ID: <Pine.LNX.4.58.0502281147170.23437@...41...>
References: <1109592455.10523.7.camel@...23...>
MIME-Version: 1.0
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
Date: Mon Feb 28 10:53:02 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Gerd Mueller <gmueller@...279...>
Cc: Openvpn-devel@lists.sourceforge.net

On Mon, 28 Feb 2005, Gerd Mueller wrote:

> Hi all,
> 
> I wonder if there are any attempts to port openvpn to the palm. I got
> now the wonderful treo 650 and would like to have openvpn on it. Do you
> think it's much work to port it? The palms support IP, SSL, ... I guess
> everything what is needed should be there.

OpenVPN needs a TUN/TAP virtual network driver.

The OpenSSL library is also required.

James

