From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 17 Mar 2014 11:08:24 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90155646CEF6@...1436...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140317083335.GB16637@...1296...>
In-Reply-To: <20140317083335.GB16637@...1296...>
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
To: Gert Doering <gert@...1296...>, James Yonan <james@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
> Sent: maandag 17 maart 2014 9:34
> Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
> context for OpenSSL builds, to disable TLS stateless session
> resumption.
>=20
> Hi,
>=20
> On Sun, Mar 16, 2014 at 06:49:36PM -0600, James Yonan wrote:
> > OpenVPN doesn't want or need SSL session renegotiation or resumption,
> > as it handles renegotiation on its own.
> >
> > For this reason, OpenVPN always disables the SSL session cache:
> >
> > SSL_CTX_set_session_cache_mode (ctx, SSL_SESS_CACHE_OFF)
> >
> > However, even with the above code, stateless session resumption is
> > still possible unless explicitly disabled with the SSL_OP_NO_TICKET
> > flag.  This patch does this.
>=20
> I assume this should go into all OpenVPN branches, that is, master,
> 2.3, and if we ever do another 2.2, into that one as well?
>=20
> (not ACKing or NAKing the patch itself, this is not my field of
> expertise)

I think this should go into all releases we'll do from now on.

Also, ACK on the patch. Together with SSL_SESS_CACHE_OFF, this seems to ful=
ly disable TLS session renegotiation and resumption.

-Steffan

