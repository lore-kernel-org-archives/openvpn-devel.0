Message-ID: <52C6BB13.30804@...1227...>
Date: Fri, 03 Jan 2014 14:28:51 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>	<52B75C6B.9080100@...1847...>	<52B76494.5010903@...1847...>	<20131223113229.GB161@...1296...>	<52B84C1F.8010500@...1847...>	<CAHqXQkMpp9ayVdfgnyvvFjUy-HcmS0BYO--N_SDEbOUDUE9zbw@...278...>	<52C1ADF7.2050702@...1227...>
	<loom.20140103T122843-610@...171...>
In-Reply-To: <loom.20140103T122843-610@...171...>
Subject: Re: [Openvpn-devel] [PATCH v3] Floating: Add support for floating
 in TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov+openvpn.devel@...277...>, openvpn-devel@lists.sourceforge.net

Am 03.01.14 12:58, schrieb Lev Stipakov:
> Hi Arne,
>
> I am researching how "session id" can be added to packet. Could you pleas=
e=20
> clarify the statement "If we choose the session id to be 3 or 7 byte we=20
> would not need the "hack" for the packets with
> session id." ?
>
> I am currently at very beginning, so questions might look odd.
>
> 1) "3 or 7" - does it mean byte's ordinal number in packet or length of=20
> session id in bytes?
One header byte +3 byte or +7 byte =3D 32 bit aligment.
>
> 2) What you mean by "hack"? Do you mean new packet format or something el=
se?
The byte juggling the compress does.
> 3) I am trying to comprehend protocol format reading=20
> http://openvpn.net/index.php/open-source/documentation/security-
> overview.html and looking at wireshark capture results. Where exactly=20
> session id field should be placed?
Not yet decided :)

Arne


