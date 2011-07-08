Message-ID: <4E16AC8B.8020101@...1432...>
Date: Fri, 08 Jul 2011 09:06:51 +0200
From: =?ISO-8859-1?Q?Markus_K=F6tter?=
 <koetter@...1432...>
MIME-Version: 1.0
References: <4E12BE97.3000308@...1432...>	<4E130E87.4070202@...1114...>	<4E14939F.9020708@...1432...>	<CAHyOtR=A9sRg8KduA_3hGD=7kAsNMF-RtJBcK5SNuf6c3boxAg@...278...>
	<4E16A695.6050008@...1432...>
	<1CED409804E2164C8104F9E623B08B90126A219DE6@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B90126A219DE6@...1436...>
Subject: Re: [Openvpn-devel] Bug: extended x509-username-field broken in git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 07/08/2011 08:56 AM, Adriaan de Jong wrote:
>> -----Original Message-----
>> From: Markus K=F6tter [mailto:koetter@...1432...]
>> Remaining question is why does openvpn even try to retrieve values from
>> upper cert layers - they'll be overwritten anyway.
>
> The information is provided to scripts and plugins in environment variabl=
es, so that additional verification can be performed there.

Maybe we got a misunderstanding:

Question is what would be wrong with:

if( !cert_depth && verify_get_username(..) )
   err();


Markus

