MIME-Version: 1.0
In-Reply-To: <5288B114.8020003@...1114...>
References: <20131117104002.GA161@...1296...>
	<5288B114.8020003@...1114...>
Date: Sat, 30 Nov 2013 13:50:49 +0200
Message-ID: <CAFHpkQGZDFo8ov79dg+YmO46T4tc+wOTocu2P8vnhOAkFR9HSA@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] Windows TAP driver and NDIS 6.0
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

I had look at "NDIS 5.1 to NDIS 6.0 migration guide", looks easy
enough, I hope to give a try soon.
also, it is possibility to run tap-driver on WinRT, there's still no
openvpn for WinRT devices, right ?

2013/11/17 David Sommerseth <openvpn.list@...1114...>:
> On 17. nov. 2013 11:40, Gert Doering wrote:
>> Hi,
>>
>> just so it does not get lost: here are the microsoft pages about porting
>> NDIS (miniport) drivers to NDIS 6.0
>>
>> http://msdn.microsoft.com/en-us/library/windows/hardware/ff570025(v=vs.85).aspx
>> http://msdn.microsoft.com/en-us/library/windows/hardware/ff570059(v=vs.85).aspx
>>
>> so, looking for volunteers now :-)
>
> Just to explain a bit further.  WinTAP is currently using the NDIS 5
> API.  If we have understood this correctly, NDIS 5 is on "life support"
> in Vista, Windows 7 and Windows 8 - in the way NDIS 5 drivers are
> running through and emulation layer.   And there is some expectations
> that NDIS 5 support will disappear in Windows 8.2 and later.
>
> It would be good if someone can consider to help out here, so we can get
> an NDIS 6 port in place before NDIS 5 disappears from Windows.
> Otherwise we might end up with a non-working Windows version of OpenVPN.
>
>
> --
> kind regards,
>
> David Sommerseth
>
>
> ------------------------------------------------------------------------------
> DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
> OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
> Free app hosting. Or install the open source package on any LAMP server.
> Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
> http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

