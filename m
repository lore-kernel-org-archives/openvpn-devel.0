Date: Fri, 5 Mar 2010 09:01:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100305080138.GG25238@...1296...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<4B8BB647.2020804@...1114...>
	<23627cf8.610acd4b.4b8bc540.d2023@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
	<20100304213523.GF25238@...1296...>
	<1267744903417725500@...1315...>
Mime-Version: 1.0
In-Reply-To: <1267744903417725500@...1315...>
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
To: openvpn@...1315...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Thu, Mar 04, 2010 at 05:21:43PM -0600, openvpn@...1315... wrote:
> I did this in the client configuration file ... is this right?
> I checked the OpenVPN web site, and it may be that I need this on
> the server side instead. Please clarify and I'll try it again (if
> I need to).

"socket-flags TCP_NODELAY"

that would need to go into both(!) config files - it changes the way the
operating system handles write() calls into a socket, that is, whether
the OS waits for "more data" to eventually generate a full sized packet,
or whether it will send the data immediately (generating a small packet).

(This is a fundamental problem with TCP - the stacks are optimized for
certain patterns, either "bulk data, make full size packets" or 
"interactive traffic, send single bytes of keystrokes, where a few ms
delay don't hurt", but not for VPN-like traffic)

gert

-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

