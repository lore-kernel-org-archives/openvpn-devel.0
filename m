Message-ID: <34084543aaf50252f6b2749cb0206d9e.squirrel@...2260...>
In-Reply-To: <E1lRfR7-0007jN-Go@...2479...>
References: <E1lRfR7-0007jN-Go@...2479...>
Date: Wed, 31 Mar 2021 21:39:21 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 0/1] reliable: retransmit if 3 follow-up
 ACKs are received
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

> This is my second attempt at sending this patch, this time without
> mixing up commit message and cover letter, and from an account that
> (I hope) doesn't hate mailing lists.
>
> This patch changes reliable_send() to resend a packet if at least three
> later packets have been ACKed. This improves performance when there are
> small amounts of packet loss.
>
> The patch was originally written by Steffan Karger for OpenVPN-NL.
> I added some comments as suggested by Arne Schwabe.
>
> Steffan Karger (1):
>   reliable: retransmit if 3 follow-up ACKs are received
>

Hi Max,

Just a shy question, am I right that this will work with UDP connections?

If so then I'm interested to test it.

Regards,
Simon


