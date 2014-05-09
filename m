Message-ID: <536C2D4E.5090708@...1839...>
Date: Thu, 08 May 2014 18:20:14 -0700
From: "Kalnozols, Andris" <andris@...1839...>
MIME-Version: 1.0
References: <536ADECA.8040807@...1839...> <536B10C1.9090700@...1147...>
	<536B1EE4.8010109@...1839...> <536B67B4.2000800@...1147...>
In-Reply-To: <536B67B4.2000800@...1147...>
Subject: Re: [Openvpn-devel] Questionable restriction in
	--x509-username-field
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net



On 5/8/2014 4:17 AM, Jan Just Keijser wrote:
> Hi Andris,
> 
> I would consider this a bug, as you are indeed not able to specify
> something like 'emailAddress' as a x509-username parameter.
> Personally I would like to remove the 'toupper' line altogether, but
> from a usability point of view this is probably not possible - it might
> break existing installations.
> 
> cheers,
> 
> JJK

Thanks again, Jan, for your consultation.  I have filed a bug report
on OpenVPN's tracking system:

  https://community.openvpn.net/openvpn/ticket/402

Regards,
Andris

