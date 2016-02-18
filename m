From: "Fish Wang" <fish.thss@...277...>
References: <56C5C6F7.1020903@...277...>	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
	<56C5EE36.5080906@...277...>
In-Reply-To: <56C5EE36.5080906@...277...>
Date: Thu, 18 Feb 2016 11:55:58 -0500
Message-ID: <007901d16a6d$3e9f1e90$bbdd5bb0$@gmail.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] Has openvpn been fuzzed?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: 'Jacek Wielemborek' <d33tah@...277...>, 'Steffan Karger' <steffan@...1856...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

Hi Jacek,

I'm definitely no expert in AFL, but it's a great tool that has shown great=
 potential.

> ... it would be good
> to modify the server to use stdin/stdout (or dev null) for network I/O

You might want to try https://github.com/zardus/preeny .

Best,
Fish


