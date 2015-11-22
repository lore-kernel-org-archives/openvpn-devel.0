MIME-Version: 1.0
In-Reply-To: <20151122131939.GF24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
	<20151121200637.GD24952@...1296...>
	<5650E04B.2020002@...1227...>
	<CAG9MbtJGp9h6TwJAzqqZfai+gNvS5Li+aM4g5vZNrdjxcD5Rgg@...278...>
	<20151122131939.GF24952@...1296...>
Date: Sun, 22 Nov 2015 13:30:40 +0000
Message-ID: <CAG9Mbt+gzhzfNLf25dy-BgyFz85aS3n+_dM61YnBXUW=Nk-Mug@...278...>
From: christian pellegrin <chripell@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, Nov 22, 2015 at 1:19 PM, Gert Doering <gert@...1296...> wrote:
> Could you test the patch suggestion I sent yesterday?  I think your log
> *should* (before the ASSERT) show the "Could not determine IPv4/IPv6
> protocol. Using..." message...


Ack, will do tomorrow and report.

-- 
Christian Pellegrin, see http://www.evolware.org/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

