Message-ID: <9F7E042146FF4C9E896F23DB80BE0330@...2089...>
From: <debbie10t@...277...>
Date: Mon, 4 Jan 2016 23:51:29 -0000
MIME-Version: 1.0
Subject: [Openvpn-devel] ics-openvpn - route not added ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

having read this about ics-openvpn :

https://github.com/schwabe/ics-openvpn/blob/master/doc/README.txt

I decided I was not in a position to add any further comments to this:

https://forums.openvpn.net/topic20654.html#p57367

So I thought to ask if Arne could add any thing

The gist is that: the server & client are connecting ok
but the server LAN is not being added to the client RT
even though the route is successfully pushed.

Specific versions are:

official build 0.6.46 running on samsung SM-G900F (MSM8974), Android 5.0
(LRX21T) API 21, ABI armeabi-v7a,
(samsung/kltexx/klte:5.0/LRX21T/G900FXXU1BOJ1:user/release-keys)

and

OpenVPN 2.4-icsopenvpn [git:icsopenvpn_645-e6b5e62e37c02d5b]
android-14-armeabi-v7a [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH] [IPv6] built
on Dec  8 2015


My presumption is .. this is not a version we support ?

Thanks


