From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 8 Jul 2011 08:56:46 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B90126A219DE6@...1436...>
References: <4E12BE97.3000308@...1432...>
	<4E130E87.4070202@...1114...>
	<4E14939F.9020708@...1432...>
	<CAHyOtR=A9sRg8KduA_3hGD=7kAsNMF-RtJBcK5SNuf6c3boxAg@...278...>
	<4E16A695.6050008@...1432...>
In-Reply-To: <4E16A695.6050008@...1432...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Bug: extended x509-username-field broken in git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Markus_K=F6tter?= <koetter@...1432...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Markus K=F6tter [mailto:koetter@...1432...]
>=20
> On 07/07/2011 09:06 PM, Adriaan de Jong wrote:
> > A fix is included in my SSL separation patch set, in this patch to be
> > exact:
> > https://github.com/andj/openvpn-ssl-
> refactoring/commit/71e27b1e282bf8e10724b69fe4cbeac65dee325b .
> >
> >
> > Does that solve the problem?
>=20
> The logic should be fixed yes.
> Remaining question is why does openvpn even try to retrieve values from
> upper cert layers - they'll be overwritten anyway.
=20
The information is provided to scripts and plugins in environment variables=
, so that additional verification can be performed there.

Regards,
Adriaan

