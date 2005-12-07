Content-class: urn:content-classes:message
MIME-Version: 1.0
Message-ID: <EA53A375896E6C429947E9CD56DA7EB892C8AA@...516...>
From: "Jamie Young" <Jamie.Young@...514...>
Subject: [Openvpn-devel] FW: Openvpn bug version 2.0.5 with bonded NICs linux
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Dec  7 10:18:20 2005
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

May be a bug with openvpn and bonded NICs.  Please refer to attached.

Note I am using:
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
eth0: Tigon3


Regards,
=20
Jamie Young
ICT Infrastructure Engineer
Centreport
04 931 0696

-----Original Message-----
From: James Yonan [mailto:jim@...41...]=20
Sent: Wednesday, 7 December 2005 5:29 p.m.
To: Jamie Young
Subject: Re: Openvpn bug version 2.0.5 with bonded NICs linux

It's best to report bugs to openvpn-devel@lists.sourceforge.net

James

Jamie Young wrote:

> I think openvpn doesn't work properly with bonded NICs. Following up=20
> on the email below I broke my bond and the problems I experienced went

> away. Where to raise bugs on your website?
>
> Regards,
>
> Jamie Young
> ICT Infrastructure Engineer
> Centreport
> 04 931 0696
>
>
> _____________________________________________
> *From: * Jamie Young
> *Sent: * Tuesday, 6 December 2005 9:16 a.m.
> *To: * 'info@...515...'
> *Subject: * Issue with version 2.0.5
>
> Hi,
>
> I have configured an openvpn server version 2.0.5 which is working=20
> great on suse 9. However, if I have clients connected and I am logged=20
> into the server itself using ssh to do admin work (not through vpn=20
> itself, just logged in across the LAN) I get connection timeouts and=20
> lots of delay. As soon as I cut off client connectivity the problem=20
> goes away. Any ideas what might be causing this? I am using bonding.
>
> Regards,
>
> Jamie Young
> ICT Infrastructure Engineer
> Centreport
> 04 931 0696
>
> ----------------------------------------------------------------------
> --
> *Caution:*
> This email message and any attachments contain Information that is=20
> CONFIDENTIAL. If you are not the intended recipient, any use,=20
> disclosure or copying of this message or attachments is strictly=20
> prohibited. If you have received this email message in error please=20
> notify itadmin@...514... immediately and erase all copies of=20
> the message and attachments.
> *Thank You.*
>
------------------------------------------------------------------------


###########################################################################=
##########
CAUTION:=20
This email message and any attachments contain Information that is=20
CONFIDENTIAL. If you are not the intended recipient, any use, disclosure or=
 copying=20
of this message or attachments is strictly prohibited. If you have received=
 this=20
email message in error please notify itadmin@...514... immediately and eras=
e=20
all copies of the message and attachments.=20
Thank you.
###########################################################################=
##########

