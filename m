MIME-Version: 1.0
References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
 <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
 <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
In-Reply-To: <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
From: wei wang <lnykww@...277...>
Date: Sat, 20 Apr 2019 16:37:03 +0800
Message-ID: <CAPM6dUBfeuEnfqW59YBNdtRDMhWfSc_9NXSsxuKskPzqK=4qVA@...278...>
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Thanks for your guys reply.

The correct thing is that synchronous authentication increases the
probability of event loss.
But deferred auth is not what we need, we need deferred client-connect actu=
ally.
I have found that the patch set
"https://patchwork.openvpn.net/project/openvpn2/list/?series=3D413" has
implement it.
But it has not been updated for several months. Is there someone still
work on it?  We test with it for client-connect script, and find some
bug.
I am very happy to provide if needed.

=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipit=
sine@...277...> =E4=BA=8E2019=E5=B9=B44=E6=9C=8817=E6=97=A5=E5=91=A8=E4=B8=
=89 =E4=B8=8B=E5=8D=886:24=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =D1=81=D1=80, 17 =D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 15:19, Jan Just =
Keijser <janjust@...1147...>:
>>
>> On 15/04/19 14:29, wei wang wrote:
>> > Hi,
>> >
>> > For function multi_process_io_udp receive many events, but only
>> > process one at a time. Doest it cause the event to be lost?
>> yes it does
>> > In our test, we had create thousands of client. When clients connect
>> > to server at a time, for the clients which already connected on this
>> > server will not receive packet from tun device.
>> that is correct - this is known limitation of  the OpenVPN 2 code base.
>> Fixing this limitation is far from trivial, however.
>
>
> that is true.
>
> however you can choose "deffered" auth mode
> here's example https://github.com/mozilla-it/openvpn_defer_auth
>
>
>>
>>
>> HTH,
>>
>> JJK
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--=20
Regards,
Wang Wei

