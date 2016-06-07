MIME-Version: 1.0
In-Reply-To: <CAFHpkQEjE6vmRm3-Mq_9i3A2w5TrcJ4rasxoZwf00W+sPh3DDQ@...278...>
References: <CAFHpkQFkm-6FUUs8DN63UKKHCPHZBmLDK1fk60xaycUk3K5GSQ@...278...>
	<CAFHpkQEjE6vmRm3-Mq_9i3A2w5TrcJ4rasxoZwf00W+sPh3DDQ@...278...>
Date: Tue, 7 Jun 2016 18:47:09 +0500
Message-ID: <CAFHpkQEt1tH5yPY-9=G6YRuardSBM7CtsDLOHd71JHHUQBtOwQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a114e35b0eec08f0534b06c94
Subject: [Openvpn-devel] Valgring findings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a114e35b0eec08f0534b06c94
Content-Type: text/plain; charset=UTF-8

Hello,

I played with valgrind a bit

https://travis-ci.org/chipitsine/openvpn/jobs/135869065

Looks like there are leaks in openssl code, should we suppress it?

Cheers,
Ilya Shipitsin

--001a114e35b0eec08f0534b06c94
Content-Type: text/html; charset=UTF-8

<p dir="ltr">Hello,</p>
<p dir="ltr">I played with valgrind a bit</p>
<p dir="ltr"><a href="https://travis-ci.org/chipitsine/openvpn/jobs/135869065">https://travis-ci.org/chipitsine/openvpn/jobs/135869065</a></p>
<p dir="ltr">Looks like there are leaks in openssl code, should we suppress it?</p>
<p dir="ltr">Cheers,<br>
Ilya Shipitsin</p>

--001a114e35b0eec08f0534b06c94--

