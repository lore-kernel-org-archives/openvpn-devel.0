MIME-Version: 1.0
Message-Id: <b3885e07-bc56-40da-925b-5ef0c2d7faaa@...2702...>
In-Reply-To: <c4b46bc4-b953-e2a3-91c0-1a015773306f@...1227...>
References: <69296454-829c-4f6b-a528-a741e8ef96d2@...2702...>
 <c4b46bc4-b953-e2a3-91c0-1a015773306f@...1227...>
Date: Mon, 20 Nov 2023 10:11:36 +0100
From: "Savely Krasovsky" <savely@...2753...>
Subject: Re: [Openvpn-devel] OpenVPN3 thread safety
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Thanks for the reply!

After few days I have found a major bug: a close and free client before sto=
p() successfully executes. After fixing this I didn't get any segfaults any=
more. Program survives very extensive tests. But after your reply I am in q=
uestion again... Sure, openvpn3 has single thread after Connect(), but Go s=
till could call Stop() or any other method from another thread. And still I=
 didn't get any issues at the moment. Should I rewrite it anyway?

=D0=9F=D0=BD, 20.11.2023 =D0=B2 9:55 Arne Schwabe =D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB(=D0=B0):
> Am 12.11.2023 um 14:16 schrieb Savely Krasovsky:
>> Hello!
>>
>> I am trying to use OpenVPN3 with Golang SWIG binding. It works pretty ni=
ce, but I have random segmentation faults without obvious reason. My curren=
t guess is that Golang calls OpenVPN3 from various threads and library is n=
ot ready for that sometime. Am I right? Documentation doesn't say a lot abo=
ut threading.
>>
>> If this is a case, I have two possible solutions:
>>   1. Use OPENVPN_ENABLE_BIGMUTEX build flag (I am not sure I need that).
>>   2. Move all calls to OpenVPN3 into single goroutine and use runtime.Lo=
ckOSThread().
>>
>> Could you please clarify, should I get segfaults in that case or not and=
 the problems is unrelated.
>
>
> Yes. The client is singlethreaded and expects to be called only from a=20
> single thread. You can have multiple clients in multiple threads but all=
=20
> our own software uses just a single thread for the client itself.
>
>
> Arne

--=20
Best regards,
Savely Krasovsky

