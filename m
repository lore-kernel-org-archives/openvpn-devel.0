MIME-Version: 1.0
In-Reply-To: <CAOazyz1OjVKEq5+0BcAgS9PVPcs77oJemG+kD3S7ZZUv+TiAEg@...278...>
References: <1329214286-9179-1-git-send-email-dejong@...1435...>
	<4F761FEC.1000502@...1114...>
	<CAOazyz1OjVKEq5+0BcAgS9PVPcs77oJemG+kD3S7ZZUv+TiAEg@...278...>
Date: Sun, 1 Apr 2012 16:47:52 +0300
Message-ID: <CAOazyz04ByDHiug6-dVqoP5aO78jimUiKiNgHNb6OW2WLTJjeA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Use the garbage collector when
 retrieving x509 fields
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

I sent candidate. Please review.

On Sat, Mar 31, 2012 at 1:51 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Hm.... I missed that one.
>
> I don't like this patch...
>
> the gc_new() and gc_free() should be called once per function at
> prolog and epilog. This is the whole point of gc, otherwise there is
> no difference between it and simple malloc.
>
> So:
> 1. in pkcs11.c it should be moved out of the loop.
> 2. In verify_cert, verify_callback we should add cleanup label.
>
> Alon.
>
> On Sat, Mar 31, 2012 at 12:04 AM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> On 14/02/12 11:11, Adriaan de Jong wrote:
>>> A number of the x509 functions allocated memory directly, instead of
>>> using the default OpenVPN convention: the garbage collector. This is
>>> fixed in this series of patches.
>>>
>>> Adriaan
>>
>> These patches got ACKed by James and me at the developers meeting
>> yesterday. =C2=A0They are now applied to the master branch on -testing a=
nd
>> -stable trees.
>>
>>
>> commit 8e5613c2a8545a67cab2734569a8f088100d731b
>> Author: Adriaan de Jong <dejong@...1435...>
>> Date: =C2=A0 Tue Feb 14 11:11:26 2012 +0100
>>
>> =C2=A0 =C2=A0Migrated x509_get_sha1_hash to use the garbage collector
>>
>> =C2=A0 =C2=A0Signed-off-by: Adriaan de Jong <dejong@...1435...>
>> =C2=A0 =C2=A0Acked-by: James Yonan <james@...515...>
>> =C2=A0 =C2=A0Acked-by: David Sommerseth <davids@...1347...>
>> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <davids@...1347...>
>>
>> commit 025f30d7c6434aaf0ab4af3744f76aaf8c0b71d6
>> Author: Adriaan de Jong <dejong@...1435...>
>> Date: =C2=A0 Tue Feb 14 11:11:25 2012 +0100
>>
>> =C2=A0 =C2=A0Migrated x509_get_serial to use the garbage collector
>>
>> =C2=A0 =C2=A0Signed-off-by: Adriaan de Jong <dejong@...1435...>
>> =C2=A0 =C2=A0Acked-by: James Yonan <james@...515...>
>> =C2=A0 =C2=A0Acked-by: David Sommerseth <davids@...1347...>
>> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <davids@...1347...>
>>
>> commit 00b973f8af85c3ea8fa3cef80eec55e8dc139b27
>> Author: Adriaan de Jong <dejong@...1435...>
>> Date: =C2=A0 Tue Feb 14 11:11:24 2012 +0100
>>
>> =C2=A0 =C2=A0Migrated x509_get_subject to use of the garbage collector
>>
>> =C2=A0 =C2=A0This also cleans up a messy call in pkcs11.c to
>> _openssl_get_subject, as discussed at FOSDEM.
>>
>> =C2=A0 =C2=A0Signed-off-by: Adriaan de Jong <dejong@...1435...>
>> =C2=A0 =C2=A0Acked-by: James Yonan <james@...515...>
>> =C2=A0 =C2=A0Acked-by: David Sommerseth <davids@...1347...>
>> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <davids@...1347...>
>>
>>
>> kind regards,
>>
>> David Sommerseth
>>
>>
>> ------------------------------------------------------------------------=
------
>> This SF email is sponsosred by:
>> Try Windows Azure free for 90 days Click Here
>> http://p.sf.net/sfu/sfd2d-msazure
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>

