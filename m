Message-ID: <5407D15E.8060300@...1227...>
Date: Wed, 03 Sep 2014 22:41:34 -0400
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <SNT148-W76BE9A56DA884B570B3DCE99C40@...512...>,
	<20140903125713.GF1118@...1296...>
	<SNT148-W43036EEA91281A582656F199C50@...512...>
In-Reply-To: <SNT148-W43036EEA91281A582656F199C50@...512...>
Subject: Re: [Openvpn-devel] [PATCH] kill command with IPv6 client address
 and port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?5by1IOS4luadsA==?= <roy8119425@...160...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 03.09.14 22:36, schrieb 張 世杰:
> Hi Gert,
>
> Thanks for your reply, it's my mistake
> Now my question is how to record the client id every time when a client connected
> Is there a hook in server which will be triggered when a new client connect?
>
> Currently in my application, I parse the result of status 2 to get the IP:port for killing
> But the client id is not a part of status 2 result
> Is there a better way to do this?
>
Newer OpenVPN versions (I don't recall if -master or 2.3.x) have this
information in the status report. For older version you have to record
the ID when a client is connected.

Arne

