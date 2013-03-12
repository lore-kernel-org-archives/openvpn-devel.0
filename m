From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 12 Mar 2013 09:32:36 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B8D6EDA6@...1436...>
References: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
	<1363032625-23311-1-git-send-email-gert@...1296...>
	<513E4DEB.7000403@...1227...>
In-Reply-To: <513E4DEB.7000403@...1227...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Repair "tcp server queue overflow"
 brokenness, more <stdbool.h> fallout.
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
To: Arne Schwabe <arne@...1227...>, "gert@...1296..." <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Shouldn't the return type be size_t or at least unsigned int, as mbuf->len =
is also of type unsigned int?

-Steffan

-----Original Message-----
From: Arne Schwabe [mailto:arne@...1227...]=20
Sent: maandag 11 maart 2013 22:35
To: gert@...1296...; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] Repair "tcp server queue overflow" bro=
kenness, more <stdbool.h> fallout.

On 11.03.2013 21:10, gert@...1296... wrote:
> From: Gert Doering <gert@...1296...>
>
> Return value of mbuf_len() wrong - it's returning a length value, not=20
> a yes/no value - so when the queue length approached 65 (full!), it=20
> still only returned "1", leading to MBUF overflow later on.  Change=20
> from "bool" to "int", misbehaviour gone...
>
>
ACK. I did not check if that fixes the issue but the change is correct.

Arne

---------------------------------------------------------------------------=
---
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the end=
point security space. For insight on selecting the right partner to tackle =
endpoint security challenges, access the full report.=20
http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

