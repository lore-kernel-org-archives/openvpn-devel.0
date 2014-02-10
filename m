Message-ID: <52F8981A.7030603@...1030...>
Date: Mon, 10 Feb 2014 09:12:58 +0000
From: Dash Four <mr.dash.four@...1030...>
MIME-Version: 1.0
References: <52F6E3AF.1080400@...1030...>	<20140209115057.GT16637@...1296...>	<CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>	<20140209151951.GU16637@...1296...>	<52F7A006.4010302@...1227...>	<CAAbSJMWyDjSNdXM6AZPDeevAtR=bBg8C1sbUBY+64hLri2oOLg@...278...>
	<52F7AB7E.7000502@...1227...>
In-Reply-To: <52F7AB7E.7000502@...1227...>
Subject: Re: [Openvpn-devel] --local, --lport and --bind
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Arne Schwabe wrote:
>>> Does lport 0 work?
>>>
>>>       
>> Yes. I use it (see my previous mail). But it is not documented in
>> openVPN, and the use of a port value of 0 in bind() hardly. In the
>> source the --lport value is sent to bind() directly, so it happens to
>> work. It would be great if --lport 0 were mentioned in the manual, to
>> avoid breaking this behavior in the future.
>>
>>
>>     
> I might alread have broken this. I am not sure how getaddrinfo reacts to
> "0" instead of NULL of servname.
>   
So, can I use this undocumented option to allow the OS to determine a 
random port for me?


