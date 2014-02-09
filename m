MIME-Version: 1.0
In-Reply-To: <52F7A006.4010302@...1227...>
References: <52F6E3AF.1080400@...1030...>
	<20140209115057.GT16637@...1296...>
	<CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>
	<20140209151951.GU16637@...1296...>
	<52F7A006.4010302@...1227...>
Date: Sun, 9 Feb 2014 17:19:48 +0100
Message-ID: <CAAbSJMWyDjSNdXM6AZPDeevAtR=bBg8C1sbUBY+64hLri2oOLg@...278...>
From: Mickael Chazaux <mickael.chazaux@...277...>
Subject: Re: [Openvpn-devel] --local, --lport and --bind
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2014-02-09 16:34 GMT+01:00 Arne Schwabe <arne@...1227...>:
> Am 09.02.14 16:19, schrieb Gert Doering:
>> Hi,
>>
>> On Sun, Feb 09, 2014 at 02:41:58PM +0100, Mickael Chazaux wrote:
>>> Although it is not easy to find on the Internet, you can bind a client
>>> socket to a specific IP adress, while setting the port as 0, meaning
>>> "choose for me".
>> Ah, good.  So there *is* a "I do not want a specific port" setting.
>>
>> Seems we need to improve documentation :-) (but maybe the new code
>> from Arne that went into 2.4-to-be already does this properly, as in,
>> "not require --lport setting for --bind")
>>
>>
> Does lport 0 work?
>

Yes. I use it (see my previous mail). But it is not documented in
openVPN, and the use of a port value of 0 in bind() hardly. In the
source the --lport value is sent to bind() directly, so it happens to
work. It would be great if --lport 0 were mentioned in the manual, to
avoid breaking this behavior in the future.

Mickael

