Message-ID: <CAD1C3C601B0402284EF1946DDCF6C6C@...1853...>
From: <debbie10t@...277...>
References: <56211F0D.2010806@...515...>
	<2421664.qQJpUDo69u@...1526...><56261F0D.9020208@...515...>
	<1921973.yRGlOPzy2x@...2001...><20151022075000.GD22054@...1296...><SN1PR08MB1391D82901BB0F9F4C8CB5E9B9270@...2065...><20151022173701.GP22054@...1296...><SN1PR08MB13915E4AEE4D1046CE7953AFB9270@...2065...><20151022182439.GS22054@...1296...><SN1PR08MB13916305A3CB7B167CC0B1A7B9270@...2065...><56293AC9.7010702@...1147...><SN1PR08MB1391BB977BF308697478D928B9270@...2065...><CAKuzo_iV6NQJSGWORxLTY4+YLLE8u+ccAHTfVrpJtX0=TVZnWQ@...278...><SN1PR08MB139154DAEBBDDF72D187B1E8B9260@...2065...><CAKuzo_jigkF3R8XcxDaHM6GuKvr=M7y41RVpH8w0XmcdzF2xzg@...278...>
	<SN1PR08MB139196F7C77EBE15084FAD92B9260@...2065...>
Date: Fri, 23 Oct 2015 22:15:13 +0100
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format="flowed"; charset="utf-8"; reply-type="original"
Content-Transfer-Encoding: 8bit
To: "Morris, Russell" <rmorris@...1315...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net


----- Original Message ----- 
From: "Morris, Russell" <rmorris@...1315...>
To: "Selva Nair" <selva.nair@...277...>
Cc: <openvpn-devel@lists.sourceforge.net>
Sent: Friday, October 23, 2015 9:22 PM
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?


> Hi,
>
> Just a bit more on this. I initiated an OpenVPN connection – it connects, 
> says all is happy, except the output from the management interface is,
>
> Ø  STATE:1445605521,CONNECTED,ERROR,,10.138.15.10
>
> And the TAP IP is garbage (169.x.x.x). So I reset the TAP adapter 
> (disable),

Have you enabled the Windows DHCP Client Service ? (Required by OpenVPN)

Regards


