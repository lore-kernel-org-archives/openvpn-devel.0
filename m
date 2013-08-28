MIME-Version: 1.0
Date: Wed, 28 Aug 2013 17:24:00 +0700
Message-ID: <CAFHpkQEhLwOX4zO=nM4j3zx27w=z0+O1H1m0VYHP=tWV3zgKpA@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: [Openvpn-devel] use of "-no-undefined" in lzo local patch ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello!

I wonder what was the purpose of "-no-undefined" in

src_liblzo2_la_LDFLAGS = -version-info 2:0:0 -no-undefined $(AM_LDFLAGS)



?


I made clean build, captured all output with "script" and
"-no-undefined" is not mentioned there. Most probably, that option was
never used during build process.


Am I right ?


Cheers,
Ilya Shipitsin

