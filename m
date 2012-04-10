Message-ID: <4F83DBD1.3080905@...1458...>
Date: Tue, 10 Apr 2012 09:05:53 +0200
From: Seth Mos <seth.mos@...1458...>
MIME-Version: 1.0
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
	<CAOazyz0MDBg75y+CRdYNEOdYBE83B_pYfZ3pz+JLyUdAyF6xgQ@...278...>
	<CAP+U6tK3UHd=KR1th0vxdLnRUsZm47qKgk=BeNgzSmvYUFMdvw@...278...>
	<4F797A66.8050502@...1114...>
	<CAOazyz0uhi_ao2SN3Moi+tXRVhaJPd-O1eam0tqLo_6rehVREg@...278...>
	<4F7981C4.80409@...1114...>
	<CAOazyz1eV7V7aB9WFr0LwJM-dyegeK1wyeLXJQAoDTB+J02E3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012CB842337@...1436...>
	<20120406175525.GH1359@...1296...>
In-Reply-To: <20120406175525.GH1359@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
 RNG
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

Op 6-4-2012 19:55, Gert Doering schreef:
> Hi,
>
> On Mon, Apr 02, 2012 at 07:31:56PM +0200, Adriaan de Jong wrote:
>> I don't see the need to further delay 2.3 for this, as it is not
>> a bug fix. Others might disagree here, and the topic is open for
>> debate :). In general, it might be a good idea to freeze development
>> of 2.3 at some point to prevent endless alpha syndrome.
>
> I'm with Adriaan on this.  I want 2.3 *out*, and *soon* - people are
> waiting for an OpenVPN release with IPv6 support.

*Seth from the pfSense project raises his hand.

We currently ship pfSense 2.0 and 2.1 with a one off patched install 
that is basically 2.2 with patches from Gert and jjo.

If all goes well we hope to have pfSense 2.1 in Beta next month in time 
for World IPv6 day. Really hoping we can ship with something newer then 
2.2+patches. Although it does appear to be holding up so far.

The release of OpenVPN 2.3 is critical, because the state of the clients 
so far has been poor. Only the native clients works, and neither 
Viscosity or Tunnelblick currently works. (in tun mode).

Regards,

Seth

