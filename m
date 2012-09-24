Message-ID: <506098D5.9080902@...1465...>
Date: Mon, 24 Sep 2012 21:31:01 +0400
From: Sergey Matveychuk <sem@...1465...>
MIME-Version: 1.0
References: <1348477246.32678.YahooMailNeo@...1765...>
	<20120924091835.GX742@...1296...>
	<1348480610.66753.YahooMailNeo@...1767...>
	<20120924152024.GA742@...1296...>
In-Reply-To: <20120924152024.GA742@...1296...>
Subject: Re: [Openvpn-devel] multi threading support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

24.09.2012 19:20, Gert Doering wrote:
> Hi,
>
> On Mon, Sep 24, 2012 at 02:56:50AM -0700, ehsan enayati wrote:
>> thanks for your quick reply, I know that openvpn is single threaded but it supports multiple user connection simultaneously, I wanted to know how this is done although it just have one thread.
>
> "by sufficiently advanced magic"
>

The magic is called "multiplexing connections" :)


