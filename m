References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<1467502488-31549-1-git-send-email-selva.nair@...277...>
	<11772d2a-4877-0ed0-2484-7ef66e059737@...1227...>
	<CAKuzo_jjiW9hyVc_+Wo=2aBtAgUmmyOTuLmqCbsq7yq7PCdmGQ@...278...>
	<f94abd87-0113-19c7-12de-745ed1de8e42@...1227...>
	<CAKuzo_iJKTBzc1RSQAhA0qGA8GkJfMkjhdKhcB0SJ0QKbobKqg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ec1d4830-2f67-55c5-9c43-c9e92a9fdef5@...1227...>
Date: Mon, 4 Jul 2016 23:01:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iJKTBzc1RSQAhA0qGA8GkJfMkjhdKhcB0SJ0QKbobKqg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Exponentially back off on repeated
 connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Or do you have tcp-client in mind? In case of tcp-client, before this
> patch, "--connect-retry 0" will hammer the server with repeated
> retries.  That will be avoided as max sec defaults to 300 sec, unless
> the user specifies "--connect-retry 0 0".  Shall we require that the
> second arg to connect-retry should be greater than some minimum, say, at
> least 10 sec? 

No, the TCP-SERVER line there is for p2p mode but with tcp-server. In
p2p mode with p2p the code will also execute that socket-restart code
after the other side will disconnect.

Arne

