From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 17 Mar 2014 11:45:15 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90155646CF52@...1436...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140317083335.GB16637@...1296...>
	<1CED409804E2164C8104F9E623B08B90155646CEF6@...1436...>
	<5326D101.1030802@...1114...>
In-Reply-To: <5326D101.1030802@...1114...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in
	SSL	context for OpenSSL builds,
	to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Gert Doering <gert@...1296...>, James Yonan <james@...515...>

Hi,

> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]
> Sent: maandag 17 maart 2014 11:40
> Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
> context for OpenSSL builds, to disable TLS stateless session
> resumption.
>=20
> On 17/03/14 11:08, Steffan Karger wrote:
> > I think this should go into all releases we'll do from now on.
> >
> > Also, ACK on the patch. Together with SSL_SESS_CACHE_OFF, this seems
> > to fully disable TLS session renegotiation and resumption.
>=20
> This patch only covers OpenSSL.  Is there an equivalent for PolarSSL as
> well?  Or isn't it needed at all on PolarSSL?

PolarSSL disables session renegotiation by default (sane defaults ftw!), an=
d OpenVPN does not enable it. So there's nothing to fix for PolarSSL.

-Steffan

